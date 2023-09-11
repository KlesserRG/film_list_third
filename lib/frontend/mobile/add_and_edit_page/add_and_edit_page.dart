import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/bloc/main_page_bloc/main_page_bloc.dart';
import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddAndEditPage extends StatefulWidget {
  final int? index;
  final FilmItemType? data;
  final bool isAdd;
  const AddAndEditPage({
    super.key,
    this.data,
    this.index,
    this.isAdd = false,
  });

  @override
  State<AddAndEditPage> createState() => _AddAndEditPageState();
}

class _AddAndEditPageState extends State<AddAndEditPage> {
  bool isWatched = false;
  int rate = 1;
  DateTime date = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController comment = TextEditingController();

  bool doneButton = false;
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isAdd == isEdit) {
      isEdit = true;
      isWatched = widget.data?.isWatched ?? true;
      rate = widget.data?.rate ?? 3;
      date = widget.data?.watchedTime ?? DateTime.now();
      title.text = widget.data?.title ?? 'No title';
      comment.text = widget.data?.comment ?? 'No comment';
    }

    if (title.text.isEmpty) {
      doneButton = false;
    } else {
      doneButton = true;
    }

    List<IconButton> createRate() {
      List<IconButton> list = [];
      for (var i = 1; i <= 5; i++) {
        list.add(
          IconButton(
            onPressed: () {
              rate = i;
              setState(() {});
            },
            icon: Icon(
              i <= rate ? Icons.star_rounded : Icons.star_border_rounded,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        );
      }
      return list;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data == null ? "Add new" : "Edit current"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: title,
              autofocus: widget.isAdd,
              decoration: const InputDecoration(label: Text("Title")),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: comment,
              decoration: const InputDecoration(label: Text("Your Opinion")),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Is Watched?", style: TextStyle(fontSize: 20)),
                Switch(
                    value: isWatched,
                    onChanged: (value) {
                      isWatched = value;
                      setState(() {});
                    }),
              ],
            ),
            isWatched
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: createRate(),
                  )
                : const SizedBox(height: 55),
            isWatched
                ? OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(DateTime.now().year + 20),
                          ) ??
                          DateTime.now();
                      setState(() {});
                    },
                    child: Text("${date.day} ${date.month} ${date.year}"),
                  )
                : const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: doneButton
            ? () {
                if (widget.isAdd == true) {
                  BlocProvider.of<MainPageBloc>(context).add(
                    MainPageEventAdd(
                      item: FilmItemType(
                        rate: rate,
                        title: title.text,
                        comment: comment.text,
                        watchedTime: date,
                        isWatched: isWatched,
                        createTime: widget.data?.createTime ?? DateTime.now(),
                      ),
                    ),
                  );
                  AutoRouter.of(context).pop();
                } else {
                  BlocProvider.of<MainPageBloc>(context).add(
                    MainPageEventEdit(
                      item: FilmItemType(
                        comment: comment.text,
                        title: title.text,
                        isWatched: isWatched,
                        watchedTime: date,
                        createTime: widget.data?.createTime ?? DateTime.now(),
                      ),
                      index: widget.index ?? 0,
                    ),
                  );
                  AutoRouter.of(context).pop();
                }
              }
            : null,
        elevation: 0,
        child: const Icon(Icons.done_rounded),
      ),
    );
  }
}
