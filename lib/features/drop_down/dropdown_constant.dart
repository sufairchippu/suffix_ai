class DropdwnItem {
  String id;
  String data;
  DropdwnItem({required this.data, required this.id});
}
class City {
  final int id;
  final String name;
  City(this.id, this.name);
}

final cities = [City(1, "New York"), City(2, "London"), City(3, "Tokyo")];