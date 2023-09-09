part of 'main_page_bloc.dart';

sealed class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class MainPageEventLoad extends MainPageEvent {
  const MainPageEventLoad();

  @override
  List<Object> get props => [];
}

class MainPageEventAdd extends MainPageEvent {
  final FilmItemType item;
  const MainPageEventAdd({required this.item});

  @override
  List<Object> get props => [item];
}

class MainPageEventEdit extends MainPageEvent {
  final int index;
  final FilmItemType item;
  const MainPageEventEdit({
    required this.item,
    required this.index,
  });

  @override
  List<Object> get props => [item, index];
}

class MainPageEventDelete extends MainPageEvent {
  final int index;
  const MainPageEventDelete({
    required this.index,
  });

  @override
  List<Object> get props => [index];
}

class MainPageEventSortByRate extends MainPageEvent{
  final RangeValues rate;
  const MainPageEventSortByRate({
    required this.rate,
  });

  @override
  List<Object> get props => [rate];
}
