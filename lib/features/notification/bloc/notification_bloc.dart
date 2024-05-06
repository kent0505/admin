import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<GetNotificationEvent>((event, emit) async {
      emit(NotificationLoadingState());

      try {
        await FirebaseMessaging.instance.getInitialMessage().then(
          (RemoteMessage? value) {
            if (value != null && value.notification != null) {
              print(value.notification!.title.toString());
              print(value.notification!.body.toString());

              emit(NotificationLoadedState(
                title: value.notification!.title.toString(),
                body: value.notification!.body.toString(),
              ));
            } else {
              emit(NotificationErrorState());
            }
          },
        );
      } catch (e) {
        log('CATCH $e');
        emit(NotificationErrorState());
      }
    });
  }
}
