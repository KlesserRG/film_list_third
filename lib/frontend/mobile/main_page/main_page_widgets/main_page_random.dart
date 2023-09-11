import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/backend/hive/film_item_type_boxes.dart';
import 'package:flutter/material.dart';

class MainPageRandom extends StatefulWidget {
  const MainPageRandom({super.key});

  @override
  State<MainPageRandom> createState() => _MainPageRandomState();
}

/*
  Небольшой выскакивающий баннер для рандомизации.
*/

class _MainPageRandomState extends State<MainPageRandom> {
  @override
  Widget build(BuildContext context) {
    String randomTitle() {
      List<FilmItemType> data = HiveBoxes.filmItemType.values.toList();
      String title = data[Random().nextInt(data.length)].title;
      return title;
    }

    String title = randomTitle();

    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {});
          },
          child: const Text('Try again'),
        ),
        TextButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          child: const Text('Watch It!'),
        ),
      ],
    );
  }
}
