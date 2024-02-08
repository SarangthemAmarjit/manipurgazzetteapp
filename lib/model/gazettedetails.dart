// To parse this JSON data, do
//
//     final gazetteDetails = gazetteDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GazetteDetails gazetteDetailsFromJson(String str) =>
    GazetteDetails.fromJson(json.decode(str));

String gazetteDetailsToJson(GazetteDetails data) => json.encode(data.toJson());

class GazetteDetails {
  final int gazetteId;
  final String serialno;
  final String title;
  final String subtitle;
  final String gazetteno;
  final String edition;
  final Entereddt publicationdate;
  final Entereddt notificationdate;
  final int departmentid;
  final String category;
  final String gazettetype;
  final String printingpress;
  final int totalpages;
  final String gazettedoc;
  final String enteredby;
  final Entereddt entereddt;
  final String bundlename;
  final String gazetteDetailsPart;
  final String gazettepart;
  final double price;

  GazetteDetails({
    required this.gazetteId,
    required this.serialno,
    required this.title,
    required this.subtitle,
    required this.gazetteno,
    required this.edition,
    required this.publicationdate,
    required this.notificationdate,
    required this.departmentid,
    required this.category,
    required this.gazettetype,
    required this.printingpress,
    required this.totalpages,
    required this.gazettedoc,
    required this.enteredby,
    required this.entereddt,
    required this.bundlename,
    required this.gazetteDetailsPart,
    required this.gazettepart,
    required this.price,
  });

  factory GazetteDetails.fromJson(Map<String, dynamic> json) => GazetteDetails(
        gazetteId: json["GazetteId"],
        serialno: json["Serialno"],
        title: json["Title"],
        subtitle: json["Subtitle"],
        gazetteno: json["Gazetteno"],
        edition: json["Edition"],
        publicationdate: Entereddt.fromJson(json["Publicationdate"]),
        notificationdate: Entereddt.fromJson(json["Notificationdate"]),
        departmentid: json["Departmentid"],
        category: json["Category"] ?? '',
        gazettetype: json["Gazettetype"],
        printingpress: json["Printingpress"] ?? '',
        totalpages: json["Totalpages"],
        gazettedoc: json["Gazettedoc"],
        enteredby: json["Enteredby"],
        entereddt: Entereddt.fromJson(json["Entereddt"]),
        bundlename: json["Bundlename"],
        gazetteDetailsPart: json["Part"] ?? '',
        gazettepart: json["Gazettepart"] ?? '',
        price: json["Price"],
      );

  Map<String, dynamic> toJson() => {
        "GazetteId": gazetteId,
        "Serialno": serialno,
        "Title": title,
        "Subtitle": subtitle,
        "Gazetteno": gazetteno,
        "Edition": edition,
        "Publicationdate": publicationdate.toJson(),
        "Notificationdate": notificationdate.toJson(),
        "Departmentid": departmentid,
        "Category": category,
        "Gazettetype": gazettetype,
        "Printingpress": printingpress,
        "Totalpages": totalpages,
        "Gazettedoc": gazettedoc,
        "Enteredby": enteredby,
        "Entereddt": entereddt.toJson(),
        "Bundlename": bundlename,
        "Part": gazetteDetailsPart,
        "Gazettepart": gazettepart,
        "Price": price,
      };
}

class Entereddt {
  final int year;
  final int month;
  final int day;
  final int dayOfWeek;
  final int dayOfYear;
  final int dayNumber;

  Entereddt({
    required this.year,
    required this.month,
    required this.day,
    required this.dayOfWeek,
    required this.dayOfYear,
    required this.dayNumber,
  });

  factory Entereddt.fromJson(Map<String, dynamic> json) => Entereddt(
        year: json["Year"],
        month: json["Month"],
        day: json["Day"],
        dayOfWeek: json["DayOfWeek"],
        dayOfYear: json["DayOfYear"],
        dayNumber: json["DayNumber"],
      );

  Map<String, dynamic> toJson() => {
        "Year": year,
        "Month": month,
        "Day": day,
        "DayOfWeek": dayOfWeek,
        "DayOfYear": dayOfYear,
        "DayNumber": dayNumber,
      };
}
