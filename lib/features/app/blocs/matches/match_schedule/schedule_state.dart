part of 'schedule_bloc.dart';
abstract class ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final Map<ScheduleCategory, List<MatchType>> categorizedSchedulees;

  ScheduleLoaded(this.categorizedSchedulees);
}
