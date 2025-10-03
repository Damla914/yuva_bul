import 'package:ev_bul/models/animals.dart';
import 'package:ev_bul/product/constants/color_constants.dart';
import 'package:ev_bul/product/constants/string_constants.dart';
import 'package:ev_bul/product/enums/widget_size.dart';
import 'package:ev_bul/product/widgets/custom_divider_widget.dart';
import 'package:ev_bul/product/widgets/padding_items.dart';
import 'package:ev_bul/product/widgets/title_text.dart';
import 'package:ev_bul/views/add_view/add_view_logic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> with Loading {
  late final AddLogic _addLogic;

  @override
  void initState() {
    super.initState();
    _addLogic = AddLogic();
    _fetchInitialCategory();
  }

  Future<void> _fetchInitialCategory() async {
    await _addLogic.fetchAllCategory();
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.purple,
      body: Form(
        key: _addLogic.formKey,
        onChanged: () => setState(() {
          _addLogic.checkValidateAndSave();
        }),
        autovalidateMode: AutovalidateMode.disabled,
        child: Padding(
          padding: PaddingItems.allPadding,
          child: ListView(
            children: [
              const TitleWidget(value: StringConstants.addViewTitle),
              const CustomDividerWidget(color: ColorConstants.purple),
              Material(
                color: ColorConstants.transparent,
                child: InkWell(
                  onTap: () async {
                    await _addLogic.pickAndCheck((_) {
                      setState(() {});
                    });
                  },
                  child: ImageWidget(addLogic: _addLogic),
                ),
              ),

              const CustomDividerWidget(color: ColorConstants.purple),
              TextFieldWidget(
                value: StringConstants.textFieldTitle,
                controller: _addLogic.titleController,
              ),
              const CustomDividerWidget(color: ColorConstants.purple),
              TextFieldWidget(
                value: StringConstants.textfieldsubtitle,
                controller: _addLogic.subtitleController,
              ),
              const CustomDividerWidget(color: ColorConstants.purple),
              _HomeCategoryDropdown(
                categories: _addLogic.items,
                onSelected: (animal) {
                  _addLogic.updateCategory(animal);
                  setState(() {
                    _addLogic.checkValidateAndSave();
                  });
                },
              ),
              const CustomDividerWidget(color: ColorConstants.purple),
              TextFieldWidget(
                value: StringConstants.textfieldphonenumber,
                controller: _addLogic.phoneNumberController,
              ),
              const CustomDividerWidget(color: ColorConstants.purple),
              if (!_addLogic.isValidateAllForm)
                const Padding(
                  padding: PaddingItems.bottomPadding12,
                  child: Text(
                    StringConstants.addViewWarning,
                    style: TextStyle(
                      color: ColorConstants.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(
                    WidgetSize.buttonNormal.value.toDouble(),
                  ),
                ),
                onPressed: !_addLogic.isValidateAllForm
                    ? null
                    : () async {
                        changeLoading();
                        final response = await _addLogic.save();
                        changeLoading();
                        if (!context.mounted) return;
                        if (response) {
                          context.pop(true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(StringConstants.failed),
                            ),
                          );
                        }
                      },
                icon: const Icon(Icons.add, color: ColorConstants.black),
                label: const Text(StringConstants.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required AddLogic addLogic,
    super.key,
  }) : _addLogic = addLogic;

  final AddLogic _addLogic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorConstants.white,
          border: Border.all(),
        ),
        child: _addLogic.selectedFileBytes != null
            ? Image.memory(_addLogic.selectedFileBytes!)
            : const Icon(Icons.add_a_photo_outlined),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.value,
    required this.controller,
    super.key,
  });

  final String value;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => (value == null || value.isEmpty) ? '' : null,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: value,
        filled: true,
        fillColor: ColorConstants.white,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.7),
        ),
      ),
    );
  }
}

class _HomeCategoryDropdown extends StatelessWidget {
  const _HomeCategoryDropdown({
    required this.categories,
    required this.onSelected,
  });
  final List<Animal> categories;
  final ValueSetter<Animal> onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Animal>(
      validator: (value) => value == null ? '' : null,
      items: categories.map((e) {
        return DropdownMenuItem<Animal>(
          value: e,
          child: Text(e.category ?? ''),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) onSelected(value);
      },
      decoration: const InputDecoration(
        hintText: StringConstants.dropdownhint,
        filled: true,
        fillColor: ColorConstants.white,
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.7),
        ),
      ),
    );
  }
}

mixin Loading on State<AddView> {
  bool isLoading = false;
  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }
}
