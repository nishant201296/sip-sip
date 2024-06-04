import 'package:flutter/material.dart';
import 'package:sip_sip/reminder/presentation/viewmodels/reminder_view_model.dart';

class SettingsScreen extends StatefulWidget {
  final ReminderViewModel viewModel;

  const SettingsScreen({super.key, required this.viewModel});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _intervalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadNotificationDuration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ValueListenableBuilder(
                valueListenable: widget.viewModel.notificationDuration,
                builder: (context, value, child) {
                  _intervalController.text = value.toString();
                  return TextField(
                    controller: _intervalController,
                    decoration: const InputDecoration(
                        labelText: 'Reminder Interval (minutes)'),
                    keyboardType: TextInputType.number,
                  );
                }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await widget.viewModel
                    .setNotificationDuration(_intervalController.value.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
