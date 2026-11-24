import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyStudyPlannerApp());
}

// STATIC: App Structure
class MyStudyPlannerApp extends StatelessWidget {
  const MyStudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Study Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const StudyPlannerHomePage(),
    );
  }
}

class StudyPlannerHomePage extends StatelessWidget {
  const StudyPlannerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Study Planner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            // STATIC: Heading Section
            Text(
              'Your Study Goals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),

            // STATIC: Goal Cards
            Card(
              child: ListTile(
                title: Text('Mathematics'),
                subtitle: Text('Planned study time: 2 hours'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Biology'),
                subtitle: Text('Planned study time: 1 hour'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('English Literature'),
                subtitle: Text('Planned study time: 3 hours'),
              ),
            ),
          ],
        ),
      ),
      // STATIC: Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add a study goal',
        child: const Icon(Icons.add),
      ),
    );
  }
}
