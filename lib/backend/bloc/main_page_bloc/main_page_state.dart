part of 'main_page_bloc.dart';

sealed class MainPageState extends Equatable {
  const MainPageState();
  
  @override
  List<Object> get props => [];
}

final class MainPageInitial extends MainPageState {}

final class MainPageLoaded extends MainPageState{
  final List<FilmItemType> data;
  const MainPageLoaded({required this.data});

  @override
  List<Object> get props => [data];
}
