import 'package:equatable/equatable.dart';
import 'package:mysql1/src/results/row.dart';

class Category extends Equatable {
  Category({
    required this.categoryId,
    required this.name,
    required this.isActive,
  });
  late final int categoryId;
  late final String name;
  late final int isActive;

  Category.fromResult(ResultRow r) {
    categoryId = r['categoryId'];
    name = r['name'];
    isActive = r['isActive'];
  }

  @override
  List<Object?> get props => [categoryId, name, isActive];
}
