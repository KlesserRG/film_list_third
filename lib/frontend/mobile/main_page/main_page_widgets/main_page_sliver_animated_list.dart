import 'package:auto_route/auto_route.dart';
import 'package:film_list_third/backend/hive/film_item_type.dart';
import 'package:film_list_third/frontend/mobile/main_page/main_page_widgets/main_page_delete.dart';
import 'package:film_list_third/frontend/mobile/router/router.dart';
import 'package:flutter/material.dart';

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
                widget.data.isWatched == true
                    ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: generateRate(widget.data.rate)),
                            Text(
                                "${widget.data.watchedTime?.day} ${widget.data.watchedTime?.month} ${widget.data.watchedTime?.year}"),
                          ],
                        ),
                    )
                    : const Text("Not watched before"),
              ],
            ),
            const Spacer(),
            MenuAnchor(
              controller: controller,
              anchorTapClosesMenu: true,
              menuChildren: [
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
