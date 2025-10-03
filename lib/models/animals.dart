import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ev_bul/product/utility/base/base_firebase_model.dart';

class Animal extends Equatable implements IdModel, BaseFirebaseModel<Animal> {
  const Animal({
    this.category,
    this.categoryId,
    this.id,
    this.subtitle,
    this.image,
    this.phoneNumber,
    this.title,
  });
  final String? category;
  final String? categoryId;
  final String? image;
  final String? subtitle;
  final String? phoneNumber;
  final String? title;
  @override
  final String? id;

  @override
  List<Object?> get props => [
    category,
    categoryId,
    image,
    subtitle,
    id,
    phoneNumber,
    title,
  ];

  Animal copyWith({
    String? category,
    String? categoryId,
    String? image,
    String? subtitle,
    String? id,
    String? phoneNumber,
    String? title,
  }) {
    return Animal(
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      image: image ?? this.image,
      id: id ?? this.id,
      subtitle: subtitle ?? this.subtitle,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'categoryId': categoryId,
      'image': image,
      'subtitle': subtitle,
      //'id': id,
      'phoneNumber': phoneNumber,
      'title': title,
    };
  }

  @override
  Animal fromJson(Map<String, dynamic> json) {
    return Animal(
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      image: json['image'] as String?,
      subtitle: json['subtitle'] as String?,
      id: json['id'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      title: json['title'] as String?,
    );
  }

  @override
  Animal fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const Animal();

    return Animal(
      category: data['category'] as String?,
      categoryId: data['categoryId'] as String?,
      image: data['image'] as String?,
      subtitle: data['subtitle'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      title: data['title'] as String?,
      id: snapshot.id,
    );
  }
}
