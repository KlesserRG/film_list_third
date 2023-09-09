import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:film_list_third/frontend/mobile/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageSearch extends StatefulWidget {
  const MainPageSearch({super.key});

  @override
  State<MainPageSearch> createState() => _MainPageSearchState();
}

class _MainPageSearchState extends State<MainPageSearch> {
  final SearchController searchController = SearchController();
  SearchController searchControllerPast = SearchController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageBloc, MainPageState>(
      builder: (context, state) {
        if (state is! MainPageLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return SearchAnchor(
          searchController: searchController,
          builder: (context, searchController) {
            return IconButton(
              onPressed: () {
                searchController.openView();
              },
              icon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColorLight,
              ),
            );
          },
          suggestionsBuilder: (context, searchController) {
            return List.generate(state.data.length, (index) {
              if (searchController.text.isEmpty) {
                return ListTile(
                  title: Text(state.data[index].title),
                  onTap: () {
                    AutoRouter.of(context).popAndPush(
                      AddAndEditRoute(
                        data: state.data[index],
                        index: index,
                      ),
                    );
                  },
                );
              }

              if (state.data[index].title.length <
                  searchController.text.length) {
                return const SizedBox();
              }

              for (var i = 0; i < searchController.text.length; i++) {
                if (state.data[index].title.toLowerCase().split('')[i] !=
                    searchController.text.toLowerCase().split('')[i]) {
                  return const SizedBox();
                }
              }
              return ListTile(
                title: Text(state.data[index].title),
                onTap: () {
                  AutoRouter.of(context).popAndPush(
                    AddAndEditRoute(
                      data: state.data[index],
                      index: index,
                    ),
                  );
                },
              );
            });
          },
        );
      },
    );
  }
}
