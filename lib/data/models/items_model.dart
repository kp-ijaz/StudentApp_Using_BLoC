import 'package:blocapp/domain/entities/post_entity.dart';

class ItemsModal extends ItemsEntity {
  ItemsModal(
      {required title,
      required image,
      required id,
      required price,
      required category})
      : super(
            id: id,
            image: image,
            title: title,
            price: price,
            category: category);

  factory ItemsModal.fromJson(Map<String, dynamic> json) {
    return ItemsModal(
      title: json['title'],
      image: json['image'],
      id: json['id'],
      price: json['price'].toDouble(),
      category: json['category'],
    );
  }
}
