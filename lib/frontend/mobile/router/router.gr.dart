// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddAndEditRoute.name: (routeData) {
      final args = routeData.argsAs<AddAndEditRouteArgs>(
          orElse: () => const AddAndEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddAndEditPage(
          key: args.key,
          data: args.data,
          index: args.index,
          isAdd: args.isAdd,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [AddAndEditPage]
class AddAndEditRoute extends PageRouteInfo<AddAndEditRouteArgs> {
  AddAndEditRoute({
    Key? key,
    FilmItemType? data,
    int? index,
    bool isAdd = false,
    List<PageRouteInfo>? children,
  }) : super(
          AddAndEditRoute.name,
          args: AddAndEditRouteArgs(
            key: key,
            data: data,
            index: index,
            isAdd: isAdd,
          ),
          initialChildren: children,
        );

  static const String name = 'AddAndEditRoute';

  static const PageInfo<AddAndEditRouteArgs> page =
      PageInfo<AddAndEditRouteArgs>(name);
}

class AddAndEditRouteArgs {
  const AddAndEditRouteArgs({
    this.key,
    this.data,
    this.index,
    this.isAdd = false,
  });

  final Key? key;

  final FilmItemType? data;

  final int? index;

  final bool isAdd;

  @override
  String toString() {
    return 'AddAndEditRouteArgs{key: $key, data: $data, index: $index, isAdd: $isAdd}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
