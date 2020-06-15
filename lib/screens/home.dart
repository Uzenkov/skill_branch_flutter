import 'dart:async';

import 'package:FlutterGalleryApp/app.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../res/res.dart';
import '../screens/feed_screen.dart';

class Home extends StatefulWidget {
  final Stream<ConnectivityResult> onConnectivityChanged;

  Home(this.onConnectivityChanged);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int currentTab = 0;
  StreamSubscription subscription;
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> pages = [
    Feed(key: PageStorageKey('FeedPage')),
    Container(),
    Container(),
  ];

  final List<BottomNavyBarItem> _tabs = [
    BottomNavyBarItem(title: const Text('Feed')),
    BottomNavyBarItem(title: const Text('Search')),
    BottomNavyBarItem(title: const Text('User')),
  ];

  @override
  void initState() {
    super.initState();

    subscription =
        widget.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.mobile:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.none:
          Widget widget = Center(
            child: Material(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.redAccent,
                child: Text(
                  'No internet connection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
          ConnectivityOverlay().showOverlay(context, widget);
          break;
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 8,
        curve: Curves.ease,
        items: _tabs,
        currentTab: currentTab,
        onItemSelected: (index) {
          setState(() {
            currentTab = index;
          });
        },
      ),
      body: PageStorage(
        child: pages[currentTab],
        bucket: bucket,
      ),
    );
  }
}

class BottomNavyBar extends StatelessWidget {
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final MainAxisAlignment mainAxisAlignment;
  final int currentTab;
  final Duration animationDuration;
  final double itemCornerRadius;
  final Curve curve;

  BottomNavyBar({
    @required this.items,
    @required this.onItemSelected,
    this.backgroundColor = Colors.white,
    this.showElevation = true,
    this.containerHeight = 56,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.currentTab,
    this.animationDuration = const Duration(milliseconds: 270),
    this.itemCornerRadius = 50,
    this.curve,
    Key key,
  })  : assert(items != null),
        assert(items.length >= 2 && items.length <= 5),
        assert(onItemSelected != null),
        assert(curve != null),
        super(key: key);

  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(color: Colors.black12, blurRadius: 2),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              final index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  isSelected: currentTab == index,
                  item: item,
                  backgroundColor: bgColor,
                  animationDuration: animationDuration,
                  itemCornerRadius: itemCornerRadius,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double itemCornerRadius;

  const _ItemWidget({
    @required this.isSelected,
    @required this.item,
    @required this.backgroundColor,
    @required this.animationDuration,
    @required this.itemCornerRadius,
    this.curve = Curves.linear,
    Key key,
  })  : assert(isSelected != null, 'isSelected is null!'),
        assert(item != null, 'item is null!'),
        assert(backgroundColor != null, 'backgroundColor is null!'),
        assert(animationDuration != null, 'animationDuration is null!'),
        assert(itemCornerRadius != null, 'itemCornerRadius is null!'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 36,
      width: isSelected
          ? 150
          : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      curve: curve,
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.circular(itemCornerRadius),
      ),
      child: Container(
        width: isSelected
            ? 150
            : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              item.asset,
              size: 20,
              color: isSelected ? item.activeColor : item.inactiveColor,
            ),
            SizedBox(width: 4),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: DefaultTextStyle.merge(
                  child: item.title,
                  textAlign: item.textAlign,
                  maxLines: 1,
                  style: TextStyle(
                    color: isSelected ? item.activeColor : item.inactiveColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;

  BottomNavyBarItem(
      {this.asset = AppIcons.home,
      this.title,
      this.activeColor = AppColors.dodgerBlue,
      this.inactiveColor = AppColors.manatee,
      this.textAlign}) {
    // assert called only in debug mode
    assert(asset != null, 'Asset is null!');
    assert(title != null, 'Title is null!');
  }
}
