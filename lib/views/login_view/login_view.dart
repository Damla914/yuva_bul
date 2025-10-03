import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/constants/image_constants.dart';
import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:ev_bul/product/widgets/custom_divider_widget.dart';
import 'package:ev_bul/product/widgets/padding_items.dart';
import 'package:ev_bul/product/widgets/title_text.dart';
import 'package:ev_bul/views/login_view/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignUp = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    return Scaffold(
      backgroundColor: ColorConstants.green,
      body: Center(
        child: Padding(
          padding: PaddingItems.symmetricPadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TitleWidget(value: StringConstants.splashViewTitle),
                Padding(
                  padding: PaddingItems.bottomPadding,
                  child: Image.asset(
                    ImageConstants.myImage,
                    height: 200,
                    width: 200,
                  ),
                ),
                TextFieldWidget(
                  controller: loginNotifier.emailController,
                  labelText: StringConstants.email,
                ),
                const CustomDividerWidget(color: ColorConstants.green),
                TextFieldWidget(
                  controller: loginNotifier.passwordController,
                  labelText: StringConstants.password,
                  obscureText: true,
                ),
                if (isSignUp) ...[
                  const CustomDividerWidget(color: ColorConstants.green),
                  TextFieldWidget(
                    controller: loginNotifier.confirmPasswordController,
                    labelText: StringConstants.password,
                    obscureText: true,
                  ),
                ],
                const CustomDividerWidget(color: ColorConstants.green),
                ElevatedButtonWidget(
                  isSignUp: isSignUp,
                  loginNotifier: loginNotifier,
                ),
                TextButtonWidget(
                  loginNotifier: loginNotifier,
                  isSignUp: isSignUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    required this.loginNotifier,
    required this.isSignUp,
    super.key,
  });

  final LoginNotifier loginNotifier;
  final bool isSignUp;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loginNotifier.toggleFormType,
      child: Text(
        isSignUp ? StringConstants.comeBack : StringConstants.register,
        style: const TextStyle(color: ColorConstants.white),
      ),
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    required this.isSignUp,
    required this.loginNotifier,
    super.key,
  });

  final bool isSignUp;
  final LoginNotifier loginNotifier;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String? error;
        if (isSignUp) {
          error = await loginNotifier.signUp();
        } else {
          error = await loginNotifier.signIn();
        }

        if (error == null && context.mounted) {
          context.go('/home');
        } else if (error != null) {
          if (!context.mounted) return;
          await showDialog<void>(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Hata'),
              content: const Text('error'),
              actions: [
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.black,
        foregroundColor: ColorConstants.white,
      ),
      child: Text(
        isSignUp ? StringConstants.register : StringConstants.login,
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.controller,
    required this.labelText,
    super.key,
    this.obscureText = false,
  });
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
