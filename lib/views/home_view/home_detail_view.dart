import 'package:ev_bul/models/animals.dart';
import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:ev_bul/product/widgets/custom_divider_widget.dart';
import 'package:ev_bul/product/widgets/elavated_button_widget.dart';
import 'package:ev_bul/product/widgets/padding_items.dart';
import 'package:ev_bul/product/widgets/sub_title_text.dart';
import 'package:ev_bul/product/widgets/title_text.dart';
import 'package:ev_bul/views/profil_view/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDetailView extends ConsumerWidget {
  const HomeDetailView({required this.animal, super.key});
  final Animal animal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(favoritesProvider);
    final isFav = ref.read(favoritesProvider.notifier).isFavorite(animal);
    return Scaffold(
      backgroundColor: ColorConstants.amber,
      appBar: AppBar(
        backgroundColor: ColorConstants.white,
        title: TitleWidget(value: animal.title ?? ''),
        leading: const IconButtonWidget(),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              final notifier = ref.read(favoritesProvider.notifier);
              if (isFav) {
                notifier.removeFavorite(animal);
              } else {
                notifier.addFavorite(animal);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: PaddingItems.allPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (animal.image != null)
              Center(
                child: ClipRRectWidget(animal: animal),
              ),
            const CustomDividerWidget(color: ColorConstants.black),
            TitleWidget(value: animal.title ?? ''),
            const CustomDividerWidget(color: ColorConstants.black),
            SubtitleWidget(value: animal.subtitle ?? ''),
            if (animal.phoneNumber != null && animal.phoneNumber!.isNotEmpty)
              Padding(
                padding: PaddingItems.topPadding,
                child: Row(
                  children: [
                    const Icon(Icons.phone, size: 20),
                    const SizedBox(width: 8),
                    SubtitleWidget(value: animal.phoneNumber ?? ''),
                  ],
                ),
              ),
            const CustomDividerWidget(color: ColorConstants.amber),
            const ElevatedButtonWidget(value: StringConstants.adopt),
          ],
        ),
      ),
    );
  }
}

class ClipRRectWidget extends StatelessWidget {
  const ClipRRectWidget({
    required this.animal,
    super.key,
  });

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        animal.image!,
        width: 250,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }
}
