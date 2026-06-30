import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/controllers/teams_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/reusable_components/info_container.dart';
import 'package:swe206_project/reusable_components/info_dialog.dart';
import 'package:swe206_project/reusable_components/loading_indicator.dart';
import 'package:swe206_project/reusable_components/members_container.dart';
import 'package:swe206_project/reusable_components/title_container.dart';
import 'package:swe206_project/views/add_team/add_team.dart';
import 'package:swe206_project/views/edit_team/edit_team.dart';

class TeamsScreen extends ConsumerWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final teamsAsync = ref.watch(teamsControllerProvider);
    final userObject = ref.watch(currentUserObject);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleContainer(title: 'Teams'),
            SizedBox(height: 50.h),
            userObject.when(
              data: (user) {
                if (user?.status == 'admin') {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AddTeamScreen()),
                    ),
                    child: Container(
                      height: 30.h,
                      width: 150.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: containerColor,
                          borderRadius: borderRadius()),
                      child: const Text("Add Team+"),
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
              child: teamsAsync.when(
                data: (teams) => ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final isAdmin =
                        userObject.value?.status == 'admin';
                    return InfoContainer(
                      title: teams[index].name,
                      onTap1: () {
                        final members = ref
                            .read(teamsControllerProvider.notifier)
                            .getTeamMembers(teams[index]);
                        showInfoDialog(
                          context,
                          ListView.builder(
                            itemCount: members.length,
                            itemBuilder: (_, i) =>
                                MembersContainer(text: members[i]),
                          ),
                        );
                      },
                      onTap2: () => showInfoDialog(
                        context,
                        MembersContainer(
                            text: teams[index].project ?? 'No project'),
                      ),
                      text1: 'Members',
                      text2: 'Projects',
                      onTap3: isAdmin
                          ? () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditTeamScreen(team: teams[index]),
                                ),
                              )
                          : null,
                      text3: isAdmin ? 'Edit' : null,
                      color3: Colors.blue[300],
                    );
                  },
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
