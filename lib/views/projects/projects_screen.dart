import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/controllers/projects_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/reusable_components/info_container.dart';
import 'package:swe206_project/reusable_components/info_dialog.dart';
import 'package:swe206_project/reusable_components/loading_indicator.dart';
import 'package:swe206_project/reusable_components/members_container.dart';
import 'package:swe206_project/reusable_components/title_container.dart';
import 'package:swe206_project/views/add_project/add_project.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final projectsAsync = ref.watch(projectsControllerProvider);
    final userObject = ref.watch(currentUserObject);
    final allTeamsAsync = ref.watch(allTeams);
    final isAdmin = userObject.value?.status == 'admin';

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleContainer(title: 'Projects'),
            SizedBox(height: 50.h),
            userObject.when(
              data: (user) {
                if (user?.status == 'admin') {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddProjectScreen()),
                    ),
                    child: Container(
                      height: 30.h,
                      width: 150.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: borderRadius()),
                      child: const Text("Add Project+"),
                    ),
                  );
                }
                return Container();
              },
              error: (e, _) => Text(e.toString()),
              loading: () => const CustomCircularProgressIndicator(),
            ),
            SizedBox(height: 5.h),
            Expanded(
              child: projectsAsync.when(
                data: (projects) => ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) => InfoContainer(
                    title: projects[index].name,
                    onTap1: () {
                      if (!isAdmin) {
                        showInfoDialog(
                          context,
                          ListView.builder(
                            itemCount: projects[index].teams.length,
                            itemBuilder: (_, i) => MembersContainer(
                                text: projects[index].teams[i]),
                          ),
                        );
                        return;
                      }
                      allTeamsAsync.whenData((allTeamsList) {
                        final currentTeams =
                            List<String>.from(projects[index].teams);
                        showDialog(
                          context: context,
                          builder: (ctx) => StatefulBuilder(
                            builder: (ctx, setState) => AlertDialog(
                              title: const Text('Edit Teams'),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: allTeamsList
                                      .map((team) => CheckboxListTile(
                                            title: Text(team.name),
                                            value: currentTeams
                                                .contains(team.name),
                                            activeColor:
                                                const Color(0xFF00573F),
                                            onChanged: (val) {
                                              setState(() {
                                                if (val == true) {
                                                  currentTeams.add(team.name);
                                                } else {
                                                  currentTeams
                                                      .remove(team.name);
                                                }
                                              });
                                            },
                                          ))
                                      .toList(),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(ctx);
                                    await ref
                                        .read(projectsControllerProvider
                                            .notifier)
                                        .updateProjectTeams(
                                            projects[index].name,
                                            currentTeams);
                                  },
                                  child: const Text('Save',
                                      style: TextStyle(
                                          color: Color(0xFF00573F))),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    onTap2: () {
                      final machines =
                          projects[index].machines.toSet().toList();
                      showInfoDialog(
                        context,
                        ListView.builder(
                          itemCount: machines.length,
                          itemBuilder: (_, i) =>
                              MembersContainer(text: machines[i]),
                        ),
                      );
                    },
                    text1: isAdmin ? 'Edit Teams' : 'Teams',
                    text2: 'Machines',
                  ),
                ),
                error: (e, _) => Text(e.toString()),
                loading: () => const CustomCircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
