import 'package:victume_mobile/utils/MapConverter.dart';

import 'ApiModelBase.dart';

class Program extends ApiModelBase {
  String id;
  String title;
  String subtitle;
  List<String> warnings;
  int priority;
  String institutionId;
  bool active;

  Program(
      {this.id,
      this.title,
      this.subtitle,
      this.warnings,
      this.priority,
      this.institutionId,
      this.active});

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
        id: map["_id"],
        title: map["title"],
        subtitle: map["subtitle"],
        warnings: MapConverter.toList<String>(
            map["warnings"], (warning) => warning.toString()),
        priority: map["priority"],
        institutionId: map["institutionId"],
        active: map["active"]);
  }
}
