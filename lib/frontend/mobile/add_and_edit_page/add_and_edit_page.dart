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
  bool isSeries = false;
  bool error = false;
  int rate = 1;
  DateTime date = DateTime.now();
  TextEditingController title = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController? seriesSeasons = TextEditingController();
  TextEditingController? seriesEpisodes = TextEditingController();

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
      isSeries = widget.data?.isSeries ?? false;
      seriesSeasons?.text = widget.data?.seriesSeasons.toString() ?? '0';
      seriesEpisodes?.text = widget.data?.seriesEpisodes.toString() ?? '0';
    }

    if (isSeries) {
      try {
        int.parse(seriesSeasons!.text);
        int.parse(seriesEpisodes!.text);
        error = false;
      } catch (e) {
        error = true;
      }
    }

    if (title.text.isEmpty && error == false) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
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
                : const SizedBox(),
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
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                const Text('Is Series?', style: TextStyle(fontSize: 20)),
                Switch(
                  value: isSeries,
                  onChanged: (value) {
                    isSeries = value;
                    setState(() {});
                  },
                )
              ],
            ),
            isSeries
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Seasons: ', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: seriesSeasons,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const Text('Episodes: ', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: seriesEpisodes,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: doneButton
            ? () {
                if (widget.isAdd == true && error == false) {
                  BlocProvider.of<MainPageBloc>(context).add(
                    MainPageEventAdd(
                      item: FilmItemType(
                        rate: rate,
                        title: title.text,
                        comment: comment.text,
                        watchedTime: date,
                        isWatched: isWatched,
                        createTime: widget.data?.createTime ?? DateTime.now(),
                        isSeries: isSeries,
                        seriesEpisodes:
                            int.parse(seriesEpisodes?.text.toString() ?? "0"),
                        seriesSeasons:
                            int.parse(seriesSeasons?.text.toString() ?? '0'),
                      ),
                    ),
                  );
                  AutoRouter.of(context).pop();
                } else if (error == false) {
                  BlocProvider.of<MainPageBloc>(context).add(
                    MainPageEventEdit(
                      item: FilmItemType(
                        comment: comment.text,
                        title: title.text,
                        isWatched: isWatched,
                        watchedTime: date,
                        createTime: widget.data?.createTime ?? DateTime.now(),
                        isSeries: isSeries,
                        seriesEpisodes:
                            int.parse(seriesEpisodes?.text.toString() ?? "0"),
                        seriesSeasons:
                            int.parse(seriesSeasons?.text.toString() ?? '0'),
                      ),
                      index: widget.index ?? 0,
                    ),
                  );
                  AutoRouter.of(context).pop();
                } else {
                  null;
                }
              }
            : null,
        elevation: 0,
        child: const Icon(Icons.done_rounded),
      ),
    );
  }
}
