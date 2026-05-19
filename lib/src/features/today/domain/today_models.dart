class TodayData {
  TodayData({
    required this.mandatoryTasks,
    required this.completedTasks,
    required this.streakDays,
    required this.sessionsToday,
    required this.motivation,
  });

  final List<TodayTask> mandatoryTasks;
  final int completedTasks;
  final int streakDays;
  final int sessionsToday;
  final String motivation;

  double get progress => mandatoryTasks.isEmpty ? 0 : completedTasks / mandatoryTasks.length;
}

class TodayTask {
  TodayTask({required this.id, required this.title, this.completed = false});

  final int id;
  final String title;
  final bool completed;

  TodayTask copyWith({bool? completed}) {
    return TodayTask(
      id: id,
      title: title,
      completed: completed ?? this.completed,
    );
  }
}
