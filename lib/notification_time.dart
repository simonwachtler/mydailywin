import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_daily_win/data.dart';
import 'package:my_daily_win/settings.dart';
import 'package:provider/provider.dart';

final timeFormat = DateFormat.Hm("de");

class NotificationTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DataModel>();
    return ListTile(
      title: Text(
        "Erinnerung um " +
            timeFormat.format(
              model.notificationTime.toDateTime(),
            ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: () async {
          final newTime = await showTimePicker(
            context: context,
            initialTime: model.notificationTime.toTimeOfDay(),
          );
          if (newTime == null) return;
          model.setNotificationTime(newTime);
          updateNotifications(
            model.dailyNotificationsEnabled,
            model.notificationTime.toTime(),
          );
        },
      ),
    );
  }
}
