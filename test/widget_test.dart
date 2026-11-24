import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:study_planner/main.dart';

void main() {
  testWidgets('sample goals can be added, completed, and deleted', (
    tester,
  ) async {
    await tester.pumpWidget(const MyStudyPlannerApp());

    expect(find.text('Mathematics'), findsOneWidget);
    expect(find.text('History'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('History'), findsOneWidget);

    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, isTrue);

    await tester.tap(find.byTooltip('Delete Mathematics goal'));
    await tester.pumpAndSettle();
    expect(find.text('Mathematics'), findsNothing);
  });
}
