import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/panel_card.dart';
import '../domain/today_models.dart';
import 'state/today_controller.dart';
import 'widgets/today_task_tile.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, required this.controller});

  final TodayController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.loading || controller.data == null) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final data = controller.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Today'),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.bolt),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              _ProgressHeader(data: data),
              const SizedBox(height: 12),
              _TaskCard(data: data),
              const SizedBox(height: 12),
              _FocusTimerCard(
                remainingSeconds: controller.remainingSeconds,
                onStart: controller.startFocusSession,
              ),
              const SizedBox(height: 12),
              _StatsCard(data: data),
              const SizedBox(height: 12),
              _MotivationCard(line: data.motivation),
            ],
          ),
        );
      },
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader({required this.data});

  final TodayData data;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Execution Momentum', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: data.progress,
            minHeight: 10,
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(height: 8),
          Text(
            '${data.completedTasks}/${data.mandatoryTasks.length} mandatory tasks completed',
            style: TextStyle(color: context.palette.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.data});

  final TodayData data;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top 3 Mandatory', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...data.mandatoryTasks.map(
            (task) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TodayTaskTile(title: task.title, completed: task.completed),
            ),
          ),
        ],
      ),
    );
  }
}

class _FocusTimerCard extends StatelessWidget {
  const _FocusTimerCard({required this.remainingSeconds, required this.onStart});

  final int remainingSeconds;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final minutes = (remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds % 60).toString().padLeft(2, '0');

    return PanelCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Focus Sprint', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            '$minutes:$seconds',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start 25 min'),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.data});

  final TodayData data;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Row(
        children: [
          Expanded(child: _StatItem(label: 'Streak', value: '${data.streakDays} days')),
          Expanded(child: _StatItem(label: 'Focus Sessions', value: '${data.sessionsToday} today')),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: context.palette.textSecondary)),
        const SizedBox(height: 4),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}

class _MotivationCard extends StatelessWidget {
  const _MotivationCard({required this.line});

  final String line;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(line, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
