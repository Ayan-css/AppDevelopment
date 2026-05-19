import '../domain/today_models.dart';

class TodayRepository {
  Future<TodayData> loadToday() async {
    await Future<void>.delayed(const Duration(milliseconds: 120));

    final tasks = <TodayTask>[
      TodayTask(id: 1, title: 'Close 1 client follow-up loop', completed: true),
      TodayTask(id: 2, title: 'Ship 1 high-value content piece'),
      TodayTask(id: 3, title: 'Record 20 min strategic outreach'),
    ];

    final completed = tasks.where((task) => task.completed).length;

    return TodayData(
      mandatoryTasks: tasks,
      completedTasks: completed,
      streakDays: 6,
      sessionsToday: 2,
      motivation: 'Small focused actions beat perfect plans.',
    );
  }
}
