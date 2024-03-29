import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page_widgets/main_page_delete.dart';
import 'package:film_list_third/frontend/mobile/router/router.dart';
import 'package:flutter/material.dart';

/*
  Главный класс отображения.
  Именно сюда передается файл list со всей базой данных для её отображения.
  Файл передается именно сюда поскольку установить генератор блокав сливер не выходит.
  -
  Так же нам нужно было сделать отображение от последнего элемена к самому первому.
  В SliverList.builder такой функции не предусмотрено, поэтому тут стоит такая конструкция:
  list.length - 1 - index
  Она переворачивает всю базу по дате добавления задом наперед в отображении.
*/

class MainPageSliverAnimatedList extends StatelessWidget {
  final List<FilmItemType> list;
  const MainPageSliverAnimatedList({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        return list.isEmpty
            ? const Center(child: Text("No data"))
            : MainPageSliverAnimatedListItem(
                index: list.length - 1 - index,
                data: list[list.length - 1 - index],
              );
      },
      itemCount: list.length,
    );
  }
}

/*
  Класс отображения. Также именно этот класс один из самых нагруженных в приложении.
  У класса есть несколько состояний. Свойства следующего наследуются из предыдущих.
  1. Не просмотренные приложения отображаются как имя, сообщение о непросмотренности и настройки.
  2. Просмотренные приложения отображаются с рейтингом и датой просмотра. 
  3. Просмотренные приложения опционально отображаются с комментарием пользователя
  4. Просмотренные сериалы отображаются с индикатором серий. 
*/

class MainPageSliverAnimatedListItem extends StatefulWidget {
  final bool isDeletingMode;
  final int index;
  final FilmItemType data;
  const MainPageSliverAnimatedListItem({
    super.key,
    this.isDeletingMode = false,
    required this.index,
    required this.data,
  });

  @override
  State<MainPageSliverAnimatedListItem> createState() =>
      _MainPageSliverAnimatedListItemState();
}

class _MainPageSliverAnimatedListItemState
    extends State<MainPageSliverAnimatedListItem> {
  MenuController controller = MenuController();
  @override
  Widget build(BuildContext context) {
    // Генератор звездочек рейтинга

    List<Icon> generateRate(int rate) {
      List<Icon> list = [];
      for (int i = 1; i <= 5; i++) {
        if (i <= rate) {
          list.add(const Icon(Icons.star_rate_rounded));
        } else {
          list.add(const Icon(Icons.star_border_purple500_rounded));
        }
      }
      return list;
    }

    // Основной класс

    return Card(
      child: ListTile(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    widget.data.title,
                  ),
                ),
                // Проверка, был ли просмотрен фильм или сериал
                widget.data.isWatched == true
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Рейтинг
                            Row(children: generateRate(widget.data.rate)),
                            // Эпизоды и сезоны для сериалов
                            widget.data.seriesEpisodes == 1
                                ? Text(
                                    'E${widget.data.seriesEpisodes} / S${widget.data.seriesSeasons}')
                                : const SizedBox(),
                            // Дата, когда фильм был просмотренным.
                            Text(
                                "${widget.data.watchedTime?.day} ${widget.data.watchedTime?.month} ${widget.data.watchedTime?.year}"),
                          ],
                        ),
                      )
                      // Выводится если не просмотрен
                    : const Text("Not watched before"),
              ],
            ),
            const Spacer(),

            // Меню настроек в правой части класса

            MenuAnchor(
              controller: controller,
              anchorTapClosesMenu: true,
              menuChildren: [

                // Изменение информации класса

                IconButton(
                  onPressed: () {
                    controller.close();
                    AutoRouter.of(context).push(
                      AddAndEditRoute(
                        index: widget.index,
                        data: widget.data,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),

                // Удаление класса из базы данных

                IconButton(
                  onPressed: () {
                    controller.close();
                    showDialog(
                      context: context,
                      builder: (context) => MainPageDelete(
                        index: widget.index,
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ],
              // Открытие и закрытие меню настроек
              child: IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ),
          ],
        ),
        // Отображение комментария пользователя
        subtitle: widget.data.comment?.isEmpty ?? true
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(widget.data.comment ?? "ERROR"),
                ],
              ),
      ),
    );
  }
}
