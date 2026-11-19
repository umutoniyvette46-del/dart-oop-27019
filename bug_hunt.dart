class Phone {
  String _brand = '';
  int _battery = 0;

  Phone(String brand, int battery) {
    _brand = brand;
    _battery = battery;
  }

  int get battery {
    return _battery;
  }

  set battery(int value) {
    if (value >= 0 && value <= 100) {
      _battery = value;
    }
  }

  void restart() {
    print('Restarting phone');
  }
}

class SmartPhone extends Phone {
  String _system = '';

  SmartPhone(String brand, int battery, String system)
      : super(brand, battery) {
    _system = system;
  }

  @override
  void restart() {
    print('Restarting $_system');
  }
}

void main() {
  Phone p = Phone('Tecno', 50);
  p.battery = 100;
  print(p.battery);
}