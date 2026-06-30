import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/reusable_components/info_container.dart';
import 'package:swe206_project/reusable_components/text_field_with_label.dart';
import 'package:swe206_project/reusable_components/title_container.dart';

class AddEntityScreen extends HookConsumerWidget {
  const AddEntityScreen({
    super.key,
    required this.title,
    this.nameFieldLabel,
    this.leaderFieldLabel,
    this.initialName,
    this.initialLeader,
    this.initialSelected,
    required this.watchItems,
    required this.onDone,
  });

  final String title;
  final String? nameFieldLabel;
  final String? leaderFieldLabel;
  final String? initialName;
  final String? initialLeader;
  final List<dynamic>? initialSelected;
  final AsyncValue<List<dynamic>> Function(WidgetRef ref) watchItems;
  final Future<void> Function(
    WidgetRef ref,
    BuildContext context,
    String name,
    String leader,
    List<dynamic> selected,
  ) onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController(text: initialName ?? '');
    final leaderController =
        useTextEditingController(text: initialLeader ?? '');
    final items = watchItems(ref);
    final selectedItems =
        useState<List<dynamic>>(List.from(initialSelected ?? []));
    final addColor = useState(Colors.green);
    final removeColor = useState(Colors.red);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleContainer(title: title),
            SizedBox(height: 20.h),
            if (nameFieldLabel != null)
              TextFieldWithLabel(
                  text: nameFieldLabel!, textController: nameController),
            if (leaderFieldLabel != null)
              TextFieldWithLabel(
                  text: leaderFieldLabel!, textController: leaderController),
            SizedBox(height: 10.h),
            Expanded(
              child: items.when(
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => InfoContainer(
                    title: data[index].name as String,
                    isSelected:
                        initialSelected?.contains(data[index].name) ?? false,
                    onTap1: () {
                      if (!selectedItems.value.contains(data[index].name)) {
                        selectedItems.value.add(data[index].name);
                      }
                    },
                    onTap2: () {
                      if (selectedItems.value.contains(data[index].name)) {
                        selectedItems.value.remove(data[index].name);
                      }
                    },
                    text1: 'Add',
                    text2: 'Remove',
                    color1: addColor.value,
                    color2: removeColor.value,
                    switchColor: true,
                  ),
                ),
                error: (error, _) => Text(error.toString()),
                loading: () => const SizedBox.shrink(),
              ),
            ),
            GestureDetector(
              onTap: () => onDone(
                ref,
                context,
                nameController.text,
                leaderController.text,
                selectedItems.value,
              ),
              child: Container(
                height: 30.h,
                width: 100.w,
                margin: EdgeInsets.only(bottom: 30.h),
                decoration: BoxDecoration(
                  borderRadius: borderRadius(),
                  color: containerColor,
                ),
                alignment: Alignment.center,
                child: const Text("Done"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
