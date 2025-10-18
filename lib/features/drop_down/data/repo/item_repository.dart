
import 'package:clean_architutre_learn/features/drop_down/data/entities/dropdown_item.dart';

abstract class ItemRepository {
  /// Fetches all items. In real app this could take filters, paging, etc.
  Future<List<Item>> fetchItems();
}
