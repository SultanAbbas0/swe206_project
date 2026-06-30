import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/reusable_components/logout_button.dart';
import 'package:swe206_project/views/most_active/most_active_screen.dart';
import 'package:swe206_project/views/projects/projects_screen.dart';
import 'package:swe206_project/views/reserve_machine/reserve_machine.dart';
import 'package:swe206_project/views/teams/teams_screen.dart';

class NavigationScreen extends ConsumerWidget {
  const NavigationScreen({super.key});

  static List<Widget> screens = [
    const TeamsScreen(),
    const ProjectsScreen(),
    const ReserveMachineScreen(),
    const MostActiveScreen(),
  ];

  static List<PersistentBottomNavBarItem> items = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.people),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
      textStyle: defaultTextStyle,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.assignment),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
      textStyle: defaultTextStyle,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.computer),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
      textStyle: defaultTextStyle,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.format_list_numbered),
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
      textStyle: defaultTextStyle,
    ),
  ];

  @override
  Widget build(BuildContext context, ref) {
    return Stack(
      children: [
        PersistentTabView(
          context,
          key: UniqueKey(),
          controller: PersistentTabController(
              initialIndex: ref.read(navBarIndex)),
          backgroundColor: Colors.blueGrey,
          navBarStyle: NavBarStyle.style9,
          screens: screens,
          onItemSelected: (value) =>
              ref.read(navBarIndex.notifier).state = value,
          items: items,
        ),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 68,
          right: 15,
          child: const LogoutButton(),
        ),
      ],
    );
  }
}
