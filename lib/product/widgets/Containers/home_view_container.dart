import 'package:ev_bul/models/animals.dart';
import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/widgets/custom_divider_widget.dart';
import 'package:ev_bul/product/widgets/padding_items.dart';
import 'package:ev_bul/product/widgets/sub_title_text.dart';
import 'package:ev_bul/product/widgets/title_text.dart';
import 'package:ev_bul/views/home_view/home_detail_view.dart';
import 'package:flutter/material.dart';

class HomeViewContainer extends StatelessWidget {
  const HomeViewContainer({
    required this.animalsItem,
    super.key,
  });

  final Animal? animalsItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (_) => HomeDetailView(animal: animalsItem!),
          ),
        );
      },
      child: Container(
        padding: PaddingItems.smallAllPadding,
        margin: PaddingItems.verticalPadding,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            ClipRRectWidget(animalsItem: animalsItem),
            Expanded(
              child: Padding(
                padding: PaddingItems.allPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (animalsItem!.title != null &&
                        animalsItem!.title!.isNotEmpty)
                      TitleWidget(value: animalsItem!.title!),
                    const CustomDividerWidget(color: ColorConstants.pink),
                    SubtitleWidget(value: animalsItem!.subtitle ?? ''),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClipRRectWidget extends StatelessWidget {
  const ClipRRectWidget({
    required this.animalsItem,
    super.key,
  });

  final Animal? animalsItem;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.network(
        animalsItem!.image ?? '',
        errorBuilder: (context, error, stackTrace) => const Placeholder(),
        height: 150,
        width: 120,
      ),
    );
  }
}
