import 'package:equatable/equatable.dart';

class ItemsEntity extends Equatable {
  final String title;
  final String image;
  final String category;
  final double price;
  final int id;
  ItemsEntity(
      {required this.id,
      required this.price,
      required this.category,
      required this.title,
      required this.image});

  @override
  List<Object?> get props => [id, price, title, image, category];
}
