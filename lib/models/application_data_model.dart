import 'dart:convert';
import 'dart:typed_data';

import 'package:applock/models/application_data.dart';

class ApplicationDataModel {
  bool? isLocked;
  ApplicationData? application;
  ApplicationDataModel({
    this.isLocked,
    this.application,
  });


  factory ApplicationDataModel.fromJson(Map<String, dynamic> json) =>
      ApplicationDataModel(
        isLocked: json["isLocked"],
        application: json["application"] == null
            ? null
            : ApplicationData.fromJson(json["application"]),
      );

  Map<String, dynamic> toJson() => {
        "isLocked": isLocked,
        "application": application == null ? null : application!.toJson(),
      };
}

List<ApplicationDataModel> applicationDataModelFromJson(String str) =>
    List<ApplicationDataModel>.from(
        json.decode(str).map((x) => ApplicationDataModel.fromJson(x)));

String applicationDataModelToJson(List<ApplicationDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
