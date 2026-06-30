import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swe206_project/controllers/projects_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/repositories/machine_repository.dart';
import 'package:swe206_project/repositories/project_repository.dart';

class ReserveMachineController extends Notifier<Map<String, String>> {
  MachineRepository get _machineRepo => ref.read(machineRepositoryProvider);
  ProjectRepository get _projectRepo => ref.read(projectRepositoryProvider);

  @override
  Map<String, String> build() => {};

  void selectProject(String machineName, String projectName) {
    state = {...state, machineName: projectName};
  }

  String selectedProject(String machineName) => state[machineName] ?? '';

  Future<bool> reserve(
      String machineName, DateTime start, DateTime end) async {
    final projectName = state[machineName] ?? '';
    final alreadyReserved =
        await _machineRepo.checkReserved(machineName, start, end);
    if (alreadyReserved) return false;
    await _machineRepo.reserveMachine(machineName, start, end);
    await _projectRepo.reserveForProject(projectName, machineName, '');
    ref.invalidate(allExistingMachines);
    ref.invalidate(projectsControllerProvider);
    ref.invalidate(mostActiveMachines);
    return true;
  }
}

final reserveMachineControllerProvider =
    NotifierProvider<ReserveMachineController, Map<String, String>>(
        ReserveMachineController.new);
