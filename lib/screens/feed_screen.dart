import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/material.dart';

import '../res/res.dart';
import '../widgets/widgets.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                _buildItem(),
                Divider(
                  thickness: 2,
                  color: AppColors.mercury,
                )
              ],
            );
          },
        ),
      );

  Widget _buildItem() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullScreenImage(
                    photo: kFlutterDash,
                    altDescription: 'This is the Flutter\'s logo',
                    name: 'Kirill Adeshchenko',
                    userName: 'kaparray',
                  ),
                ),
              );
            },
            child: Photo(
              photoLink: kFlutterDash,
            ),
          ),
          _buildPhotoMeta(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Text(
              'This is the Flutter\'s logo',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.h3.copyWith(color: AppColors.black),
            ),
          ),
        ],
      );

  Widget _buildPhotoMeta() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                UserAvatar(
                    'https://skill-branch.ru/img/speakers/Adechenko.jpg'),
                SizedBox(width: 6),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Kirill Adeshchenko', style: AppStyles.h2Black),
                    Text('@kaparray',
                        style: AppStyles.h5Black
                            .copyWith(color: AppColors.manatee)),
                  ],
                ),
              ],
            ),
            LikeButton(
              likeCount: 10,
              isLiked: true,
            ),
          ],
        ),
      );
}
