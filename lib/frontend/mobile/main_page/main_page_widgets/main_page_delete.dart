import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageDelete extends StatelessWidget {
  final int index;
  const MainPageDelete({super.key, required this.index});

  /*
    Выскакивающий диалог об удалении выбранного элемента
  */

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure?"),
      actions: [
        IconButton(onPressed: () {
          AutoRouter.of(context).pop();
        }, icon: const Icon(Icons.close_rounded)),
        IconButton(onPressed: () {
          BlocProvider.of<MainPageBloc>(context).add(MainPageEventDelete(index: index));
          AutoRouter.of(context).pop();
        }, icon: const Icon(Icons.done_rounded)),
      ],
    );
  }
}
