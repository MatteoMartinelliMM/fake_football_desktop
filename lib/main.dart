import 'package:fake_football_desktop/bloc/build_content/build_content_bloc.dart';
import 'package:fake_football_desktop/bloc/build_content/build_content_event.dart';
import 'package:fake_football_desktop/bloc/home/home_bloc.dart';
import 'package:fake_football_desktop/bloc/home/home_event.dart';
import 'package:fake_football_desktop/bloc/roaster/roaster_bloc.dart';
import 'package:fake_football_desktop/bloc/settings/settings_bloc.dart';
import 'package:fake_football_desktop/bloc/team_making/team_making_bloc.dart';
import 'package:fake_football_desktop/bloc/team_making/team_making_event.dart';
import 'package:fake_football_desktop/bloc/timer/timer_bloc.dart';
import 'package:fake_football_desktop/bloc/video_generator_bloc/video_generator_bloc.dart';
import 'package:fake_football_desktop/repository/convocations_repository.dart';
import 'package:fake_football_desktop/repository/home_repository.dart';
import 'package:fake_football_desktop/repository/player_repository.dart';
import 'package:fake_football_desktop/repository/tracking_repository.dart';
import 'package:fake_football_desktop/repository/video_generator_repository.dart';
import 'package:fake_football_desktop/screen/build_content_widget.dart';
import 'package:fake_football_desktop/screen/home_widget.dart';
import 'package:fake_football_desktop/screen/roaster_widget.dart';
import 'package:fake_football_desktop/screen/settings_widget.dart';
import 'package:fake_football_desktop/screen/team_making_widget.dart';
import 'package:fake_football_desktop/screen/video_generator_widget.dart';
import 'package:fake_football_desktop/theme.dart';
import 'package:fake_football_desktop/tracking_database.dart';
import 'package:fake_football_desktop/utils/ffmpeg_interactor.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:fake_football_desktop/utils/route_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PathProvider();
  TrackingDatabase();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final RouteObserver<Route<dynamic>> routeObserver = RouteObserver<Route<dynamic>>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => HomeRepository(),
        ),
        RepositoryProvider(
          create: (context) => PlayerRepository(),
        ),
        RepositoryProvider(
          create: (context) => TrackingRepository(),
        ),
        RepositoryProvider(
          create: (context) => ConvocationsRepository(),
        ),
        RepositoryProvider(
          create: (context) => TrackingRepository(),
        ),
        RepositoryProvider(
          create: (context) => VideoGeneratorRepository(),
        ),
        RepositoryProvider(
          create: (context) => FfmpegInteractor(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              homeRepository: context.read<HomeRepository>(),
            ),
          ),
          BlocProvider<TeamMakingBloc>(
            create: (context) => TeamMakingBloc(
              playerRepository: context.read<PlayerRepository>(),
            )..add(LoadPlayersEvent()),
          ),
          BlocProvider<BuildContentBloc>(
            create: (context) => BuildContentBloc(
              convocationsRepository: context.read<ConvocationsRepository>(),
            )..add(LoadPageEvent()),
          ),
          BlocProvider<TimerBloc>(
            create: (context) => TimerBloc(),
          ),
          BlocProvider<VideoGeneratorBloc>(
            create: (context) => VideoGeneratorBloc(
              ffmpegInteractor: context.read<FfmpegInteractor>(),
              videoGeneratorRepository: context.read<VideoGeneratorRepository>(),
            ),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
          BlocProvider<RoasterBloc>(
            create: (context) => RoasterBloc(playerRepository: context.read<PlayerRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FakeFootball dashboard',
          initialRoute: '/',
          navigatorObservers: [routeObserver, FFRouteObserver()],
          routes: {
            TeamMakingWidget.route: (context) => TeamMakingWidget(),
            BuildContentWidget.route: (context) => BuildContentWidget(),
            VideoGeneratorWidget.route: (context) => VideoGeneratorWidget(),
            SettingsWidget.route: (context) => const SettingsWidget(),
            RoasterWidget.route: (context) => const RoasterWidget(),
          },
          theme: FakeFootballDashboardTheme(context).mainTheme,
          home: const HomeWidget(),
        ),
      ),
    );
  }
}

