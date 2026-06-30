import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swe206_project/constants.dart';
import 'package:swe206_project/controllers/auth_controller.dart';
import 'package:swe206_project/providers/providers.dart';
import 'package:swe206_project/reusable_components/text_field_with_label.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            SizedBox(height: 60.h),
            Image.asset('assets/images/kfupm_logo.png'),
            SizedBox(height: 10.h),
            TextFieldWithLabel(
                text: "Email", textController: emailController),
            SizedBox(height: 20.h),
            TextFieldWithLabel(
              text: "Password",
              textController: passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: () async {
                await ref
                    .read(authControllerProvider.notifier)
                    .signIn(emailController.text, passwordController.text);
                // ignore: unused_result
                ref.refresh(currentUser);
                ref.read(currentUserEmail.notifier).state =
                    emailController.text;
              },
              child: Container(
                height: 50.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: containerColor, borderRadius: borderRadius()),
                alignment: Alignment.center,
                child: Text("Login", style: defaultTextStyle),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
