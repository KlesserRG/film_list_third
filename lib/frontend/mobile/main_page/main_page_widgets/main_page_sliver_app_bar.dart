import 'package:flutter/material.dart';

class MainPageSliverAppBar extends StatefulWidget {
  const MainPageSliverAppBar({
    super.key,
  });

  @override
  State<MainPageSliverAppBar> createState() => _MainPageSliverAppBarState();
}

class _MainPageSliverAppBarState extends State<MainPageSliverAppBar> {
  final SearchController searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      title: Text("Your Wish List"),
      centerTitle: true,
      floating: false,
      // actions: <Widget>[
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.account_circle_outlined),
      //   )
      // ],
    );
  }
}
