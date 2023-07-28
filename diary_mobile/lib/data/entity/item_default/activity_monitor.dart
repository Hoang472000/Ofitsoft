
import 'package:drift/drift.dart';

import '../../local_data/diary_db.dart';

class ActivityMonitor implements Insertable<ActivityMonitor> {
  int? id;
  int? diaryMonitorId;
  int? activityId;
  String? activity;
  bool? checkYes;
  bool? checkNo;

  ActivityMonitor(
      {this.id,
        this.diaryMonitorId,
        this.activityId,
        this.activity,
        this.checkYes,
        this.checkNo
       });

  factory ActivityMonitor.fromJson(Map<String, dynamic> json) {
    return ActivityMonitor(
      id: json['id'] ?? -1,
      diaryMonitorId: json['diary_monitor_id'] ?? -1,
      activityId: json['activity_id'] ?? -1,
      activity: json['activity'] ?? '',
      checkYes: json['check_yes'] ?? false,
      checkNo: json['check_no'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['diary_monitor_id'] = diaryMonitorId;
    data['activity_id'] = activityId;
    data['activity'] = activity;
    data['check_yes'] = checkYes;
    data['check_no'] = checkNo;
    return data;
  }


  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ActivityMonitorTableCompanion(
        id: Value(id),
        diaryMonitorId: Value(diaryMonitorId),
        activityId: Value(activityId),
        activity: Value(activity),
        checkYes: Value(checkYes),
        checkNo: Value(checkNo))
        .toColumns(nullToAbsent);
  }
}
