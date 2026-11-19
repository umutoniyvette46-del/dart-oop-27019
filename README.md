Dart OOP Assignment: Kigali Bus Card
Name: Umutoni Yvete
Student ID: 27019

My Numbers
D = 19
L = 9
Starting Balance = 1190 RWF
Bus Fare = 219 RWF
Student Discount = 19%
Output of main.dart
Error: name too short
Owner: Ama | Balance: 1190 RWF
Owner: Umutoni Yvete | Balance: 1190 RWF
Error: top-up must be 500 to 50000 RWF
Topped up 2000 RWF
Paid 219 RWF
Paid 219 RWF
Owner: Umutoni Yvete | Balance: 2752 RWF
Student discount: 41 RWF
Paid 178 RWF
Owner: Umutoni Yvete | Balance: 1012 RWF
Student card: 19% off
Part 1: Why no setter for balance?
There is no setter for balance because users should not be able to change the balance directly. The balance should only be modified through methods such as topUp() and pay(). This protects the card from invalid or unauthorized balance changes.

Part 2: What does ~/ do?
The ~/ operator performs integer division in Dart. It divides two numbers and removes the decimal part.

Example:

print(237 * 17 / 100);
Output:

40.29
Example:

print(237 * 17 ~/ 100);
Output:

40
The / operator returns a decimal number, while ~/ returns a whole number.

Part 4: Bug Table
Bug	Why it is wrong	Fix
1	_brand was not initialized	Added String _brand = '';
2	_battery was not initialized	Added int _battery = 0;
3	SmartPhone constructor did not call its parent constructor	Added : super(brand, battery)
4	@override restart() existed but Phone had no restart method	Added restart() method in Phone
5	print(p.battery()) treated a getter as a method	Changed to print(p.battery)
Not a bug	p.battery = 100; is correct when a setter exists	Added battery setter
Part 5
My Prediction
1
5
Explanation
a.add() changes items from 0 to 1.
a.items = -5 is rejected because the setter does not allow negative values.
Therefore, the first print statement outputs 1.
BigBag.add() calls super.add() twice.
First call adds 2 items.
Second call adds another 2 items.
Total becomes 4.
Then b.items = b.items + 1 changes it to 5.
Therefore, the second print statement outputs 5.
Real Output
1
5
Was I Right?
Yes. My prediction was correct.

Repository Information
Repository Name: dart-oop-27019

Required Commits:

Part 1: BusCard
Part 2 and 3: StudentCard and main
Part 4: bug hunt fixed
Part 5: prediction
Part 5: real output and README