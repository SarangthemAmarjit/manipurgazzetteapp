// To parse this JSON data, do
//
//     final allDepartment = allDepartmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllDepartment> allDepartmentFromJson(String str) => List<AllDepartment>.from(json.decode(str).map((x) => AllDepartment.fromJson(x)));

String allDepartmentToJson(List<AllDepartment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDepartment {
    final int id;
    final String name;

    AllDepartment({
        required this.id,
        required this.name,
    });

    factory AllDepartment.fromJson(Map<String, dynamic> json) => AllDepartment(
        id: json["Id"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
    };
}
