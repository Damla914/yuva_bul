import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:ev_bul/product/widgets/padding_items.dart';
import 'package:ev_bul/views/profil_view/profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  const AppView({required this.navigatonShell, super.key});
  final StatefulNavigationShell navigatonShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: navigatonShell,
      bottomNavigationBar: NavigationBar(
        backgroundColor: ColorConstants.white,
        selectedIndex: navigatonShell.currentIndex,
        onDestinationSelected: navigatonShell.goBranch,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: StringConstants.appViewSearch,
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: StringConstants.appViewAdd,
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: StringConstants.appViewProfil,
          ),
        ],
      ),
    );
  }

  AppBar appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.white,
      title: Text(
        StringConstants.appName,
        style: Theme.of(
          context,
        ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: PaddingItems.rightPadding,
          child: ValueListenableBuilder<String?>(
            valueListenable: AvatarManager.selectedAvatar,
            builder: (context, avatarPath, _) {
              if (avatarPath == null) {
                return const Icon(Icons.person_outline, color: Colors.black);
              } else {
                return CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(avatarPath),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
