import 'package:ev_bul/models/animals.dart';
import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/constants/image_constants.dart';
import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:ev_bul/product/widgets/custom_divider_widget.dart';
import 'package:ev_bul/product/widgets/padding_items.dart';
import 'package:ev_bul/product/widgets/sub_title_text.dart';
import 'package:ev_bul/product/widgets/title_text.dart';
import 'package:ev_bul/views/profil_view/favorites_provider.dart';
import 'package:ev_bul/views/profil_view/profil_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilView extends ConsumerStatefulWidget {
  const ProfilView({super.key});

  @override
  ConsumerState<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends ConsumerState<ProfilView> {
  String? selectedAvatar;

  final List<String> avatars = [
    ImageConstants.dogIcon,
    ImageConstants.foxIcon,
    ImageConstants.bearIcon,
    ImageConstants.catIcon,
    ImageConstants.smallDogIcon,
    ImageConstants.penguinIcon,
  ];

  @override
  Widget build(BuildContext context) {
    final favoriteAnimals = ref.watch(favoritesProvider);
    return Scaffold(
      backgroundColor: ColorConstants.orange,
      body: Padding(
        padding: PaddingItems.allPadding,
        child: Column(
          children: [
            CircleAvatarWidget(selectedAvatar: selectedAvatar, radius: 50),
            const CustomDividerWidget(color: ColorConstants.orange),
            const TitleWidget(value: StringConstants.profilViewSubtitle),
            const CustomDividerWidget(color: ColorConstants.orange),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: avatars.map((avatar) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatar;
                      AvatarManager.selectedAvatar.value = avatar;
                    });
                  },
                  child: Padding(
                    padding: PaddingItems.horizantalPadding,
                    child: CircleAvatarWidget(
                      selectedAvatar: avatar,
                      radius: 18,
                    ),
                  ),
                );
              }).toList(),
            ),
            const CustomDividerWidget(color: ColorConstants.orange),
            const Align(
              alignment: Alignment.centerLeft,
              child: TitleWidget(value: StringConstants.favorites),
            ),
            const CustomDividerWidget(color: ColorConstants.orange),
            Expanded(
              child: favoriteAnimals.isEmpty
                  ? const Center(
                      child: SubtitleWidget(value: StringConstants.notFind),
                    )
                  : ListView.builder(
                      itemCount: favoriteAnimals.length,
                      itemBuilder: (context, index) {
                        final animal = favoriteAnimals[index];
                        return ListTileWidget(animal: animal, ref: ref);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    required this.animal,
    required this.ref,
    super.key,
  });

  final Animal animal;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.pets,
        color: ColorConstants.white,
      ),
      title: Text(animal.title ?? ''),
      trailing: IconButton(
        icon: const Icon(
          Icons.remove_circle,
          color: ColorConstants.red,
        ),
        onPressed: () {
          ref.read(favoritesProvider.notifier).removeFavorite(animal);
        },
      ),
    );
  }
}

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    required this.selectedAvatar,
    this.radius = 30,
    super.key,
  });

  final String? selectedAvatar;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorConstants.white,
      backgroundImage: selectedAvatar != null
          ? AssetImage(selectedAvatar!)
          : null,
      child: selectedAvatar == null
          ? Icon(Icons.person, size: radius, color: Colors.grey)
          : null,
    );
  }
}
