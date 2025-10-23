class Country {
  int country_id;
  String country_name;

  Country({
    this.country_id = 0,
    this.country_name = "",
  });

  factory Country.fromJson(Map<dynamic, dynamic> json) {
    return Country(
        country_id: json['country_id'] ?? 0,
        country_name: json['country_name'] ?? "");
  }
}

class GeoRegion {
  int geo_id;
  String geo_name;

  GeoRegion({
    this.geo_id = 0,
    this.geo_name = "",
  });

  factory GeoRegion.fromJson(Map<dynamic, dynamic> json) {
    return GeoRegion(
        geo_id: json['geo_id'] ?? 0, geo_name: json['geo_name'] ?? "");
  }
}

class Sector {
  int sector_id;
  String sector_name;

  Sector({
    this.sector_id = 0,
    this.sector_name = "",
  });

  factory Sector.fromJson(Map<dynamic, dynamic> json) {
    return Sector(
        sector_id: json['sector_id'] ?? 0,
        sector_name: json['sector_name'] ?? "");
  }
}

class City {
  int city_id;
  String city_name;

  City({
    this.city_id = 0,
    this.city_name = "",
  });

  factory City.fromJson(Map<dynamic, dynamic> json) {
    return City(
        city_id: json['city_id'] ?? "", city_name: json['city_name'] ?? "");
  }
}

class FeedBack {
  String subject;
  String description;
  String donorcode;
  int feedBackType;

  FeedBack(
      {this.subject = "",
      this.description = "",
      this.donorcode = "",
      this.feedBackType = 1});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'subject': subject.toString(),
      'description': description.toString(),
      'donorcode': donorcode.toString(),
      'feedBackType': feedBackType,
    };
    return map;
  }
}
