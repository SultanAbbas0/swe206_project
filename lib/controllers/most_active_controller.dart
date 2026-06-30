import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ActiveCategory { members, teams, projects, machines }

class MostActiveController extends Notifier<ActiveCategory?> {
  @override
  ActiveCategory? build() => null;

  void selectCategory(ActiveCategory category) => state = category;
}

final mostActiveControllerProvider =
    NotifierProvider<MostActiveController, ActiveCategory?>(
        MostActiveController.new);
