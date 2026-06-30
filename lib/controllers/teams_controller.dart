import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swe206_project/models/team_model.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/repositories/team_repository.dart';

class TeamsController extends AsyncNotifier<List<TeamModel>> {
  TeamRepository get _repo => ref.read(teamRepositoryProvider);

  @override
  Future<List<TeamModel>> build() {
    final email = ref.watch(currentUserEmail);
    return _repo.getCurrentUserTeams(email);
  }

  Future<void> addTeam(String name, String leader, List<String> members) async {
    await _repo.addTeam(name, leader, members);
    ref.invalidateSelf();
    ref.invalidate(allTeams);
    ref.invalidate(mostActiveMembers);
    ref.invalidate(mostActiveTeams);
  }

  Future<void> updateTeamMembers(
      TeamModel team, List<String> members) async {
    await _repo.updateTeamMembers(team.name, members);
    ref.invalidateSelf();
    ref.invalidate(allTeams);
    ref.invalidate(mostActiveMembers);
    ref.invalidate(mostActiveTeams);
  }

  List<String> getTeamMembers(TeamModel team) => _repo.getTeamMembers(team);
}

final teamsControllerProvider =
    AsyncNotifierProvider<TeamsController, List<TeamModel>>(TeamsController.new);
