import 'package:idez_test/src/modules/shared/domain/entities/category_entity.dart';

class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromEntity(CategoryModel entity) {
    return CategoryModel(id: entity.id, name: entity.name);
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], name: json['name']);
  }

  CategoryEntity toEntity() => CategoryEntity(id: id, name: name);
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
