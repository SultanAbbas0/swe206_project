import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swe206_project/providers/providers.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return OutlinedButton(
      child: const Text(
        "logout",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        ref.read(currentUserEmail.notifier).state = '';
        await FirebaseAuth.instance.signOut();
      },
    );
  }
}
