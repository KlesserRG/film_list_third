part of 'main_theme_bloc.dart';

sealed class MainThemeState extends Equatable {
  const MainThemeState();
  
  @override
  List<Object> get props => [];
}

final class MainThemeInitial extends MainThemeState {}

final class MainThemeLoaded extends MainThemeState{
  final ThemeData theme;
  const MainThemeLoaded({required this.theme});

  @override
  List<Object> get props => [theme];
}
