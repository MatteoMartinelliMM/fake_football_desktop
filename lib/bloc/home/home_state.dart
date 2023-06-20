abstract class HomeState {}

class LoadingHomeState extends HomeState {}


class ShowSnackbarState extends HomeState {
  String msg;

  ShowSnackbarState(this.msg);
}

class ChangeRouteState extends HomeState {
  String route;

  ChangeRouteState(this.route);
}

class MenuLoadedState extends HomeState{
  Map<String,String> currentActions;
  Map<String,String> defaultActions;

  MenuLoadedState(this.currentActions, this.defaultActions);
}

