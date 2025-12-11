import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/components/alert/alert.dart';
import 'package:growingapp/components/card/card.dart';
import 'package:growingapp/components/detail/detail_section.dart';
import 'package:growingapp/components/detail/terrarium_cure_section.dart';
import 'package:growingapp/components/detail/terrarium_plants_section.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/components/img/firebase/firebase_img.dart';
import 'package:growingapp/core/util/list_dynamic_converter.dart';
import 'package:growingapp/features/notifications/data/repository/notification_repository_impl.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_bloc.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_event.dart';
import 'package:growingapp/features/terrarium/data/models/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_bloc.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_event.dart';
import 'package:growingapp/features/worker/model/task.dart';
import 'package:growingapp/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

//ignore: must_be_immutable
class TerrariumDetail extends StatefulWidget {
  TerrariumEntity terrarium;

  TerrariumDetail({super.key, required this.terrarium});

  @override
  State<TerrariumDetail> createState() => _TerrariumDetailState();
}

class _TerrariumDetailState extends State<TerrariumDetail> {
  final terrariumNameController = TextEditingController();
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _setName(String name) {
    if (name.isEmpty) {
      name = widget.terrarium.concept!;
    }
    setState(() {
      widget.terrarium =
          TerrariumModel.copyWithDifferentProps(widget.terrarium, name: name);
      BlocProvider.of<LocalTerrariumsBloc>(context)
          .add(UpdateTerrarium(widget.terrarium));
      edit = false;
    });
  }

  _buildBody() {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: FirebaseImg(
              path: 'images/terrariums/background',
              image: widget.terrarium.imgUrl!),
          //child: Image.network(
          //  widget.terrarium.imgUrl!,
          //  width: MediaQuery.of(context).size.width,
          //),
        ),
        _backBtn(),
        Container(
          padding: const EdgeInsets.all(30),
          //height: MediaQuery.of(context).size.height * 0.5,
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                edit
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                hintText: widget.terrarium.concept!,
                              ),
                              controller: terrariumNameController,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                edit = false;
                              });
                            },
                            child: const SvgIcon(
                              icon: 'close',
                              color: Color(0xffF27B6D),
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _setName(terrariumNameController.text);
                              });
                            },
                            child: const SvgIcon(
                              icon: 'tick',
                              color: Color(0xff0eae56),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.terrarium.name ??
                                  widget.terrarium.concept!,
                              maxLines: 2,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          CardCustom(
                            onTap: () {
                              setState(() {
                                terrariumNameController.text =
                                    widget.terrarium.name ??
                                        widget.terrarium.concept!;
                                edit = true;
                              });
                            },
                            padding: 5,
                            child: SvgIcon(
                              icon: 'edit',
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .color,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 15,
                ),
                DetailSection(
                  title: widget.terrarium.concept!,
                  content: Text(
                    widget.terrarium.description!,
                    style: const TextStyle(
                      color: Color(0xFF998F92),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TerrariumPlantsSection(terrarium: widget.terrarium),
                const SizedBox(
                  height: 15,
                ),
                TerrariumCureSection(
                  terrarium: widget.terrarium,
                  showNotifications: widget.terrarium.needWatering ?? false,
                  changeNotificationEnabled: (bool active) {
                    _changeNotificationEnabled(active);
                  },
                ),
              ],
            ),
          ),
        ),
        _removeBtn(),
      ],
    );
  }

  _backBtn() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgIcon(
              icon: "arrow-left",
              color: Theme.of(context).textTheme.headlineMedium!.color,
            ),
          ),
        ),
      ),
    );
  }

  _removeBtn() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: GestureDetector(
            onTap: () {
              showAlertDialog(
                context,
                title:
                    'Rimuovi ${widget.terrarium.name ?? widget.terrarium.concept}',
                description:
                    "Sei sicuro di voler rimuovere '${widget.terrarium.name ?? widget.terrarium.concept}' dalla tua libreria?",
                firstActionTitle: 'Si',
                firstAction: () {
                  _removeTerrarium();
                  Navigator.pop(context);
                },
                secondActionTitle: 'No',
                secondAction: () {
                  Navigator.pop(context);
                },
              );
            },
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xffF27B6D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const SvgIcon(
                icon: "trash",
              ),
            ),
          ),
        ),
      ),
    );
  }

  _removeTerrarium() {
    BlocProvider.of<LocalTerrariumsBloc>(context)
        .add(RemoveTerrarium(widget.terrarium));
    Navigator.pop(context);
  }

  _changeNotificationEnabled(bool active) async {
    widget.terrarium = TerrariumModel.copyWithDifferentProps(
      widget.terrarium,
      wateringNotificationsEnabled: !active,
    );
    BlocProvider.of<LocalTerrariumsBloc>(context)
        .add(UpdateTerrarium(widget.terrarium));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tasksJson = prefs.getString('tasksNotification') ?? '[]';
    var tasks = listDynamicToType<TaskNotification>(
      jsonDecode(tasksJson)
          .map(
              (task) => TaskNotification.fromJson(task as Map<String, dynamic>))
          .toList(),
    );
    if (active) {
      tasks.removeWhere((task) => task.terrariumId == widget.terrarium.id);
    } else {
      tasks.add(
        TaskNotification(
          id: (Random(13).nextInt(10000000).toString() +
                  DateTime.now().toIso8601String())
              .replaceAll(' ', ''),
          terrariumId: widget.terrarium.id!,
          lastNotificationTimeInSeconds: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          maxTimeBetweenNotificationsInSeconds:
              const Duration(days: 3).inSeconds, //Duration(days: 3).inSeconds,
          notification: NotificationEntity(
            id: '',
            groupId: 0,
            title: 'Cura ${widget.terrarium.name ?? widget.terrarium.concept!}',
            body:
                'Controlla l\'acqua a ${widget.terrarium.name ?? widget.terrarium.concept!}. Per sapere come fare guarda le guide per ${widget.terrarium.name ?? widget.terrarium.concept!}',
            scheduledDate: DateTime.now().add(const Duration(seconds: 1)),
          ),
        ),
      );
    }

    prefs.setString(
      'tasksNotification',
      jsonEncode(tasks.map((e) => e.toJson()).toList()),
    );

    NotificationEntity notification = NotificationEntity(
      id: '',
      groupId: -1,
      title: 'Notifiche ${active ? 'disattivate' : 'attivate'}',
      body:
          'Le notifiche per ${widget.terrarium.name ?? widget.terrarium.concept!} sono state ${active ? 'disattivate' : 'attivate'}',
      scheduledDate: DateTime.now(),
      payload: ' ',
    );

    NotificationRepositoryImpl notificationRepositoryImpl =
        NotificationRepositoryImpl(sl());
    notificationRepositoryImpl.scheduleNotification(notification);
    // ignore: use_build_context_synchronously
    BlocProvider.of<LocalNotificationsBloc>(context).add(
      SaveNotification(notification),
    );

    setState(() {});
  }
}
