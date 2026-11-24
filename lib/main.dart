import 'package:material_ui/material_ui.dart';
import 'package:my_study_planner/database_helper.dart';
import 'package:my_study_planner/platform_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabasePlatform();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // STATIC: The app uses MaterialApp and a single home Scaffold.
    return MaterialApp(
      title: 'My Study Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const StudyPlannerScreen(),
    );
  }
}

class StudyPlannerScreen extends StatefulWidget {
  const StudyPlannerScreen({super.key});

  @override
  State<StudyPlannerScreen> createState() => _StudyPlannerScreenState();
}

class _StudyPlannerScreenState extends State<StudyPlannerScreen> {
  final List<Map<String, dynamic>> _goals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    try {
      // CONNECTION: Read saved goals through the database helper.
      final savedGoals = await DatabaseHelper.instance.getGoals();
      if (!mounted) return;
      setState(() {
        _goals
          ..clear()
          ..addAll(savedGoals);
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _showError('load goals', error);
    }
  }

  Future<void> _addGoal() async {
    // CONNECTION: Open the input screen and await its Navigator.pop result.
    final goal = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute<Map<String, dynamic>>(
        builder: (context) => const AddGoalScreen(),
      ),
    );

    if (!mounted || goal == null) return;

    try {
      final id = await DatabaseHelper.instance.insertGoal(goal);
      if (!mounted) return;
      // LOGIC: Update the in-memory list only after SQLite saves the goal.
      setState(() {
        _goals.add({...goal, 'id': id});
      });
    } catch (error) {
      if (mounted) _showError('save goal', error);
    }
  }

  Future<void> _toggleGoal(Map<String, dynamic> goal) async {
    final updatedGoal = {...goal, 'done': !(goal['done'] as bool)};
    try {
      // CONNECTION: Persist completion changes with the existing database ID.
      await DatabaseHelper.instance.updateGoal(updatedGoal);
      if (!mounted) return;
      // LOGIC: setState refreshes the strike-through and summary statistics.
      setState(() {
        final index = _goals.indexWhere((item) => item['id'] == goal['id']);
        if (index != -1) _goals[index] = updatedGoal;
      });
    } catch (error) {
      if (mounted) _showError('update goal', error);
    }
  }

  Future<void> _deleteGoal(Map<String, dynamic> goal) async {
    final id = goal['id'] as int;
    try {
      // CONNECTION: Delete the row before removing it from the visible list.
      await DatabaseHelper.instance.deleteGoal(id);
      if (!mounted) return;
      // LOGIC: Remove the deleted row from memory and recalculate statistics.
      setState(() {
        _goals.removeWhere((item) => item['id'] == id);
      });
    } catch (error) {
      if (mounted) _showError('delete goal', error);
    }
  }

  void _showError(String action, Object error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Couldn't $action: $error")));
  }

  @override
  Widget build(BuildContext context) {
    // LOGIC: fold() and where() recalculate totals from the current goal list.
    final totalHours = _goals.fold<double>(
      0,
      (total, goal) => total + (goal['hours'] as num).toDouble(),
    );
    final completedGoals = _goals.where((goal) => goal['done'] == true).length;
    final remainingGoals = _goals.length - completedGoals;

    return Scaffold(
      appBar: AppBar(title: const Text('My Study Planner')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: StatisticsCard(
                    title: 'Total Hours',
                    value: _formatHours(totalHours),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatisticsCard(
                    title: 'Completed Goals',
                    value: '$completedGoals',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: StatisticsCard(
                    title: 'Remaining Goals',
                    value: '$remainingGoals',
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Your Study Goals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _goals.isEmpty
                ? const Center(
                    child: Text(
                      'No study goals yet. Tap + to add one.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: _goals.length,
                    itemBuilder: (context, index) {
                      final goal = _goals[index];
                      final isDone = goal['done'] as bool;
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: isDone,
                            onChanged: (_) => _toggleGoal(goal),
                          ),
                          title: Text(
                            goal['subject'] as String,
                            style: TextStyle(
                              decoration: isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(
                            '${_formatHours((goal['hours'] as num).toDouble())} hours',
                          ),
                          trailing: IconButton(
                            tooltip: 'Delete ${goal['subject']}',
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => _deleteGoal(goal),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addGoal,
        tooltip: 'Add study goal',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatHours(double hours) {
    return hours == hours.roundToDouble()
        ? hours.toStringAsFixed(0)
        : hours.toString();
  }
}

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class AddGoalScreen extends StatefulWidget {
  const AddGoalScreen({super.key});

  @override
  State<AddGoalScreen> createState() => _AddGoalScreenState();
}

class _AddGoalScreenState extends State<AddGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _hoursController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  void _saveGoal() {
    if (!_formKey.currentState!.validate()) return;

    final goal = <String, dynamic>{
      'subject': _subjectController.text.trim(),
      'hours': double.parse(_hoursController.text.trim()),
      'done': false,
    };

    // CONNECTION: Return the validated goal to the screen that opened this page.
    Navigator.pop(context, goal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Study Goal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter a subject.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hoursController,
                decoration: const InputDecoration(
                  labelText: 'Hours',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  final hours = double.tryParse(value?.trim() ?? '');
                  if (hours == null || !hours.isFinite || hours <= 0) {
                    return 'Enter hours greater than 0.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saveGoal,
                  child: const Text('Save Goal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
