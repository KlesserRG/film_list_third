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

/*
  Меню редактирования добавления нового в базу данных.
*/

class _AddAndEditPageState extends State<AddAndEditPage> {
  // Переключатель просмотра
  bool isWatched = false;
  // Переключатель ошибки
  bool error = false;
  // Рейтинг звезд
  int rate = 1;
  // Время просмотра если isWatched = true
  DateTime date = DateTime.now();

  // Название файла
  TextEditingController title = TextEditingController();
  // Комментарий файла
  TextEditingController comment = TextEditingController();

  // Переключатель сериала и фильма
  bool isSeries = false;
  // Контроллер сезонов для сериалов.
  TextEditingController? seriesSeasons = TextEditingController();
  // Контроллер эпизодов для сериалов
  TextEditingController? seriesEpisodes = TextEditingController();

  // Определяет был ли просмотрен сериал. isSeries и isWatched должны быть true
  bool isWatchingSeries = false;
  // Номер просмотренного эпизода
  double watchingEpisode = 1;
  // Номер просмотренного сезона
  double watchingSeason = 1;

  // Доступность кнопки добавления. Если false - недоступна.
  bool doneButton = false;
  // Добавляет все данные во все поля из базы данных, а после становится true
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    // Проверка, добавление ли это или редакрирование.
    // Если редактирование - берет данные из базы данных.

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
      isWatchingSeries = widget.data?.isWatchingSeries ?? false;
      watchingEpisode = widget.data?.watchingEpisode?.toDouble() ?? 1;
      watchingSeason = widget.data?.watchingSeason?.toDouble() ?? 1;
    }

    // Определяет, пришли ли цифры в ввод серий и сезонов сериала.
    // Если нет - провоцирует ошибку

    if (isSeries) {
      try {
        int.parse(seriesSeasons!.text);
        int.parse(seriesEpisodes!.text);
        error = false;
      } catch (e) {
        error = true;
      }
    }

    // Определяет доступность кнопки добавления

    if (title.text.isEmpty && error == false) {
      doneButton = false;
    } else {
      doneButton = true;
    }

    // Создание рейтинга звезд.

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

    // Основной виджет

    return Scaffold(
      // Меняет текст в зависимости от пришедших данных
      appBar: AppBar(
        title: Text(widget.data == null ? "Add new" : "Edit current"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Название 
            TextField(
              controller: title,
              autofocus: widget.isAdd,
              decoration: const InputDecoration(label: Text("Title")),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 8),
            // Комментарий
            TextField(
              controller: comment,
              decoration: const InputDecoration(label: Text("Your Opinion")),
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 8),
            // Кнопка, переключающая isWatched
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
                  },
                ),
              ],
            ),
            // Создание рейтинга, если isWatched = true
            isWatched
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: createRate(),
                  )
                : const SizedBox(),
            // Создание выбора даты, если isWatched = true
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
                    // Нативное отображение даты
                    child: Text("${date.day} ${date.month} ${date.year}"),
                  )
                : const SizedBox(),
            /*
              Если пришли корректные данные в количество серий и сезонов (error)
              Если это сериал (isSeries)
              Если он просмотрен (isWatched)

              Появляются 2 слайдера, определяющие сколько эпизодов и сезонов вы просмотели.
              
              Ниже слайдер сезонов
            */
            isWatched && isSeries && !error
                ? Column(
                    children: [
                      Text("Season: ${watchingSeason.toInt()}"),
                      Slider(
                        min: 1,
                        max: double.parse(seriesSeasons?.text ?? '10.0'),
                        divisions: int.parse(seriesSeasons?.text ?? '10') + 1,
                        value: watchingSeason,
                        onChanged: (value) {
                          watchingSeason = value;
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
            // Второй слайдер, но для эпизодов
            isWatched && isSeries && !error
                ? Column(
                    children: [
                      Text("Episode: ${watchingEpisode.toInt()}"),
                      Slider(
                        min: 1,
                        max: double.parse(seriesEpisodes?.text ?? '10.0'),
                        divisions: int.parse(seriesEpisodes?.text ?? '10') + 1,
                        value: watchingEpisode,
                        onChanged: (value) {
                          watchingEpisode = value;
                          setState(() {});
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
            // Определение, является ли это сериалом
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
            /*
              Если является сериалом - нужно ввести количество серий и сезонов.
              Ввод не цифр должен провоцировать ошибку ввода.
              Также установлены данные watchingSeason и watchingEpisode на 1, при изменении
              Провоцирует ошибку приложения если данные из watching больше чем данные из series
            */
            isSeries
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Seasons: ', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: seriesSeasons,
                          onChanged: (value) => watchingSeason = 1,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const Text('Episodes: ', style: TextStyle(fontSize: 20)),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: seriesEpisodes,
                          onChanged: (value) => watchingEpisode = 1,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
      /*
        Кнопка добавления и изменения.
        Наличие проверки обусловлено наличием двух разных ивентов в блоке.
      */
      floatingActionButton: FloatingActionButton(
        onPressed: doneButton
            ? () {
              // Кнопка добавления новой информации в базу данных
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
                          isWatchingSeries: isWatchingSeries,
                          watchingEpisode: watchingEpisode.toInt(),
                          watchingSeason: watchingSeason.toInt()),
                    ),
                  );
                  AutoRouter.of(context).pop();
                  // Кнопка редактирования уже существующей информации в базе данных
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
                          isWatchingSeries: isWatchingSeries,
                          watchingEpisode: watchingEpisode.toInt(),
                          watchingSeason: watchingSeason.toInt()),
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
