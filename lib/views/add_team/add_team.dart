import 'package:flutter/material.dart';
import 'package:swe206_project/controllers/teams_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/views/add_entity/add_entity_screen.dart';

class AddTeamScreen extends StatelessWidget {
  const AddTeamScreen({super.key});

  @override
  Widget build(BuildContext context) => AddEntityScreen(
        title: 'Add Team',
        nameFieldLabel: 'Team Name',
        leaderFieldLabel: 'Team Leader',
        watchItems: (ref) => ref.watch(allMembers),
        onDone: (ref, context, name, leader, selected) async {
          await ref
              .read(teamsControllerProvider.notifier)
              .addTeam(name, leader, selected.cast<String>());
          if (!context.mounted) return;
          Navigator.pop(context);
        },
      );
}
