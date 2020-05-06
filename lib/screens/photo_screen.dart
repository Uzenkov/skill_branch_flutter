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
    Key key,
  }) : super(key: key);

  final String photo;
  final String altDescription;
  final String name;
  final String userName;

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
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
          Photo(
            photoLink: widget.photo,
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

  Widget _buildPhotoMeta(String name, String nikName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
              SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name != null ? name : '',
                    style: AppStyles.h1Black,
                  ),
                  Text(
                    nikName != null ? '@${nikName}' : '',
                    style: AppStyles.h5Black.copyWith(
                      color: AppColors.manatee,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
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
