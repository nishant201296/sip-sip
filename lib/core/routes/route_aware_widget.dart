import 'package:flutter/material.dart';

final RouteObserver<PageRoute> _routeObserver = RouteObserver<PageRoute>();

class RouteAwareWidget extends StatefulWidget {
  const RouteAwareWidget({super.key, required this.child, required this.name});
  final Widget child;
  final String name;

  @override
  State<RouteAwareWidget> createState() => _RouteAwareWidgetState();
}

class _RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    debugPrint('didPush ${widget.name}');
  }

  @override
  void didPopNext() {
    debugPrint('didPopNext ${widget.name}');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
