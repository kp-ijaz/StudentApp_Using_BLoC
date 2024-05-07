import 'package:blocapp/data/datasources/items_remote_datasource.dart';
import 'package:blocapp/domain/entities/post_entity.dart';
import 'package:blocapp/domain/repository/items_repository.dart';

class ItemsRepoImpl implements ItemsRepo {
  ItemsRemoteDataSource itemsRemoteDataSource = ItemsRemoteDataSourceImp();

  @override
  Future<List<ItemsEntity>> getItemsFromDataSource() async {
    final items = await itemsRemoteDataSource.getItemsFromApi();
    return items;
  }
}
