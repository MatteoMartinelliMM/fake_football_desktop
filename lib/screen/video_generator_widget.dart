import 'package:fake_football_desktop/bloc/video_generator_bloc/video_generator_bloc.dart';
import 'package:fake_football_desktop/bloc/video_generator_bloc/video_generator_event.dart';
import 'package:fake_football_desktop/bloc/video_generator_bloc/video_generator_state.dart';
import 'package:fake_football_desktop/components/clip_time.dart';
import 'package:fake_football_desktop/model/event.dart';
import 'package:fake_football_desktop/model/event_status.dart';
import 'package:fake_football_desktop/model/event_type.dart';
import 'package:fake_football_desktop/model/sport_match.dart';
import 'package:fake_football_desktop/screen/home_widget.dart';
import 'package:fake_football_desktop/utils/constants.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;

class VideoGeneratorWidget extends StatefulWidget {
  static const String route = '/videoGenerator/';

  VideoGeneratorWidget({super.key});

  @override
  State<StatefulWidget> createState() => VideoGeneratorWidgetState();
}

class VideoGeneratorWidgetState extends State<VideoGeneratorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoGeneratorBloc, VideoGeneratorState>(
      listenWhen: (previous, current) => current is EndJobState || current is CloseState,
      listener: (previous, current) {
        switch (current.runtimeType) {
          case EndJobState:
          case CloseState:
            Navigator.pushNamedAndRemoveUntil(context, HomeWidget.route, ModalRoute.withName('/'));
            break;
        }
      },
      buildWhen: (previous, current) => current is! EndJobState && current is! CloseState,
      builder: (context, state) {
        List<String> menuActions = _buildMenuActions(state);
        return Scaffold(
          appBar: AppBar(
            actions: !menuActions.isNullOrEmpty()
                ? [
                    PopupMenuButton<String>(
                      shape: ShapeBorder.lerp(null, null, 0),
                      elevation: 0,
                      onSelected: (value) =>
                          context.read<VideoGeneratorBloc>().add(OverflowMenuEvent(value)),
                      itemBuilder: (context) {
                        return menuActions.map((String choice) {
                          return PopupMenuItem<String>(
                            textStyle: Theme.of(context).textTheme.titleSmall,
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                    ),
                  ]
                : null,
            title: Text(
              'VIDEO GENERATOR',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.read<VideoGeneratorBloc>().add(BackPressEvent()),
            ),
          ),
          body: _buildBodyByState(context, state),
          floatingActionButton: Visibility(
            visible: canGoNext(state),
            child: FloatingActionButton(
              backgroundColor: Colors.yellow,
              child: const Icon(Icons.navigate_next),
              onPressed: () => context.read<VideoGeneratorBloc>().add(NextEvent()),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<VideoGeneratorBloc>().add(EnterPageEvent());
  }

  bool canGoNext(VideoGeneratorState state) {
    return state is ChooseFakeMomentsState ||
        state is ChooseFakeMomentsEventsState ||
        (state is ShowHighlightsState && state.isViewed) ||
        (state is GeneratingMediaState &&
            state.events.where((e) => e.status != EventStatus.WATCHED).toList().isEmpty);
  }

  Widget _buildBodyByState(BuildContext context, VideoGeneratorState state) {
    print('state is ${state.runtimeType}');
    switch (state.runtimeType) {
      case SportMatchesLoadedState:
        state as SportMatchesLoadedState;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'REGISTRAZIONI',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ListView.builder(
                  itemCount: state.sportMatches.length,
                  itemBuilder: (context, i) {
                    SportMatch csm = state.sportMatches[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                      child: GestureDetector(
                        onTap: () => state.extByFileName.containsKey(csm.dateTime)
                            ? context.read<VideoGeneratorBloc>().add(SportMatchPickedEvent(i))
                            : null,
                        child: ListTile(
                          leading: csm.isFF
                              ? Transform.scale(
                                  scale: 0.8,
                                  child: Image.asset('assets/images/logo_fakefootball.png'))
                              : null,
                          title: Text(
                            '${csm.home} - ${csm.away}'.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: state.extByFileName.containsKey(csm.dateTime)
                              ? Text(
                                  'File name: ${csm.dateTime}${state.extByFileName[csm.dateTime]}')
                              : const Text(
                                  'FILE NOT FOUND',
                                  style: TextStyle(color: Colors.red),
                                ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      case SingleMatchLoadedState:
        SportMatch sm = (state as SingleMatchLoadedState).sportMatch;
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _headerPartita(context, sm, state.videoExt),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.min, children: _buildActions(state.actions)),
                ),
              ),
            )
          ],
        );
      case GeneratingMediaState:
        state as GeneratingMediaState;
        List<Event> events = state.events;
        SportMatch sm = state.sm;
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _headerPartita(context, sm, state.videoExt),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, i) {
                  Event currEvent = events[i];
                  EventStatus status = currEvent.status;
                  if (!currEvent.isPlaceHolder()) {
                    return Dismissible(
                      key: Key(currEvent.fileName()),
                      background: Container(
                        color: Colors.red,
                        child: Stack(
                          fit: StackFit.expand,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete,
                                  size: 48,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.delete,
                                  size: 48,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (_) =>
                          context.read<VideoGeneratorBloc>().add(RemoveClipEvent(i)),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.white)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      currEvent.fileName(),
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    IconButton(
                                        onPressed: status == EventStatus.WATCHED
                                            ? () => context
                                                .read<VideoGeneratorBloc>()
                                                .add(MarkVideoAsFavouriteEvent(i))
                                            : null,
                                        icon: Icon(
                                          currEvent.isFavourite ? Icons.star : Icons.star_border,
                                          color: Colors.yellow,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            ClipTime(
                              currEvent: currEvent,
                              minus: () => context
                                  .read<VideoGeneratorBloc>()
                                  .add(ClipTimeChangeEvent(i, START, false)),
                              plus: () => context
                                  .read<VideoGeneratorBloc>()
                                  .add(ClipTimeChangeEvent(i, START, true)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 350,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.black),
                                    child: status == EventStatus.NOT_EXIST
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.error_outline_outlined),
                                              Text('Media not found.'),
                                            ],
                                          )
                                        : InkWell(
                                            onTap: () => context
                                                .read<VideoGeneratorBloc>()
                                                .add(VideoClickEvent(i)),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Positioned(
                                                  top: 75,
                                                  left: 150,
                                                  child: Card(
                                                    shadowColor: Colors.transparent,
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(80),
                                                    ),
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Icon(Icons.play_arrow,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            ClipTime(
                              currEvent: currEvent,
                              minus: () => context
                                  .read<VideoGeneratorBloc>()
                                  .add(ClipTimeChangeEvent(i, END, false)),
                              plus: () => context
                                  .read<VideoGeneratorBloc>()
                                  .add(ClipTimeChangeEvent(i, END, true)),
                              startTime: false,
                            ),
                            Text(
                              currEvent.status.getLabel(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: currEvent.status.getLabelColor()),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: CircularWhiteButton(
                                const Icon(
                                  Icons.refresh,
                                  color: Colors.black,
                                ),
                                onTap: () =>
                                    context.read<VideoGeneratorBloc>().add(ReClipVideoEvent(i)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        border: Border(bottom: BorderSide(color: Colors.white)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: MediaQuery.of(context).size.width / 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 350,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white), color: Colors.black),
                                  child: status == EventStatus.NOT_EXIST
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Icon(Icons.error_outline_outlined),
                                            Text('Media not found.'),
                                          ],
                                        )
                                      : InkWell(
                                          onTap: () => context
                                              .read<VideoGeneratorBloc>()
                                              .add(VideoClickEvent(i)),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Positioned(
                                                top: 75,
                                                left: 150,
                                                child: Card(
                                                  shadowColor: Colors.transparent,
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(80),
                                                  ),
                                                  child: const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child:
                                                        Icon(Icons.play_arrow, color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'PLACEHOLDER ${currEvent.type.enumName()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          ],
        );
      case ChooseFakeMomentsState:
        state as ChooseFakeMomentsState;
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _headerPartita(context, state.sm, state.videoExt),
            Expanded(
              child: ListView.builder(
                itemCount: state.fakeMomentsChoice.keys.length,
                itemBuilder: (context, i) {
                  EventType type = state.fakeMomentsChoice.keys.toList()[i];
                  print('curr mediatype: ${type.getLabel()}');
                  return ListTile(
                      onTap: () =>
                          context.read<VideoGeneratorBloc>().add(FakeMomentsPickedEvent(type)),
                      leading: type.icon(),
                      title: Text(
                        type.getLabel(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: Colors.white),
                      ),
                      trailing: SizedBox(
                        width: 25,
                        height: 25,
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                          child: Center(
                            child: Text(
                              '${state.fakeMomentsChoice[type]!.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            )
          ],
        );
      case ChooseFakeMomentsEventsState:
        state as ChooseFakeMomentsEventsState;
        return Column(mainAxisSize: MainAxisSize.max, children: [
          _headerPartita(context, state.sm, state.videoExt),
          Expanded(
              child: ListView.builder(
            itemCount: state.currEvents.length,
            itemBuilder: (context, i) {
              Event currEvent = state.currEvents[i];
              EventStatus status = currEvent.status;
              return Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: currEvent.isFakeMoment,
                              onChanged: status == EventStatus.WATCHED
                                  ? (checked) => context
                                      .read<VideoGeneratorBloc>()
                                      .add(FakeMomentsCheckedEvent(checked == true, i))
                                  : null,
                            ),
                            Text(
                              currEvent.fileName(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipTime(
                      currEvent: currEvent,
                      minus: () => context
                          .read<VideoGeneratorBloc>()
                          .add(ClipTimeChangeEvent(i, START, false)),
                      plus: () => context
                          .read<VideoGeneratorBloc>()
                          .add(ClipTimeChangeEvent(i, START, true)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 350,
                            height: 200,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white), color: Colors.black),
                            child: status == EventStatus.NOT_EXIST
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.error_outline_outlined),
                                      Text('Media not found.'),
                                    ],
                                  )
                                : InkWell(
                                    onTap: () =>
                                        context.read<VideoGeneratorBloc>().add(VideoClickEvent(i)),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Positioned(
                                          top: 75,
                                          left: 150,
                                          child: Card(
                                            shadowColor: Colors.transparent,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(80),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons.play_arrow, color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    ClipTime(
                      currEvent: currEvent,
                      minus: () => context
                          .read<VideoGeneratorBloc>()
                          .add(ClipTimeChangeEvent(i, END, false)),
                      plus: () =>
                          context.read<VideoGeneratorBloc>().add(ClipTimeChangeEvent(i, END, true)),
                      startTime: false,
                    ),
                    Text(
                      currEvent.status.getLabel(),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: currEvent.status.getLabelColor()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircularWhiteButton(
                        const Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                        onTap: () => context.read<VideoGeneratorBloc>().add(ReClipVideoEvent(i)),
                      ),
                    ),
                  ],
                ),
              );
            },
          ))
        ]);
      case ShowHighlightsState:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'HIGHLIGHTS',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
              ),
              Flexible(
                child: Container(
                  width: 500,
                  height: 250,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white), color: Colors.black),
                  child: InkWell(
                    onTap: () => context
                        .read<VideoGeneratorBloc>()
                        .add(VideoClickEvent(0, isHighlights: true)),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          top: 100,
                          left: 225,
                          child: Card(
                            shadowColor: Colors.transparent,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.play_arrow, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case LoadPageState:
        state as LoadPageState;
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Visibility(
                    visible: !state.msg.isNullOrEmpty(),
                    child: Text(
                      state.msg ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
              )
            ],
          ),
        );
      case ErrorState:
        state as ErrorState;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Icon(
                  Icons.mood_bad_rounded,
                  color: Colors.grey,
                  size: 72,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  state.errorMsg,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.grey),
                ),
              )
            ],
          ),
        );
      default:
        return const Center(
          child: Text('Unexpected State'),
        );
    }
  }

  Widget _headerPartita(BuildContext context, SportMatch sm, String videoExt) {
    int duration = context.read<VideoGeneratorBloc>().videoLength;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration:
            const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white, width: 2))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                'PARTITA: ${sm.home.toUpperCase()} - ${sm.away.toUpperCase()}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Spacer(),
              Visibility(
                visible: duration != 0,
                child: Text(
                  'TOT.DURATION: ${Duration(milliseconds: duration).toTimerValue()}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
              const Spacer(),
              Text(
                'FILE NAME: ${sm.dateTime}$videoExt',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions(List<String> actions) {
    return actions
        .map((e) => MaterialButton(
              onPressed: () => context.read<VideoGeneratorBloc>().add(MediaTypeSelectedEvent(e)),
              child: Text(
                e,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
              ),
            ))
        .toList();
  }

  List<String> _buildMenuActions(VideoGeneratorState state) {
    switch (state.runtimeType) {
      case GeneratingMediaState:
        state as GeneratingMediaState;
        return [AGGIUNGI_AZIONE]..addAll(state.deletedVideo);
      case ChooseFakeMomentsEventsState:
      case ChooseFakeMomentsState:
        return [AGGIUNGI_AZIONE];
      default:
        return [];
    }
  }
}
