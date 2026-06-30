import 'package:flutter/material.dart';
import 'package:swe206_project/controllers/projects_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/views/add_entity/add_entity_screen.dart';

class AddProjectScreen extends StatelessWidget {
  const AddProjectScreen({super.key});

  @override
  Widget build(BuildContext context) => AddEntityScreen(
        title: 'Add Project',
        nameFieldLabel: 'Project Name',
        leaderFieldLabel: 'Project Leader',
        watchItems: (ref) => ref.watch(allTeams),
        onDone: (ref, context, name, leader, selected) async {
          await ref
              .read(projectsControllerProvider.notifier)
              .addProject(name, leader, selected.cast<String>());
          if (!context.mounted) return;
          Navigator.pop(context);
        },
      );
}
