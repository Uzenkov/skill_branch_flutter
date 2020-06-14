import 'package:flutter/material.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> categories = [
    'adult',
    'harm',
    'bully',
    'spam',
    'copyright',
    'hate',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () => Navigator.pop(context),
          child: ListTile(
            title: Text(
              categories[index],
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
