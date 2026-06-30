import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:swe206_project/controllers/projects_controller.dart';
import 'package:swe206_project/controllers/reserve_machine_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/reusable_components/info_container.dart';
import 'package:swe206_project/reusable_components/info_dialog.dart';
import 'package:swe206_project/reusable_components/loading_indicator.dart';
import 'package:swe206_project/reusable_components/title_container.dart';

class ReserveMachineScreen extends ConsumerWidget {
  const ReserveMachineScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final existingMachines = ref.watch(allExistingMachines);
    final projects = ref.watch(projectsControllerProvider);
    final selectedProjects = ref.watch(reserveMachineControllerProvider);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TitleContainer(title: 'Reserve Machines'),
            SizedBox(height: 15.h),
            Expanded(
              child: existingMachines.when(
                data: (machineList) => ListView.builder(
                  itemCount: machineList.length,
                  itemBuilder: (context, index) {
                    final machineName = machineList[index];
                    final selectedProject =
                        selectedProjects[machineName] ?? '';

                    return InfoContainer(
                      title: machineName,
                      onTap1: () {
                        projects.when(
                          data: (projectList) => showInfoDialog(
                            context,
                            ListView.builder(
                              itemCount: projectList.length,
                              itemBuilder: (context, i) => Container(
                                margin:
                                    EdgeInsets.symmetric(horizontal: 10.w),
                                child: InfoContainer(
                                  title: projectList[i].name,
                                  onTap1: () {
                                    ref
                                        .read(reserveMachineControllerProvider
                                            .notifier)
                                        .selectProject(
                                            machineName, projectList[i].name);
                                    Navigator.pop(context);
                                  },
                                  onTap2: () {},
                                  text1: 'Select',
                                  color1: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          error: (_, __) {},
                          loading: () {},
                        );
                      },
                      onTap2: () async {
                        if (selectedProject.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Select a project first')),
                          );
                          return;
                        }

                        final dateTimeList =
                            await showOmniDateTimeRangePicker(
                          context: context,
                          theme: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF00573F),
                              onPrimary: Colors.black,
                              onSurface: Color(0xFF00573F),
                            ),
                          ),
                        );

                        if (dateTimeList == null || dateTimeList.length < 2) {
                          return;
                        }

                        final success = await ref
                            .read(reserveMachineControllerProvider.notifier)
                            .reserve(
                                machineName, dateTimeList[0], dateTimeList[1]);

                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(success
                                ? 'Reserved Successfully'
                                : 'Machine already reserved for that time'),
                          ),
                        );
                      },
                      text1: selectedProject.isEmpty
                          ? 'Project'
                          : selectedProject,
                      text2: 'Reserve',
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
