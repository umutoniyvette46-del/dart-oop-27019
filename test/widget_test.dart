import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:my_study_planner/main.dart';

void main() {
  testWidgets('AddGoalScreen validates the subject and study hours', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AddGoalScreen()));

    await tester.tap(find.text('Save Goal'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a subject.'), findsOneWidget);
    expect(find.text('Enter hours greater than 0.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Physics');
    await tester.enterText(find.byType(TextFormField).at(1), '0');
    await tester.tap(find.text('Save Goal'));
    await tester.pumpAndSettle();

    expect(find.text('Enter a subject.'), findsNothing);
    expect(find.text('Enter hours greater than 0.'), findsOneWidget);
  });
}
