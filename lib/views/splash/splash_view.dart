import 'package:ev_bul/app/router.dart';
import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/constants/image_constants.dart';
import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:ev_bul/product/widgets/custom_divider_widget.dart';
import 'package:ev_bul/product/widgets/title_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          context.go(AppRoutes.home);
        } else {
          context.go(AppRoutes.login);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomDividerWidget(color: ColorConstants.blue),
            const TitleWidget(value: StringConstants.splashViewTitle),
            const CustomDividerWidget(color: ColorConstants.blue),
            Image.asset(
              ImageConstants.myImage,
              height: 300,
              width: 300,
            ),
            Text(
              StringConstants.appName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: ColorConstants.white,
              ),
            ),
            const CircularProgressIndicator(
              color: ColorConstants.white,
            ),
          ],
        ),
      ),
    );
  }
}
