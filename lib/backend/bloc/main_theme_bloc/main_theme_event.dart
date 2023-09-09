part of 'main_theme_bloc.dart';

sealed class MainThemeEvent extends Equatable {
  const MainThemeEvent();

  @override
  List<Object> get props => [];
}

class MainThemeEventLoad extends MainThemeEvent{
  const MainThemeEventLoad();
}

class MainThemeEventChange extends MainThemeEvent{
  final ThemeData theme;
  const MainThemeEventChange({required this.theme});

  @override
  List<Object> get props => [theme];
}