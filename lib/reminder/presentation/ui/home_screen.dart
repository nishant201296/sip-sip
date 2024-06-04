import 'package:flutter/material.dart';
import 'package:sip_sip/reminder/domain/models/domain_entities.dart';
import 'package:sip_sip/reminder/presentation/viewmodels/reminder_view_model.dart';
import 'package:sip_sip/core/routes/routes.dart';

class HomeScreen extends StatefulWidget {
  final ReminderViewModel viewModel;
  const HomeScreen({super.key, required this.viewModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    widget.viewModel.notificationPermissionResult
        .addListener(_notificationPermissionListener);
    widget.viewModel.requestNotificationPermission();
  }

  @override
  void dispose() {
    widget.viewModel.notificationPermissionResult
        .removeListener(_notificationPermissionListener);
    super.dispose();
  }

  void _notificationPermissionListener() {
    switch (widget.viewModel.notificationPermissionResult.value) {
      case PermissionResult.granted:
        {
          widget.viewModel.initializeNotifications();
          break;
        }
      case PermissionResult.requestAgain:
        {
          // showPermissionSnackBar(true);
          break;
        }
      case PermissionResult.showManualDialog:
        {
          // showPermissionSnackBar(true);
          break;
        }
      case PermissionResult.na:
    }
    widget.viewModel.loadLastDrinkTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Reminder App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder<DateTime?>(
              valueListenable: widget.viewModel.lastDrankTime,
              builder: (context, value, child) {
                return Text(
                  'Last Drink Time: ${(value != null) ? value.toLocal().toString() : 'Not yet recorded'}',
                  style: const TextStyle(fontSize: 16),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.viewModel.onDrankNowClicked();
              },
              child: const Text('I Drank Water'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.settings.config.route),
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
