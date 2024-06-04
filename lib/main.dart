import 'package:flutter/material.dart';
import 'package:sip_sip/core/di/dependency_injection.dart';
import 'package:sip_sip/core/routes/routes.dart';
import 'package:sip_sip/core/utils/constants.dart';

void main() {
  DependencyInjection.configure();
  runApp(const SipSip());
}

class SipSip extends StatelessWidget {
  const SipSip({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appName,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Colors.blueAccent.shade400),
        useMaterial3: true,
      ),
      initialRoute: Routes.home.config.route,
      routes: Routes.routes,
    );
  }
}
