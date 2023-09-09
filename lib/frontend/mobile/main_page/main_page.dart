import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page_widgets/main_page_bottom_app_bar.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page_widgets/main_page_sliver_animated_list.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page_widgets/main_page_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MainPageBloc, MainPageState>(
        builder: (context, state) {
          if (state is! MainPageLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: <Widget>[
              const MainPageSliverAppBar(),
              MainPageSliverAnimatedList(list: state.data,),
            ],
          );
        },
      ),
      // drawer: const MainPageDrawer(),
      bottomNavigationBar: const MainPageBottomAppBar(),
    );
  }
}
