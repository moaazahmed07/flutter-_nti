abstract class MenuItem {
  final String name;
  final double price;

  MenuItem(this.name, this.price);

  String describe();
}

abstract class Staff {
  final String name;

  Staff(this.name);

  String work();
}

abstract class Order {
  final List<MenuItem> items = [];

  void addItem(MenuItem item) {
    items.add(item);
  }

  double total();
}

class Food extends MenuItem {
  Food(super.name, super.price);

  @override
  String describe() => 'Food: $name';
}

class Chef extends Staff {
  Chef(super.name);

  @override
  String work() => '$name prepares food';
}

class SimpleOrder extends Order {
  @override
  double total() {
    double sum = 0;
    for (final item in items) {
      sum += item.price;
    }
    return sum;
  }
}
