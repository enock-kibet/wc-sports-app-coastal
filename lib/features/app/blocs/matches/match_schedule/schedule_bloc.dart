import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/data/models/match/match.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

enum ScheduleCategory { today, tomorrow, thisWeek, future }


class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {

  ScheduleBloc() : super(ScheduleLoading()) {
    on<LoadSchedules>((event, emit) {
      final matches = event.matchList; // Replace with your data source
      final categorized = _categorizeSchedules(matches);
      emit(ScheduleLoaded(categorized));
    });
  }



  Map<ScheduleCategory, List<MatchType>> _categorizeSchedules(List<MatchType> matches) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final endOfWeek = today.add(Duration(days: 7 - today.weekday));

    Map<ScheduleCategory, List<MatchType>> categorized = {
      ScheduleCategory.today: [],
      ScheduleCategory.tomorrow: [],
      ScheduleCategory.thisWeek: [],
      ScheduleCategory.future: [],
    };

    for (var match in matches) {
      final matchDate = DateTime(match.matchDate.year, match.matchDate.month, match.matchDate.day);
      if (matchDate == today) {
        categorized[ScheduleCategory.today]!.add(match);
      } else if (matchDate == tomorrow) {
        categorized[ScheduleCategory.tomorrow]!.add(match);
      } else if (matchDate.isAfter(tomorrow) && matchDate.isBefore(endOfWeek)) {
        categorized[ScheduleCategory.thisWeek]!.add(match);
      } else if (matchDate.isAfter(endOfWeek)) {
        categorized[ScheduleCategory.future]!.add(match);
      }
    }

    categorized.removeWhere((key, value) => value.isEmpty);
    return categorized;
  }
}
