// To parse this JSON data, do
//
//     final fotoModel = fotoModelFromJson(jsonString);

import 'dart:convert';

FotoModel fotoModelFromJson(String str) => FotoModel.fromJson(json.decode(str));

String fotoModelToJson(FotoModel data) => json.encode(data.toJson());

class FotoModel {
    String copyright;
    DateTime date;
    String explanation;
    String hdurl;
    String mediaType;
    String serviceVersion;
    String title;
    String url;

    FotoModel({
        this.copyright,
        this.date,
        this.explanation,
        this.hdurl,
        this.mediaType,
        this.serviceVersion,
        this.title,
        this.url,
    });

    factory FotoModel.fromJson(Map<String, dynamic> json) => new FotoModel(
        copyright: json["copyright"],
        date: DateTime.parse(json["date"]),
        explanation: json["explanation"],
        hdurl: json["hdurl"],
        mediaType: json["media_type"],
        serviceVersion: json["service_version"],
        title: json["title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "copyright": copyright,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "explanation": explanation,
        "hdurl": hdurl,
        "media_type": mediaType,
        "service_version": serviceVersion,
        "title": title,
        "url": url,
    };
}
