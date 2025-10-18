import 'package:clean_architutre_learn/features/drop_down/data/entities/dropdown_item.dart';
import 'package:clean_architutre_learn/features/drop_down/data/repo/item_repository.dart';

class GetItems {
  final ItemRepository repository;
  GetItems(this.repository);

  Future<List<Item>> call() => repository.fetchItems();
}