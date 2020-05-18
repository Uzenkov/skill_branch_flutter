import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../res/res.dart';
import '../widgets/widgets.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    this.photo = '',
    this.altDescription = '',
    this.name = '',
    this.userName = '',
    this.heroTag = '',
    Key key,
  }) : super(key: key);

  final String photo;
  final String altDescription;
  final String name;
  final String userName;
  final String heroTag;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> avatarOpacity;
  Animation<double> userInfoOpacity;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    avatarOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    userInfoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.5,
          1,
          curve: Curves.ease,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: widget.heroTag,
            child: Photo(photoLink: widget.photo),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Text(
              widget.altDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3,
            ),
          ),
          _buildPhotoMeta(widget.name, widget.userName),
          _buildLikeAndButton(),
        ],
      ),
    );
  }

  Widget _buildPhotoMeta(String name, String username) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Opacity(
                    opacity: avatarOpacity.value,
                    child: UserAvatar(
                        'https://skill-branch.ru/img/speakers/Adechenko.jpg'),
                  ),
                  SizedBox(width: 6),
                  Opacity(
                    opacity: userInfoOpacity.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          name != null ? name : '',
                          style: AppStyles.h1Black,
                        ),
                        Text(
                          username != null ? '@${username}' : '',
                          style: AppStyles.h5Black.copyWith(
                            color: AppColors.manatee,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLikeAndButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: LikeButton(
              likeCount: 10,
              isLiked: true,
            ),
          ),
        ),
        Expanded(
          child: Button(
            color: AppColors.dodgerBlue,
            text: 'Save',
            onPress: () {},
          ),
        ),
        Expanded(
          child: Button(
            color: AppColors.dodgerBlue,
            text: 'Visit',
            onPress: () {},
          ),
        )
      ],
    );
  }
}

class Button extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPress;

  Button({@required this.color, this.text, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text,
              style: AppStyles.h5Black.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
