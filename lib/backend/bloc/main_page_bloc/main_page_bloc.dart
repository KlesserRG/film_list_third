import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/backend/hive/film_item_type_boxes.dart';
import 'package:flutter/material.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageInitial()) {
    on<MainPageEventLoad>(_load);
    on<MainPageEventAdd>(_add);
    on<MainPageEventEdit>(_edit);
    on<MainPageEventDelete>(_delete);
    on<MainPageEventSortByRate>(_sortByRate);
  }

  Future<void> _load(
    MainPageEventLoad event,
    Emitter emit,
  ) async {
    emit(MainPageLoaded(data: HiveBoxes.filmItemType.values.toList()));
  }

  Future<void> _add(
    MainPageEventAdd event,
    Emitter emit,
  ) async {
    HiveBoxes.filmItemType.add(event.item);
    List<FilmItemType> data = HiveBoxes.filmItemType.values.toList();
    emit(MainPageLoaded(data: data));
  }

  Future<void> _edit(
    MainPageEventEdit event,
    Emitter emit,
  ) async {
    await HiveBoxes.filmItemType.putAt(event.index, event.item);
    List<FilmItemType> data = HiveBoxes.filmItemType.values.toList();
    emit(MainPageLoaded(data: data));
  }

  Future<void> _delete(
    MainPageEventDelete event,
    Emitter emit,
  ) async {
    await HiveBoxes.filmItemType.deleteAt(event.index);
    List<FilmItemType> data = HiveBoxes.filmItemType.values.toList();
    emit(MainPageLoaded(data: data));
  }

  Future<void> _sortByRate(
    MainPageEventSortByRate event,
    Emitter emit,
  ) async {
    List<FilmItemType> data = HiveBoxes.filmItemType.values.toList();
    List<FilmItemType> sortedData = [];

    for (var i = 0; i < data.length; i++) {
      if(event.rate.start <= data[i].rate && data[i].rate <= event.rate.end){
        sortedData.add(data[i]);
      }
    }

    emit(MainPageLoaded(data: sortedData));
  }
}
