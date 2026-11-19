class BusCard {
  String _owner = '';
  int _balance = 0;

  BusCard(String owner, int balance) {
    _owner = owner;
    _balance = balance;
  }

  String get owner {
    return _owner;
  }

  int get balance {
    return _balance;
  }

  set owner(String newName) {
    if (newName.length < 3) {
      print('Error: name too short');
    } else {
      _owner = newName;
    }
  }

  void showInfo() {
    print('Owner: $_owner | Balance: $_balance RWF');
  }

  void topUp(int amount) {
    if (amount >= 500 && amount <= 50000) {
      _balance = _balance + amount;
      print('Topped up $amount RWF');
    } else {
      print('Error: top-up must be 500 to 50000 RWF');
    }
  }

  void pay(int fare) {
    if (fare <= 0) {
      print('Error: fare must be greater than 0 RWF');
    } else if (fare > _balance) {
      print('Card declined');
    } else {
      _balance = _balance - fare;
      print('Paid $fare RWF');
    }
  }
}

class StudentCard extends BusCard {
  int _discount = 0;

  StudentCard(String owner, int balance, int discount)
      : super(owner, balance) {
    _discount = discount;
  }

  @override
  void showInfo() {
    super.showInfo();
    print('Student card: $_discount% off');
  }

  @override
  void pay(int fare) {
    int off = fare * _discount ~/ 100;
    print('Student discount: $off RWF');
    super.pay(fare - off);
  }
}

void main() {
  // D = 19, L = 9
  // Starting balance = 1190
  // Bus fare = 219
  // Discount = 19%

  BusCard card = BusCard('Ama', 1190);

  card.owner = 'Al';
  card.showInfo();

  card.owner = 'Umutoni Yvete';
  card.showInfo();

  card.topUp(100);
  card.topUp(2000);

  card.pay(219);
  card.pay(219);

  card.showInfo();

  StudentCard student =
      StudentCard('Umutoni Yvete', 1190, 19);

  student.pay(219);
  student.showInfo();
}
