import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:swe206_project/repositories/analytics_repository.dart';
import 'package:swe206_project/repositories/machine_repository.dart';
import 'package:swe206_project/repositories/project_repository.dart';
import 'package:swe206_project/repositories/team_repository.dart';
import 'package:swe206_project/repositories/user_repository.dart';

final userRepositoryProvider = Provider((_) => UserRepository());
final teamRepositoryProvider = Provider((_) => TeamRepository());
final projectRepositoryProvider = Provider((_) => ProjectRepository());
final machineRepositoryProvider = Provider((_) => MachineRepository());
final analyticsRepositoryProvider = Provider((_) => AnalyticsRepository());

final navBarIndex = StateProvider((_) => 0);

final currentUserEmail =
    StateProvider((_) => FirebaseAuth.instance.currentUser?.email ?? '');
final currentUser =
    StateProvider((_) => FirebaseAuth.instance.currentUser);

final authStateProvider =
    StreamProvider<User?>((_) => FirebaseAuth.instance.authStateChanges());

final currentUserObject = FutureProvider((ref) {
  return ref
      .watch(userRepositoryProvider)
      .getCurrentUserObject(ref.watch(currentUserEmail));
});

final allMembers = FutureProvider((ref) {
  return ref.watch(userRepositoryProvider).getMembers();
});

final allTeams = FutureProvider((ref) {
  return ref.watch(teamRepositoryProvider).getTeams();
});

final allExistingMachines = FutureProvider((ref) {
  return ref.watch(machineRepositoryProvider).getExistingMachines();
});

final mostActiveMembers = FutureProvider((ref) {
  return ref.watch(analyticsRepositoryProvider).getMostActiveMembers();
});

final mostActiveTeams = FutureProvider((ref) {
  return ref.watch(analyticsRepositoryProvider).getMostActiveTeams();
});

final mostActiveProjects = FutureProvider((ref) {
  return ref.watch(analyticsRepositoryProvider).getMostActiveProjects();
});

final mostActiveMachines = FutureProvider((ref) {
  return ref.watch(analyticsRepositoryProvider).getMostActiveMachines();
});
