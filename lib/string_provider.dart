class StringProvider {
  List<String> _items = [];

  String getPositionValue(int index) => _items[index];

  int get count => _items.length;

  void update(String color, int count) {
    List<String> values = [];
    for (var i = 0; i < count; i++) {
      values.add('$color value $i');
    }
    _items = values;
    // print("_count:$count");
  }
}
