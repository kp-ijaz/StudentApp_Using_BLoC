import 'package:blocapp/domain/entities/post_entity.dart';

abstract class ItemsRepo {
  Future<List<ItemsEntity>> getItemsFromDataSource();
}
