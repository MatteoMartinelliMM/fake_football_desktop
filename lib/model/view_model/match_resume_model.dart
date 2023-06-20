import 'package:fake_football_desktop/model/match_status.dart';

class MatchResumeModel {
  String home;
  String away;
  Map<String, List<String>> homeScorer;
  Map<String, List<String>> awayScorer;
  int homeResult;
  int awayResult;
  MatchState state;

  MatchResumeModel(
      this.home, this.away, this.homeScorer, this.awayScorer, this.homeResult, this.awayResult, this.state);
}
