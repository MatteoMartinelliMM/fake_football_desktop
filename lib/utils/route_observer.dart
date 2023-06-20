import 'package:fake_football_desktop/bloc/build_content/build_content_bloc.dart';
import 'package:fake_football_desktop/bloc/build_content/build_content_event.dart';
import 'package:fake_football_desktop/bloc/home/home_bloc.dart';
import 'package:fake_football_desktop/bloc/home/home_event.dart';
import 'package:fake_football_desktop/bloc/team_making/team_making_bloc.dart';
import 'package:fake_football_desktop/bloc/team_making/team_making_event.dart';
import 'package:fake_football_desktop/screen/build_content_widget.dart';
import 'package:fake_football_desktop/screen/home_widget.dart';
import 'package:fake_football_desktop/screen/team_making_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FFRouteObserver extends RouteObserver<Route<dynamic>> {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? routeName = route.settings.name;
    final String? previousRouteName = previousRoute?.settings.name;
    if (HomeWidget.route == previousRouteName) {
      BlocProvider.of<HomeBloc>(route.navigator!.context).add(EnterHomeEvent());
    }
    if (TeamMakingWidget.route == routeName) {
      BlocProvider.of<TeamMakingBloc>(route.navigator!.context).add(TeamMakingDisposeEvent());
    }
    if (BuildContentWidget.route == routeName) {
      BlocProvider.of<BuildContentBloc>(route.navigator!.context).add(BuildContentDisposeEvent());
    }

    print('Route "$routeName" was popped, previous route is "$previousRouteName"');
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final String? routeName = route.settings.name;
    final String? previousRouteName = previousRoute?.settings.name;
    print('didPush Route "$routeName", previous route is "$previousRouteName"');

    switch (route.settings.name) {
      case BuildContentWidget.route:
        BlocProvider.of<BuildContentBloc>(route.navigator!.context).add(LoadPageEvent());
        break;
      case TeamMakingWidget.route:
        BlocProvider.of<TeamMakingBloc>(route.navigator!.context).add(LoadPlayersEvent());
        break;
      case HomeWidget.route:
        BlocProvider.of<HomeBloc>(route.navigator!.context).add(EnterHomeEvent());
        break;
    }
  }
}
