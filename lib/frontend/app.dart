import 'package:film_list_third/backend/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:film_list_third/backend/bloc/main_theme_bloc/main_theme_bloc.dart';
import 'package:film_list_third/frontend/mobile/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilmListAppStart extends StatefulWidget {
  const FilmListAppStart({super.key});

  @override
  State<FilmListAppStart> createState() => _FilmListAppStartState();
}

class _FilmListAppStartState extends State<FilmListAppStart> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainPageBloc()..add(const MainPageEventLoad()),
        ),
        BlocProvider(
          create: (context) => MainThemeBloc()..add(const MainThemeEventLoad()),
        ),
      ],
      child: BlocBuilder<MainThemeBloc, MainThemeState>(
        builder: (context, state) {
          if (state is! MainThemeLoaded) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            routerConfig: _appRouter.config(),
          );
        },
      ),
    );
  }
}
