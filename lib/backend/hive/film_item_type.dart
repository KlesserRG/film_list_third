import 'package:hive/hive.dart';

part 'film_item_type.g.dart';

@HiveType(typeId: 0)
class FilmItemType {
  @HiveField(0)
  final bool isWatched;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int rate;

  @HiveField(3)
  final DateTime? createTime;

  @HiveField(4)
  final DateTime? watchedTime;

  @HiveField(5)
  final String? comment;

  const FilmItemType(
      {this.isWatched = true,
      this.title = "No title",
      this.rate = 5,
      this.createTime,
      this.watchedTime,
      this.comment});
}

@HiveType(typeId: 1)
class UserThemeDataType {
  @HiveField(0)
  int color;

  @HiveField(1)
  bool isDarkMode;

  UserThemeDataType({
    required this.color,
    required this.isDarkMode,
  });
}
