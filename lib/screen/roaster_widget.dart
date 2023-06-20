import 'package:fake_football_desktop/bloc/roaster/roaster_bloc.dart';
import 'package:fake_football_desktop/bloc/roaster/roaster_event.dart';
import 'package:fake_football_desktop/bloc/roaster/roaster_state.dart';
import 'package:fake_football_desktop/components/above_keyboard_widget.dart';
import 'package:fake_football_desktop/components/center_grid_delegate.dart';
import 'package:fake_football_desktop/components/fake_football_progress_indicator.dart';
import 'package:fake_football_desktop/components/player_game_list_element.dart';
import 'package:fake_football_desktop/components/team_title.dart';
import 'package:fake_football_desktop/components/text_field_decoration.dart';
import 'package:fake_football_desktop/model/player.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:fake_football_desktop/utils/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RoasterWidget extends StatefulWidget {
  static const String route = '/riepilogoGiocatoriWidget/';

  const RoasterWidget({super.key});

  @override
  State<StatefulWidget> createState() => _RoasterWidgetState();
}

class _RoasterWidgetState extends State<RoasterWidget> {
  @override
  void initState() {
    super.initState();
    context.read<RoasterBloc>().add(EnterOnPageEvent());
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<RoasterBloc, RoasterState>(
        listenWhen: (prev, curr) => curr is CloseState,
        listener: (context, state) {
          Navigator.pop(context);
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              context.read<RoasterBloc>().add(BackPressEvent());
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  state is CreatePlayerState ? 'AGGIUNGI GIOCATORE' : 'ROASTER',
                  style: const TextStyle(color: Colors.white),
                ),
                actions: [
                  PopupMenuButton<String>(
                    shape: ShapeBorder.lerp(null, null, 0),
                    elevation: 0,
                    onSelected: (value) =>
                        context.read<RoasterBloc>().add(OverflowMenuEvent(value)),
                    itemBuilder: (context) => {AGGIUNGI_GIOCATORE}.map((String choice) {
                      return PopupMenuItem<String>(
                        textStyle: Theme.of(context).textTheme.titleSmall,
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList(),
                  ),
                ],
              ),
              body: _buildBodyByState(context, state),
              floatingActionButton: Visibility(
                visible: state is CreatePlayerState &&
                    state.p.roles.isNotEmpty &&
                    state.p.name.isNotEmpty,
                child: AboveKeyboard(
                  child: FloatingActionButton(
                    onPressed: () => context.read<RoasterBloc>().add(PlayerConfirmedEvent()),
                    backgroundColor: Colors.yellow,
                    child: const Icon(Icons.save),
                  ),
                ),
              ),
            ),
          );
        },
      );

  Widget _buildBodyByState(BuildContext context, RoasterState state) {
    switch (state.runtimeType) {
      case LoadingState:
      case CloseState:
        return const Center(
          child: FakeFootballProgressIndicator(),
        );
      case PlayersLoadedState:
        state as PlayersLoadedState;
        return PageView(
          onPageChanged: (page) => context.read<RoasterBloc>().add(ChangeJerseyEvent(page)),
          children: [
            playerList(state, context),
            playerList(state, context),
          ],
        );
      case CreatePlayerState:
      case RookieAlreadyExistState:
        bool isError = state is! CreatePlayerState;
        state as CreatePlayerState;
        return AboveKeyboard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.height * 0.25,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(child: Image.asset('assets/squad/rookie/yellowCardRookie.png')),
                    Positioned(
                      bottom: 15,
                      child: Text(
                        state.p.name.toUpperCase(),
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  decoration: FakeFootballDecoration.inputDecoration(
                    hintText: 'Nome',
                    labelText: 'Nome',
                    errorLabel: isError ? 'Giocatore già esistente' : null,
                    prefixIcon: const Icon(Icons.person),
                  ),
                  onChanged: (nome) => context.read<RoasterBloc>().add(NameTypingEvent(nome)),
                  onSubmitted: (nome) =>
                      context.read<RoasterBloc>().add(PlayerNameSubmittedEvent(nome)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: FakeFootballTitle(title: 'RUOLI', color: Colors.white),
              ),
              ..._rolesList(state.p, state.maxRoleLength),
            ],
          ),
        );
      default:
        print('${state.runtimeType}');
        return const Center(
          child: Text('Unexpected state'),
        );
    }
  }

  List<Widget> _rolesList(Player p, int maxRoleLength) {
    List<Widget> list = [];
    for (int i = 0; i < maxRoleLength; i++) {
      String? value = p.roles.length > i ? p.roles[i] : null;
      list.add(
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '${i + 1}° RUOLO:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                DropdownButton<String?>(
                    value: value,
                    hint: Text(
                      'POS',
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white54),
                    ),
                    items: ROLES
                        .where((e) {
                          bool res = e.isNullOrEmpty() || e == value || !p.roles.contains(e);
                          return res;
                        })
                        .map<DropdownMenuItem<String?>>(
                            (String? modulo) => DropdownMenuItem<String?>(
                                  value: modulo,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          modulo?.toUpperCase() ?? '',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                        .toList(),
                    onChanged: (value) =>
                        context.read<RoasterBloc>().add(RolePickedEvent(value, i)))
              ],
            ),
          ),
        ),
      );
    }
    return list;
  }

  Widget playerList(PlayersLoadedState state, BuildContext context) {
    return GridView.builder(
      gridDelegate: CenteredGridDelegate(
        crossAxisCount: 2, // Two children per row
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: state.players.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext ctx, i) => PlayerGameGridElement(
        width: MediaQuery.of(context).size.width / 2,
        type: CARD_SOCIAL,
        player: state.players[i],
        onTap: () => context.read<RoasterBloc>().add(PlayerPickedEvent(i)),
      ),
    );
  }
}
