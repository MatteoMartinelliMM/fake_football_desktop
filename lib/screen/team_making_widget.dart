import 'package:fake_football_desktop/bloc/team_making/team_making_bloc.dart';
import 'package:fake_football_desktop/bloc/team_making/team_making_state.dart';
import 'package:fake_football_desktop/components/above_keyboard_widget.dart';
import 'package:fake_football_desktop/components/fake_football_progress_indicator.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/team_making/team_making_event.dart';

class TeamMakingWidget extends StatefulWidget {
  static const String route = '/teamMaking/';

  TeamMakingWidget({super.key});

  @override
  State<TeamMakingWidget> createState() => _TeamMakingWidgetState();
}

class _TeamMakingWidgetState extends State<TeamMakingWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocConsumer<TeamMakingBloc, TeamMakingState>(
          listenWhen: (previous, current) =>
              current is RiepilogoCopiedState ||
              current is ThingsDoneState ||
              current is SingleTeamFulledState,
          buildWhen: (current, previous) =>
              current is! RiepilogoCopiedState ||
              current is! ThingsDoneState ||
              current is! SingleTeamFulledState,
          listener: (previous, current) {
            switch (current.runtimeType) {
              case RiepilogoCopiedState:
              case ThingsDoneState:
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      SnackBar(
                        content: Text((current as ThingsDoneState).text),
                      ),
                    )
                    .closed
                    .then((value) {
                  if (current is! RiepilogoCopiedState) {
                    Navigator.pop(context);
                  }
                });
                break;
              case SingleTeamFulledState:
                current as SingleTeamFulledState;
                if (_scaffoldKey.currentContext != null) {
                  DefaultTabController.of(_scaffoldKey.currentContext!)
                      .animateTo(current.tabPosition);
                }
                break;
            }
          },
          builder: (context, state) {
            print('Team making widget: ${state.runtimeType.toString()}');
            return Scaffold(
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Center(child: Text('CREA FORMAZIONI')),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    onSelected: (value) =>
                        context.read<TeamMakingBloc>().add(SoccerModeChangeEvent(value)),
                    itemBuilder: (BuildContext context) {
                      return {CALCIO_5, CALCIO_7}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
                /*bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.circle_outlined,
                              color: Colors.black87,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                GIALLI,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.black87),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.green.shade500,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                VERDI,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.black87),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),*/
              ),
              body: _buildBody(context, state),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.circle,
                      color: Colors.yellow,
                    ),
                    label: 'GIALLI',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.circle,
                      color: Colors.green.shade500,
                    ),
                    label: 'VERDI',
                  ),
                ],
                currentIndex:
                    state is TeamsFulledState || state is PlayersLoadedState ? state.currentTab : 0,
                onTap: (tab) {
                  context.read<TeamMakingBloc>().add(TabChangeEvent(tab));
                },
              ),
              floatingActionButton: Visibility(
                visible: state is TeamsFulledState,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AboveKeyboard(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: FloatingActionButton(
                            backgroundColor: Colors.yellow,
                            heroTag: null,
                            mini: true,
                            onPressed: () async =>
                                context.read<TeamMakingBloc>().add(RiepilogoPresentiEvent()),
                            child: const Icon(
                              Icons.copy,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: FloatingActionButton(
                            backgroundColor: Colors.yellow,
                            heroTag: null,
                            mini: true,
                            onPressed: () async =>
                                context.read<TeamMakingBloc>().add(TeamMakingShuffleEvent()),
                            child: const Icon(
                              Icons.shuffle,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.yellow,
                          heroTag: null,
                          onPressed: () async =>
                              context.read<TeamMakingBloc>().add(TeamConfifermedEvent()),
                          child: const Icon(Icons.navigate_next),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildBody(BuildContext context, TeamMakingState state) {
    if (state is LoadingPlayersState || state is ThingsDoneState) {
      return const Center(
        child: FakeFootballProgressIndicator(),
      );
    }
    if (state is PlayersLoadedState || state is TeamsFulledState) {
      return _teamBody(context, state, isYellow: state.currentTab == 0);
    }

    return Container();
  }

  Widget _teamBody(BuildContext context, TeamMakingState state, {bool isYellow = true}) {
    state is PlayersLoadedState ? state : state as TeamsFulledState;
    List<Player> currentTeam =
        isYellow ? state.gialli.values.toList() : state.verdi.values.toList();
    List<Player> oppositTeam =
        isYellow ? state.verdi.values.toList() : state.gialli.values.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                context.read<TeamMakingBloc>().teamAmount(currentTeam, isYellow: isYellow),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isYellow.getColor(),
                    ),
              ),
              const Spacer(),
              Text(
                context.read<TeamMakingBloc>().rookiesAmount(currentTeam, isYellow: isYellow),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isYellow.getColor(),
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            children: _buildPageView(context, state, oppositTeam, isYellow),
          ),
        ),
      ],
    );
  }

  double getHeight(BuildContext context) {
    final appBar = AppBar(); //Need to instantiate this here to get its size
    final appBarHeight = appBar.preferredSize.height + MediaQuery.of(context).padding.top;
    return MediaQuery.of(context).size.height - appBarHeight;
  }

  Widget playersList(BuildContext context, List<Player> players, bool isYellow) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (ctx, i) {
        var currPlayer = players[i];
        return CheckboxListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(
              currPlayer.distinta,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            value: context.read<TeamMakingBloc>().isPicked(currPlayer, isYellow),
            onChanged: context.read<TeamMakingBloc>().enableCheckbox(currPlayer, isYellow)
                ? (bool? checked) => context
                    .read<TeamMakingBloc>()
                    .add(PlayerPickedEvent(currPlayer, checked == true, isYellow))
                : null);
      },
    );
  }

  Widget rookieList(
      BuildContext context, Map<int, Player> playersByNumber, List<Player> rookies, bool isYellow) {
    return ListView.builder(
      itemCount: rookies.length,
      itemBuilder: (context, i) {
        Player currentRookie = rookies[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                currentRookie.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              DropdownButtonHideUnderline(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    alignment: AlignmentDirectional.center,
                    isDense: true,
                    value: _getSpinnerValue(currentRookie, playersByNumber, isYellow),
                    hint: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Seleziona nr maglia',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ),
                    items: (isYellow ? YELLOW_ROOKIES_SPINNER : GREEN_ROOKIES_SPINNER)
                        .map<DropdownMenuItem<String>>(
                          (String number) => DropdownMenuItem<String>(
                            value: number,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                number.toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (String? choosenNumber) => context
                        .read<TeamMakingBloc>()
                        .add(ChooseRookieNumber(currentRookie, choosenNumber, isYellow)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<TeamMakingBloc>().add(LoadPlayersEvent());
    _pageController = PageController(initialPage: 0);
  }

  String _getSpinnerValue(Player currentRookie, Map<int, Player> playersByNumber, bool isYellow) {
    List<String> current = isYellow ? YELLOW_ROOKIES_SPINNER : GREEN_ROOKIES_SPINNER;
    return current.contains(currentRookie.number.toString()) &&
            playersByNumber[currentRookie.number] == currentRookie
        ? currentRookie.number.toString()
        : NON_CONVOCATO;
  }

  List<Widget> _buildPageView(
      BuildContext context, TeamMakingState state, List<Player> oppositTeam, bool isYellow) {
    List<Widget> list = [];
    list.add(playersList(
        context, state.players.where((p) => !oppositTeam.contains(p)).toList(), isYellow));
    list.add(rookieList(context, isYellow ? state.gialli : state.verdi,
        state.rookies.where((p) => !oppositTeam.contains(p)).toList(), isYellow));
    return list;
  }
}
