import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../res/res.dart';

class Photo extends StatelessWidget {
  Photo({Key key, this.photoLink}) : super(key: key);

  final photoLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(17.0)),
        child: Container(
          color: AppColors.grayChateau,
          child: CachedNetworkImage(
            imageUrl: photoLink,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
