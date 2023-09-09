import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/bloc/main_theme_bloc/main_theme_bloc.dart';
import 'package:film_list_third/frontend/mobile/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainThemeBloc, MainThemeState>(
      builder: (context, state) {
        state = state as MainThemeLoaded;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const Text("Theme"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.wb_sunny_rounded),
                  ThemeButton(state: state, theme: AppTheme.lightDefault),
                  ThemeButton(state: state, theme: AppTheme.lightRedTheme),
                  ThemeButton(state: state, theme: AppTheme.lightYellowTheme),
                  ThemeButton(state: state, theme: AppTheme.lightGreenTheme),
                  ThemeButton(state: state, theme: AppTheme.lightBlueTheme),
                  const SizedBox(width: 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.dark_mode_rounded),
                  ThemeButton(state: state, theme: AppTheme.darkDefault),
                  ThemeButton(state: state, theme: AppTheme.darkRedTheme),
                  ThemeButton(state: state, theme: AppTheme.darkYellowTheme),
                  ThemeButton(state: state, theme: AppTheme.darkGreenTheme),
                  ThemeButton(state: state, theme: AppTheme.darkBlueTheme),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ThemeButton extends StatefulWidget {
  final ThemeData theme;
  final MainThemeLoaded state;
  const ThemeButton({
    super.key,
    required this.state,
    required this.theme,
  });

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MainThemeBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(4),
      child: IconButton.filled(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            widget.theme.primaryColorLight,
          ),
        ),
        onPressed: () {
          bloc.add(MainThemeEventChange(theme: widget.theme));
        },
        icon: widget.state.theme == widget.theme
            ? const Icon(Icons.done_rounded)
            : const Icon(Icons.close_rounded),
      ),
    );
  }
}
