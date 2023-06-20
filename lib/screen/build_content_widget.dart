import 'dart:io' show Platform;

import 'package:fake_football_desktop/bloc/build_content/build_content_bloc.dart';
import 'package:fake_football_desktop/bloc/build_content/build_content_state.dart';
import 'package:fake_football_desktop/components/build_cards_status_list_element.dart';
import 'package:fake_football_desktop/components/build_line_up_list_element.dart';
import 'package:fake_football_desktop/components/team_title.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/build_content/build_content_event.dart';

class BuildContentWidget extends StatelessWidget {
  static const String route = '/confermaConvocati/';

  BuildContentWidget({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuildContentBloc, BuildGameContentState>(
        listenWhen: (previous, current) => current is ThinsDoneState,
        listener: (previous, current) => Navigator.pop(context),
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(state.title),
              actions: state is BuildCardState || state is BuildLineUpState
                  ? <Widget>[
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () => context.read<BuildContentBloc>().add(RefreshEvent()),
                      )
                    ]
                  : null,
            ),
            floatingActionButton: Visibility(
              visible: canGoNext(state),
              child: FloatingActionButton(
                backgroundColor: Colors.yellow,
                child: const Icon(Icons.navigate_next),
                onPressed: () => context.read<BuildContentBloc>().add(NextEvent()),
              ),
            ),
            body: buildBody(context, state),
          );
        });
  }

  Widget buildBody(BuildContext context, BuildGameContentState state) {
    print('current state is ${state.runtimeType.toString()}');
    switch (state.runtimeType) {
      case LoadingContentState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case LoadModuliAndConvocationsSingleTeam:
        state as LoadModuliAndConvocationsSingleTeam;
        return Center(
            child: spinnerModulo(context, state.players, state.teamModule, state.moduli,
                isYellow: state.isYellow));
      case LoadModuliAndConvocations:
        state as LoadModuliAndConvocations;
        return Column(
          children: [
            Flexible(
              child: spinnerModulo(context, state.playersGialli, state.moduloGialli, state.moduli),
            ),
            Flexible(
              child: spinnerModulo(context, state.playersVerdi, state.moduloVerdi, state.moduli,
                  isYellow: false),
            ),
          ],
        );
      case BuildCardState:
        state as BuildCardState;
        return Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FakeFootballTitle(title: GIALLI, half: true, color: Colors.yellow),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.dontHaveCardsGialli.length,
                      itemBuilder: (context, i) => BuildCardStatusListItem(
                        state.dontHaveCardsGialli.keys.toList()[i],
                        state.dontHaveCardsGialli[state.dontHaveCardsGialli.keys.toList()[i]]!,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FakeFootballTitle(
                            title: VERDI, half: true, color: Colors.green.shade500)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.dontHaveCardsVerdi.length,
                        itemBuilder: (context, i) => BuildCardStatusListItem(
                          state.dontHaveCardsVerdi.keys.toList()[i],
                          state.dontHaveCardsVerdi[state.dontHaveCardsVerdi.keys.toList()[i]]!,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      case BuildLineUpState:
        state as BuildLineUpState;
        return Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FakeFootballTitle(title: GIALLI, half: true, color: Colors.yellow)),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.giallLineUp.length,
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () {},
                        child: BuildLineUpListElement(state.giallLineUp[i]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: FakeFootballTitle(
                            title: VERDI, half: true, color: Colors.green.shade500)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.verdiLineUp.length,
                        itemBuilder: (context, i) => GestureDetector(
                          onTap: () {},
                          child: BuildLineUpListElement(state.verdiLineUp[i]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      default:
        return const Center(
          child: Text('Unexpected state'),
        );
    }
  }

  Widget rookieStatus(BuildContext context, Map<String, bool> statusForRookies,
      {bool isYellow = true}) {
    String labelText = context.read<BuildContentBloc>().getSpinnerLabel(isYellow);
    Color labelColor = context.read<BuildContentBloc>().getSpinnerLabelColor(isYellow);
    return Flexible(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: labelColor),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: statusForRookies.keys.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  context
                      .read<BuildContentBloc>()
                      .getStatus(statusForRookies[statusForRookies.keys.toList()[index]] ?? false),
                ),
                title: Text(statusForRookies.keys.toList()[index]),
              );
            },
          ),
        ),
      ],
    ));
  }

  Widget spinnerModulo(
      BuildContext context, String players, String? spinnerValue, List<String> moduli,
      {bool isYellow = true}) {
    print('dioporco $spinnerValue');
    String labelText = context.read<BuildContentBloc>().getSpinnerLabel(isYellow);
    Color labelColor = context.read<BuildContentBloc>().getSpinnerLabelColor(isYellow);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: context.getHeightWithoutAppbar(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding:
                      EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25, top: 8.0),
                  child: FakeFootballTitle(title: labelText, half: true, color: labelColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton<String?>(
                  value: spinnerValue,
                  isExpanded: true,
                  hint: Center(
                    child: Text(
                      'Seleziona modulo',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
                    ),
                  ),
                  items: moduli.map<DropdownMenuItem<String?>>(
                    (String modulo) {
                      return DropdownMenuItem<String?>(
                        value: modulo,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              modulo,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (chosenModulo) => context
                      .read<BuildContentBloc>()
                      .add(ChooseModuloEvent(chosenModulo, isYellow)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'CONVOCATI:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text(players, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

bool canGoNext(BuildGameContentState state) {
  if (state is BuildCardState) return state.esito;
  if (state is BuildLineUpState) return state.esito;
  return false;
}

double getHeight(BuildContext? scaffoldContext, BuildContext context) => scaffoldContext != null
    ? MediaQuery.of(context).size.height -
        (Scaffold.of(context).appBarMaxHeight != null ? Scaffold.of(context).appBarMaxHeight! : 0.0)
    : MediaQuery.of(context).size.height;

bool isMobile() => Platform.isFuchsia || Platform.isAndroid || Platform.isIOS;
