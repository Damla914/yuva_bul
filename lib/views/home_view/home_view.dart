import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:ev_bul/product/widgets/Containers/home_view_container.dart';
import 'package:ev_bul/product/widgets/custom_divider_widget.dart';
import 'package:ev_bul/product/widgets/padding_items.dart';
import 'package:ev_bul/product/widgets/title_text.dart';
import 'package:ev_bul/views/home_view/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((
  ref,
) {
  return HomeNotifier()..fetchAndLoad();
});

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final animalsItem = state.animals ?? [];
    final isLoading = state.isLoading ?? false;

    return Scaffold(
      backgroundColor: ColorConstants.pink,
      body: Center(
        child: Padding(
          padding: PaddingItems.symmetricPadding,
          child: ListView(
            children: [
              const CustomDividerWidget(color: ColorConstants.pink),
              const TitleWidget(value: StringConstants.homeViewTitle),
              const CustomDividerWidget(color: ColorConstants.pink),
              const TextFieldWidget(),
              const CustomDividerWidget(color: ColorConstants.pink),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryButton(value: StringConstants.cat),
                  CategoryButton(value: StringConstants.dog),
                  CategoryButton(value: StringConstants.all),
                ],
              ),
              const CustomDividerWidget(color: ColorConstants.pink),
              if (isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: ColorConstants.white,
                  ),
                )
              else if (animalsItem.isEmpty)
                const Center(child: Text(StringConstants.notFind))
              else
                ...animalsItem.map((animal) {
                  return HomeViewContainer(animalsItem: animal);
                }),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends ConsumerWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      onChanged: (value) {
        ref.read(homeProvider.notifier).filterAnimalsByText(value);
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: StringConstants.searchHintText,
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: ColorConstants.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2),
        ),
      ),
    );
  }
}

class CategoryButton extends ConsumerWidget {
  const CategoryButton({required this.value, super.key});
  final String value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final isSelected = state.selectedCategory == value;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? ColorConstants.grey
            : ColorConstants.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () {
        notifier.fetchAnimalsByCategory(value);
      },
      child: Text(value),
    );
  }
}
