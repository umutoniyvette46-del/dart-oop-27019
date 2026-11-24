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

class StudyPlannerHomePage extends StatefulWidget {
  const StudyPlannerHomePage({super.key});

  @override
  State<StudyPlannerHomePage> createState() => _StudyPlannerHomePageState();
}

class _StudyPlannerHomePageState extends State<StudyPlannerHomePage> {
  // LOGIC: Phase 2 keeps study goals in memory as simple maps.
  final List<Map<String, Object>> _goals = [
    {'subject': 'Mathematics', 'hours': 2, 'done': false},
    {'subject': 'Biology', 'hours': 1, 'done': false},
    {'subject': 'English Literature', 'hours': 3, 'done': false},
  ];

  // LOGIC: Toggle one goal's completion state.
  void _toggleGoal(int index) {
    setState(() {
      final isDone = _goals[index]['done'] as bool;
      _goals[index]['done'] = !isDone;
    });
  }

  // LOGIC: Remove one goal from the in-memory list.
  void _deleteGoal(int index) {
    setState(() {
      _goals.removeAt(index);
    });
  }

  // LOGIC: Add a sample goal until the add-goal form arrives in Phase 4.
  void _addSampleGoal() {
    setState(() {
      _goals.add({'subject': 'History', 'hours': 1, 'done': false});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Study Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // STATIC: Heading Section
            const Text(
              'Your Study Goals',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // CONNECTION: Goal row controls call the in-memory goal logic.
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  final subject = goal['subject'] as String;
                  final hours = goal['hours'] as int;
                  final isDone = goal['done'] as bool;
                  final hourLabel = hours == 1 ? 'hour' : 'hours';

                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: isDone,
                        onChanged: (_) => _toggleGoal(index),
                      ),
                      title: Text(
                        subject,
                        style: TextStyle(
                          decoration: isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: isDone ? Colors.grey : null,
                        ),
                      ),
                      subtitle: Text('Planned study time: $hours $hourLabel'),
                      onTap: () => _toggleGoal(index),
                      trailing: IconButton(
                        tooltip: 'Delete $subject goal',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _deleteGoal(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // STATIC: Floating Action Button
      // CONNECTION: The floating action button adds a sample goal.
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleGoal,
        tooltip: 'Add a sample study goal',
        child: const Icon(Icons.add),
      ),
    );
  }
}
