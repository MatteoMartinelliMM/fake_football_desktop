import 'dart:io';

import 'package:fake_football_desktop/bloc/settings/settings_bloc.dart';
import 'package:fake_football_desktop/bloc/settings/settings_event.dart';
import 'package:fake_football_desktop/bloc/settings/settings_state.dart';
import 'package:fake_football_desktop/components/fake_football_progress_indicator.dart';
import 'package:fake_football_desktop/model/file_entity_type.dart';
import 'package:fake_football_desktop/utils/ext.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class SettingsWidget extends StatefulWidget {
  static const String route = '/SettingsWidget/';

  const SettingsWidget({super.key});

  @override
  State<StatefulWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) async {
          print(state.runtimeType.toString());
          switch (state.runtimeType) {
            case PickDirectoryState:
              state as PickDirectoryState;
              FilePicker.platform
                  .getDirectoryPath(
                      dialogTitle: state.contentKey.replaceAll('_', ' ').capitalize(),
                      initialDirectory: state.initialPath.isNotEmpty
                          ? state.initialPath
                          : (await getApplicationDocumentsDirectory()).path)
                  .then(
                    (path) =>
                        context.read<SettingsBloc>().add(PickPathEvent(state.contentKey, path)),
                  );
              break;
            case PickFileState:
              state as PickFileState;
              FilePicker.platform
                  .pickFiles(
                    dialogTitle: state.contentKey.replaceAll('_', ' ').capitalize(),
                    initialDirectory: state.initialPath.isNotEmpty
                        ? state.initialPath
                        : (await getApplicationDocumentsDirectory()).path,
                    type: state.fileType,
                  )
                  .then((value) => context
                      .read<SettingsBloc>()
                      .add(PickPathEvent(state.contentKey, value?.paths.firstOrNull())));
              break;
            case PickExeState:
              state as PickExeState;
              FilePicker.platform.pickFiles(
                dialogTitle: state.contentKey.replaceAll('_', ' ').capitalize(),
                type: FileType.custom,
                allowedExtensions: ['exe'],
              ).then((value) => context
                  .read<SettingsBloc>()
                  .add(PickPathEvent(state.contentKey, value?.paths.firstOrNull())));
              break;
          }
        },
        listenWhen: (prev, curr) =>
            curr is PickDirectoryState || curr is PickFileState || curr is PickExeState,
        buildWhen: (prev, curr) =>
            curr is! PickDirectoryState && curr is! PickFileState && curr is! PickExeState,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Gestione percorsi',
                style: TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                color: Theme.of(context).scaffoldBackgroundColor,
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            body: _buildBodyByState(context, state),
          );
        });
  }

  Widget _buildBodyByState(BuildContext context, SettingsState state) {
    switch (state.runtimeType) {
      case LoadState:
        return const Center(
          child: FakeFootballProgressIndicator(),
        );
      case PathLoadedState:
        state as PathLoadedState;
        return Center(
          child: ListView.builder(
            itemCount: state.paths.keys.length,
            itemBuilder: (context, i) {
              String k = state.paths.keys.toList()[i];
              String settingValue = getSettingsValue(state.paths, k);
              return InkWell(
                onTap: () => context.read<SettingsBloc>().add(SettingSelectedEvent(k)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _settingsElement(k, settingValue),
                ),
              );
            },
          ),
        );
      default:
        return const Center(child: Text('Unexpected state'));
    }
  }

  List<Widget> _settingsElement(String k, String settingValue) {
    List<Widget> list = [];
    list.add(
      Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: k.getIconBySettings(),
      ),
    );
    list.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        k.replaceAll('_', ' ').toUpperCase(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
    ));
    list.add(Text(
      settingValue,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white70),
    ));
    return list;
  }

  String getSettingsValue(Map<String, dynamic> paths, String k) {
    if (paths[k] != null) {
      switch (paths[k].runtimeType) {
        case String:
          String v = paths[k];
          return !v.isNullOrEmpty() ? v : 'Imposta';
        case int:
          int v = paths[k];
          return !v.isNaN ? v.toString() : 'Imposta';
        case double:
          double v = paths[k];
          return !v.isNaN ? v.toString() : 'Imposta';
        default:
          return 'Imposta';
      }
    }
    return 'Imposta';
  }

  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(EnterPageEvent());
  }
}
