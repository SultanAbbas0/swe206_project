import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swe206_project/controllers/teams_controller.dart';
import 'package:swe206_project/models/project_model.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/repositories/project_repository.dart';

class ProjectsController extends AsyncNotifier<List<ProjectModel>> {
  ProjectRepository get _repo => ref.read(projectRepositoryProvider);

  @override
  Future<List<ProjectModel>> build() {
    return _repo.getProjects();
  }

  Future<void> addProject(
      String name, String leader, List<String> teams) async {
    await _repo.addProject(name, leader, teams);
    ref.invalidateSelf();
    ref.invalidate(teamsControllerProvider);
    ref.invalidate(allTeams);
    ref.invalidate(mostActiveProjects);
    ref.invalidate(mostActiveTeams);
  }

  Future<void> updateProjectTeams(
      String projectName, List<String> teams) async {
    await _repo.updateProjectTeams(projectName, teams);
    ref.invalidateSelf();
    ref.invalidate(teamsControllerProvider);
    ref.invalidate(allTeams);
    ref.invalidate(mostActiveProjects);
    ref.invalidate(mostActiveTeams);
  }
}

final projectsControllerProvider =
    AsyncNotifierProvider<ProjectsController, List<ProjectModel>>(
        ProjectsController.new);
