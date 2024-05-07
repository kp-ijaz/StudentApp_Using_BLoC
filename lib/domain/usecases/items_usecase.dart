import 'package:blocapp/data/repositories/item_repo.dart';
import 'package:blocapp/domain/entities/post_entity.dart';
import 'package:blocapp/domain/repository/items_repository.dart';

class ItemsUsecase {
  ItemsRepo itemsRepo = ItemsRepoImpl();
  Future<List<ItemsEntity>> getItemsFromDataSource() async {
    final items = await itemsRepo.getItemsFromDataSource();
    return items;
  }
}
