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

  @HiveField(6)
  final bool isSeries;

  @HiveField(7)
  final int? seriesSeasons;

  @HiveField(8)
  final int? seriesEpisodes;

  @HiveField(9)
  final bool? isWatchingSeries;

  @HiveField(10)
  final int? watchingSeason;

  @HiveField(11)
  final int? watchingEpisode;

  const FilmItemType({
    this.isWatched = true,
    this.title = "No title",
    this.rate = 5,
    this.createTime,
    this.watchedTime,
    this.comment,
    this.isSeries = false,
    this.seriesEpisodes,
    this.seriesSeasons,
    this.isWatchingSeries,
    this.watchingEpisode,
    this.watchingSeason,
  });
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
