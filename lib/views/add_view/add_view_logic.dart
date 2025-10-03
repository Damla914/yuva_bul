import 'dart:typed_data';
import 'package:ev_bul/models/animals.dart';
import 'package:ev_bul/product/utility/exceptions/firebase_exceptions.dart';
import 'package:ev_bul/product/utility/firebase/firebase_collection.dart';
import 'package:ev_bul/product/utility/firebase/firebase_utility.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddLogic with FirebaseUtility {
  final TextEditingController subtitleController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  Animal? _selectedAnimal;
  bool isValidateAllForm = false;
  XFile? _selectedFile;

  List<Animal> _items = [];
  Uint8List? _selectedFileBytes;
  List<Animal> get items => _items;
  Uint8List? get selectedFileBytes => _selectedFileBytes;
  final GlobalKey<FormState> formKey = GlobalKey();

  void updateCategory(Animal item) {
    _selectedAnimal = item;
  }

  bool checkValidateAndSave() {
    return isValidateAllForm =
        (formKey.currentState?.validate() ?? false) &&
        _selectedFileBytes != null &&
        _selectedAnimal != null;
  }

  void dispose() {
    subtitleController.dispose();
    titleController.dispose();
    phoneNumberController.dispose();
    _selectedAnimal = null;
    _selectedFile = null;
    _selectedFileBytes = null;
  }

  Future<XFile?> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<void> pickAndCheck(ValueSetter<bool> onUpdate) async {
    _selectedFile = await _pickImage();
    _selectedFileBytes = await _selectedFile?.readAsBytes();
    onUpdate.call(true);
    checkValidateAndSave();
  }

  Future<void> fetchAllCategory() async {
    final response = await fetchList<Animal, Animal>(
      const Animal(),
      FirebaseCollection.category,
    );

    if (response == null) return;

    final uniqueCategories = <String, Animal>{};

    for (final item in response) {
      if (item.category != null &&
          !uniqueCategories.containsKey(item.category)) {
        uniqueCategories[item.category!] = item;
      }
    }

    _items = uniqueCategories.values.toList();
  }

  Future<bool> save() async {
    if (!checkValidateAndSave()) return false;
    final imageReference = createImageReference();
    if (imageReference == null) {
      throw ItemCreateExceptions('imageReferance == null');
    }
    if (_selectedFile == null) return false;
    await imageReference.putData(_selectedFileBytes!);
    final urlPath = await imageReference.getDownloadURL();

    final response = await FirebaseCollection.animal.reference.add(
      Animal(
        category: _selectedAnimal?.category,
        phoneNumber: phoneNumberController.text,
        subtitle: subtitleController.text,
        title: titleController.text,
        image: urlPath,
        categoryId: _selectedAnimal?.categoryId,
      ).toJson(),
    );
    if (response.id.isNotEmpty) return true;
    return false;
  }

  Reference? createImageReference() {
    if (_selectedFile == null) {
      return null;
    }
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final fileName = '${timestamp}_${_selectedFile!.name}';
    final storageRef = FirebaseStorage.instance.ref().child(
      'uploads/$fileName',
    );
    return storageRef;
  }
}
