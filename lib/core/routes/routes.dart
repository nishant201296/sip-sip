import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sip_sip/reminder/presentation/viewmodels/reminder_view_model.dart';
import 'package:sip_sip/core/routes/route_aware_widget.dart';
import 'package:sip_sip/reminder/presentation/ui/home_screen.dart';
import 'package:sip_sip/reminder/presentation/ui/settings_screen.dart';

class RouteConfig {
  final WidgetBuilder builder;
  final String route;

  RouteConfig({required this.builder, required this.route});
}

enum Routes {
  home,
  settings;

  static Map<String, WidgetBuilder> get routes {
    Map<String, WidgetBuilder> widgetMap = {};
    for (var key in Routes.values) {
      widgetMap[key.config.route] = key.config.builder;
    }
    return widgetMap;
  }
}

extension RouteExtension on Routes {
  RouteConfig get config {
    switch (this) {
      case Routes.home:
        return RouteConfig(
          builder: (context) => RouteAwareWidget(
            name: "HomePage",
            child:
                HomeScreen(viewModel: GetIt.instance.get<ReminderViewModel>()),
          ),
          route: '/',
        );
      case Routes.settings:
        return RouteConfig(
          builder: (context) => RouteAwareWidget(
            name: "SettingsPage",
            child: SettingsScreen(
                viewModel: GetIt.instance.get<ReminderViewModel>()),
          ),
          route: 'settings',
        );
    }
  }
}
