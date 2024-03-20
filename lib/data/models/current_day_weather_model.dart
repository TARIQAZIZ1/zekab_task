import 'package:meta/meta.dart';
import 'dart:convert';

class CurrentWeatherModel {
  final double? latitude;
  final double? longitude;
  final double? generationtimeMs;
  final int? utcOffsetSeconds;
  final String? timezone;
  final String? timezoneAbbreviation;
  final double? elevation;
  final Units? currentUnits;
  final Current? current;
  final Units? hourlyUnits;
  final Hourly? hourly;

  CurrentWeatherModel({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.currentUnits,
    required this.current,
    required this.hourlyUnits,
    required this.hourly,
  });

  factory CurrentWeatherModel.fromRawJson(String str) => CurrentWeatherModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) => CurrentWeatherModel(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    generationtimeMs: json["generationtime_ms"]?.toDouble(),
    utcOffsetSeconds: json["utc_offset_seconds"],
    timezone: json["timezone"],
    timezoneAbbreviation: json["timezone_abbreviation"],
    elevation: json["elevation"]?.toDouble(),
    currentUnits: Units.fromJson(json["current_units"]),
    current: Current.fromJson(json["current"]),
    hourlyUnits: Units.fromJson(json["hourly_units"]),
    hourly: Hourly.fromJson(json["hourly"]),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "generationtime_ms": generationtimeMs,
    "utc_offset_seconds": utcOffsetSeconds,
    "timezone": timezone,
    "timezone_abbreviation": timezoneAbbreviation,
    "elevation": elevation,
    "current_units": currentUnits?.toJson(),
    "current": current?.toJson(),
    "hourly_units": hourlyUnits?.toJson(),
    "hourly": hourly?.toJson(),
  };
}

class Current {
  final String? time;
  final int? interval;
  final double? temperature2M;
  final double? windSpeed10M;
  final int? relativeHumidity2M;
  final int? precipitationProbability;

  Current({
    required this.time,
    required this.interval,
    required this.temperature2M,
    required this.windSpeed10M,
    required this.relativeHumidity2M,
    required this.precipitationProbability,
  });

  factory Current.fromRawJson(String str) => Current.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    time: json["time"],
    interval: json["interval"],
    temperature2M: json["temperature_2m"]?.toDouble(),
    windSpeed10M: json["wind_speed_10m"]?.toDouble(),
    relativeHumidity2M: json["relative_humidity_2m"],
    precipitationProbability: json["precipitation_probability"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "interval": interval,
    "temperature_2m": temperature2M,
    "wind_speed_10m": windSpeed10M,
    "relative_humidity_2m": relativeHumidity2M,
    "precipitation_probability": precipitationProbability,
  };
}

class Units {
  final String? time;
  final String? interval;
  final String? temperature2M;
  final String? windSpeed10M;
  final String? relativeHumidity2M;
  final String? precipitationProbability;

  Units({
    required this.time,
    required this.interval,
    required this.temperature2M,
    required this.windSpeed10M,
    required this.relativeHumidity2M,
    required this.precipitationProbability,
  });

  factory Units.fromRawJson(String str) => Units.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Units.fromJson(Map<String, dynamic> json) => Units(
    time: json["time"],
    interval: json["interval"],
    temperature2M: json["temperature_2m"],
    windSpeed10M: json["wind_speed_10m"],
    relativeHumidity2M: json["relative_humidity_2m"],
    precipitationProbability: json["precipitation_probability"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "interval": interval,
    "temperature_2m": temperature2M,
    "wind_speed_10m": windSpeed10M,
    "relative_humidity_2m": relativeHumidity2M,
    "precipitation_probability": precipitationProbability,
  };
}

class Hourly {
  final List<String>? time;
  final List<double>? temperature2M;
  final List<int>? relativeHumidity2M;
  final List<double>? windSpeed10M;
  final List<int>? precipitationProbability;

  Hourly({
    required this.time,
    required this.temperature2M,
    required this.relativeHumidity2M,
    required this.windSpeed10M,
    required this.precipitationProbability,
  });

  factory Hourly.fromRawJson(String str) => Hourly.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    time: List<String>.from(json["time"].map((x) => x)),
    temperature2M: List<double>.from(json["temperature_2m"].map((x) => x?.toDouble())),
    relativeHumidity2M: List<int>.from(json["relative_humidity_2m"].map((x) => x)),
    windSpeed10M: List<double>.from(json["wind_speed_10m"].map((x) => x?.toDouble())),
    precipitationProbability: List<int>.from(json["precipitation_probability"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "time": List<dynamic>.from(time!.map((x) => x)),
    "temperature_2m": List<dynamic>.from(temperature2M!.map((x) => x)),
    "relative_humidity_2m": List<dynamic>.from(relativeHumidity2M!.map((x) => x)),
    "wind_speed_10m": List<dynamic>.from(windSpeed10M!.map((x) => x)),
    "precipitation_probability": List<dynamic>.from(precipitationProbability!.map((x) => x)),
  };
}
