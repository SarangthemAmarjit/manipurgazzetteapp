// To parse this JSON data, do
//
//     final allSearchResultData = allSearchResultDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllSearchResultData> allSearchResultDataFromJson(String str) => List<AllSearchResultData>.from(json.decode(str).map((x) => AllSearchResultData.fromJson(x)));

String allSearchResultDataToJson(List<AllSearchResultData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllSearchResultData {
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
    final dynamic printingpress;
    final int totalpages;
    final String gazettedoc;
    final String enteredby;
    final Entereddt entereddt;
    final String bundlename;
    final String allSearchResultDatumPart;
    final String gazettepart;

    AllSearchResultData({
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
        required this.allSearchResultDatumPart,
        required this.gazettepart,
    });

    factory AllSearchResultData.fromJson(Map<String, dynamic> json) => AllSearchResultData(
        gazetteId: json["GazetteId"],
        serialno: json["Serialno"],
        title: json["Title"],
        subtitle: json["Subtitle"],
        gazetteno: json["Gazetteno"],
        edition: json["Edition"],
        publicationdate: Entereddt.fromJson(json["Publicationdate"]),
        notificationdate: Entereddt.fromJson(json["Notificationdate"]),
        departmentid: json["Departmentid"],
        category: json["Category"],
        gazettetype: json["Gazettetype"],
        printingpress: json["Printingpress"],
        totalpages: json["Totalpages"],
        gazettedoc: json["Gazettedoc"],
        enteredby: json["Enteredby"],
        entereddt: Entereddt.fromJson(json["Entereddt"]),
        bundlename: json["Bundlename"],
        allSearchResultDatumPart: json["Part"],
        gazettepart: json["Gazettepart"],
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
        "Part": allSearchResultDatumPart,
        "Gazettepart": gazettepart,
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


