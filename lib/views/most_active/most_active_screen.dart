import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/controllers/most_active_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/reusable_components/info_container.dart';
import 'package:swe206_project/reusable_components/loading_indicator.dart';
import 'package:swe206_project/reusable_components/title_container.dart';

class MostActiveScreen extends ConsumerStatefulWidget {
  const MostActiveScreen({super.key});

  @override
  ConsumerState<MostActiveScreen> createState() => _MostActiveScreenState();
}

class _MostActiveScreenState extends ConsumerState<MostActiveScreen> {
  ActiveCategory? category;

  @override
  Widget build(BuildContext context) {
    final membersData = ref.watch(mostActiveMembers);
    final teamsData = ref.watch(mostActiveTeams);
    final projectsData = ref.watch(mostActiveProjects);
    final machinesData = ref.watch(mostActiveMachines);

    final activeAsync = switch (category) {
      ActiveCategory.members => (membersData, 'teams'),
      ActiveCategory.teams => (teamsData, 'members'),
      ActiveCategory.projects => (projectsData, 'teams'),
      ActiveCategory.machines => (machinesData, 'projects'),
      null => null,
    };

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleContainer(title: 'Most Active'),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ActiveCategory.values.map((cat) {
                final label =
                    '${cat.name[0].toUpperCase()}${cat.name.substring(1)}';
                return GestureDetector(
                  onTap: () => setState(() => category = cat),
                  child: Container(
                    height: 45.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: borderRadius(),
                    ),
                    alignment: Alignment.center,
                    child: Text(label, style: defaultTextStyle),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20.h),
            if (activeAsync != null)
              activeAsync.$1.when(
                data: (data) {
                  final keys = data.keys.toList();
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => InfoContainer(
                        title: keys[index],
                        onTap1: () {},
                        onTap2: () {},
                        content: '${data[keys[index]]} ${activeAsync.$2}',
                      ),
                    ),
                  );
                },
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const Expanded(
                  child: Center(child: CustomCircularProgressIndicator()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
