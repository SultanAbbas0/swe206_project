import 'package:flutter/material.dart';
import 'package:swe206_project/controllers/teams_controller.dart';
import 'package:swe206_project/models/team_model.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/views/add_entity/add_entity_screen.dart';

class EditTeamScreen extends StatelessWidget {
  const EditTeamScreen({super.key, required this.team});

  final TeamModel team;

  @override
  Widget build(BuildContext context) => AddEntityScreen(
        title: 'Edit Members',
        initialSelected: team.members.map((m) => m.name).toList(),
        watchItems: (ref) => ref.watch(allMembers),
        onDone: (ref, context, name, leader, selected) async {
          await ref
              .read(teamsControllerProvider.notifier)
              .updateTeamMembers(team, selected.cast<String>());
          if (!context.mounted) return;
          Navigator.pop(context);
        },
      );
}
