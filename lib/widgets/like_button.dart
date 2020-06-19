import 'package:flutter/material.dart';

import '../res/app_icons.dart';

class LikeButton extends StatefulWidget {
  LikeButton({this.likeCount, this.isLiked, Key key}) : super(key: key);

  final int likeCount;
  final bool isLiked;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  int likeCount;
  bool isLiked;

  @override
  void initState() {
    super.initState();
    likeCount = widget.likeCount;
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            likeCount++;
          } else {
            likeCount--;
          }
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(likeCount.toString()),
              SizedBox(width: 4.0),
              Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
            ],
          ),
        ),
      ),
    );
  }
}
