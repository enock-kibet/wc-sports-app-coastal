part of 'schedule_bloc.dart';
abstract class ScheduleEvent {
  const ScheduleEvent();
}

class LoadSchedules extends ScheduleEvent {
  final List<MatchType> matchList;
  const LoadSchedules(this.matchList);
}
