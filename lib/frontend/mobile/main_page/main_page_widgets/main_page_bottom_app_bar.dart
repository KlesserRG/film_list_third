import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page_widgets/main_page_random.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page_widgets/main_page_search.dart';
import 'package:film_list_third/frontend/mobile/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBottomAppBar extends StatefulWidget {
  const MainPageBottomAppBar({
    super.key,
  });

  @override
  State<MainPageBottomAppBar> createState() => _MainPageBottomAppBarState();
}

class _MainPageBottomAppBarState extends State<MainPageBottomAppBar> {
  final SearchController searchController = SearchController();
  final MenuController rateController = MenuController();
  final MenuController settingsController = MenuController();
  RangeValues rateValues = const RangeValues(1, 5);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: <Widget>[
          // SETTINGS

          MenuAnchor(
            controller: settingsController,
            anchorTapClosesMenu: false,
            menuChildren: <Widget>[
              SizedBox(
                width: 150,
                child: TextButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const MainPageRandom(),
                    );
                    settingsController.close();
                  },
                  icon: const Icon(
                    Icons.shuffle_rounded,
                  ),
                  label: const Text("Random"),
                ),
              ),
              SizedBox(
                width: 150,
                child: TextButton.icon(
                  onPressed: () {
                    AutoRouter.of(context).push(const SettingsRoute());
                    settingsController.close();
                  },
                  icon: const Icon(Icons.color_lens_outlined),
                  label: const Text("Theme"),
                ),
              ),
            ],
            child: IconButton(
              onPressed: () {
                if (settingsController.isOpen) {
                  settingsController.close();
                } else {
                  settingsController.open();
                }
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),

          // RATE

          MenuAnchor(
            controller: rateController,
            menuChildren: <Widget>[
              const Center(child: Text("Rate")),
              const Divider(),
              RangeSlider(
                min: 1,
                max: 5,
                divisions: 4,
                labels: RangeLabels(
                  rateValues.start.toString(),
                  rateValues.end.toString(),
                ),
                values: rateValues,
                onChanged: (values) {
                  BlocProvider.of<MainPageBloc>(context).add(
                    MainPageEventSortByRate(rate: values),
                  );
                  rateValues = values;
                  setState(() {});
                },
              ),
            ],
            child: IconButton(
              onPressed: () {
                if (rateController.isOpen) {
                  rateController.close();
                } else {
                  rateController.open();
                }
                setState(() {});
              },
              icon: Icon(
                Icons.star_rate_rounded,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),

          // SEARCH

          const MainPageSearch(),

          const Spacer(),

          // ADD BUTTON

          FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(AddAndEditRoute(isAdd: true));
            },
            elevation: 0,
            child: const Icon(Icons.add_rounded),
          )
        ],
      ),
    );
  }
}
