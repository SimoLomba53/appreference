import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/components/card/card.dart';
import 'package:growingapp/features/notifications/domain/entities/notification.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_bloc.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_event.dart';
import 'package:growingapp/features/notifications/presentation/bloc/local/local_notification_state.dart';
//import 'package:growingapp/features/notifications/presentation/bloc/notification_bloc.dart';
//import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_bloc.dart';
//import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_state.dart';
//import 'package:growingapp/features/terrarium/presentation/pages/terrariums_catalogue.dart';
//import 'package:growingapp/components/card/terrarium/terrarium_garden_card.dart';
//import 'package:growingapp/components/icons/svg_icon.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: _buildBody(),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'Notifiche',
      ),
    );
  }

  _dateFormat(DateTime dateTime) {
    return dateTime.toLocal().toString().substring(0, 16);
  }

  _deleteNotification(NotificationEntity notification) {
    BlocProvider.of<LocalNotificationsBloc>(context)
        .add(RemoveNotification(notification));
  }

  _buildBody() {
    return BlocBuilder<LocalNotificationsBloc, LocalNotificationsState>(
        builder: (_, state) {
      if (state is LocalNotificationsLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is LocalNotificationsDone) {
        return state.notifications != null && state.notifications!.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                itemCount: state.notifications!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: CardCustom(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _dateFormat(
                              state.notifications![index].scheduledDate!,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF998F92),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            state.notifications![index].title!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            state.notifications![index].body!,
                            style: const TextStyle(
                              color: Color(0xFF998F92),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              _deleteNotification(state.notifications![index]);
                            },
                            child: const Text('Elimina'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Non ci sono notifiche',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Text(
                        'In questa sezione sono visibili le notifiche dei tuo terrari',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF998F92),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }
      return const SizedBox();
    });
  }
}
