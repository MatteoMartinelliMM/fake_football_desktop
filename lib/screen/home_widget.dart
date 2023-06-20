import 'package:fake_football_desktop/bloc/home/home_bloc.dart';
import 'package:fake_football_desktop/bloc/home/home_event.dart';
import 'package:fake_football_desktop/bloc/home/home_state.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidget extends StatefulWidget {
  static const String route = '/';

  const HomeWidget({super.key});

  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    print('initState Home Widget');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ChangeRouteState:
              Navigator.pushNamed(context, (state as ChangeRouteState).route);
              break;
            case ShowSnackbarState:
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text((state as ShowSnackbarState).msg)));
              break;
          }
        },
        listenWhen: (previous, current) =>
            current is ChangeRouteState || current is ShowSnackbarState,
        buildWhen: (previous, current) =>
            current is! ChangeRouteState && current is! ShowSnackbarState,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                PopupMenuButton<String>(
                  shape: ShapeBorder.lerp(null, null, 0),
                  elevation: 0,
                  onSelected: (value) => context.read<HomeBloc>().add(OverflowMenuEvent(value)),
                  itemBuilder: (context) {
                    return {EXPORT_DB, SETTINGS}.map((String choice) {
                      return PopupMenuItem<String>(
                        textStyle: Theme.of(context).textTheme.titleSmall,
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            body: SizedBox.expand(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
                      child: GestureDetector(
                        onLongPress: () => PathProvider.clearAll(),
                        child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Image.asset('assets/images/logo_fakefootball.png')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: _buildBodyByState(context, state),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBodyByState(BuildContext context, HomeState state) {
    switch (state.runtimeType) {
      case LoadingHomeState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case MenuLoadedState:
        state as MenuLoadedState;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildMenu(context, state.defaultActions),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildMenu(context, state.currentActions),
            ),
          ],
        );
      default:
        print('Home widget: ${state.runtimeType.toString()}');
        return Center(
          child: Text(
            'Unexpected state.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        );
    }
  }

  List<Widget> _buildMenu(BuildContext context, Map<String, String> actions) {
    List<Widget> actionsButtons = [];
    actions.forEach((label, action) => actionsButtons.add(_actionButton(context, label, action)));
    return actionsButtons;
  }

  Widget _actionButton(BuildContext context, String label, String action) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: MaterialButton(
        onPressed: () => context.read<HomeBloc>().add(ActionPressedEvent(action)),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
