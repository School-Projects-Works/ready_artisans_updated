// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserLocation {
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? street;
  final String? city;
  final String? region;
  final String? country;
  final String? countryCode;
  final String? district;
  UserLocation({
    this.latitude,
    this.longitude,
    this.name,
    this.street,
    this.city,
    this.region,
    this.country,
    this.countryCode,
    this.district,
  });

  UserLocation copyWith({
    double? latitude,
    double? longitude,
    String? name,
    String? street,
    String? city,
    String? region,
    String? country,
    String? countryCode,
    String? district,
  }) {
    return UserLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      street: street ?? this.street,
      city: city ?? this.city,
      region: region ?? this.region,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      district: district ?? this.district,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'street': street,
      'city': city,
      'region': region,
      'country': country,
      'countryCode': countryCode,
      'district': district,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      name: map['name'] != null ? map['name'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      countryCode:
          map['countryCode'] != null ? map['countryCode'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLocation.fromJson(String source) =>
      UserLocation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserLocation(latitude: $latitude, longitude: $longitude, name: $name, street: $street, city: $city, region: $region, country: $country, countryCode: $countryCode, district: $district)';
  }

  @override
  bool operator ==(covariant UserLocation other) {
    if (identical(this, other)) return true;

    return other.latitude == latitude &&
        other.longitude == longitude &&
        other.name == name &&
        other.street == street &&
        other.city == city &&
        other.region == region &&
        other.country == country &&
        other.countryCode == countryCode &&
        other.district == district;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        name.hashCode ^
        street.hashCode ^
        city.hashCode ^
        region.hashCode ^
        country.hashCode ^
        countryCode.hashCode ^
        district.hashCode;
  }
}
