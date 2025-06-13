import 'package:equatable/equatable.dart';

class SearchModel extends Equatable {
  final int? id;
  final String? name;
  final String? region;
  final String? country;
  final double? lat;
  final double? lon;
  final String? url;

  const SearchModel({
    this.id,
    this.name,
    this.region,
    this.country,
    this.lat,
    this.lon,
    this.url,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    region: json['region'] as String?,
    country: json['country'] as String?,
    lat: (json['lat'] as num?)?.toDouble(),
    lon: (json['lon'] as num?)?.toDouble(),
    url: json['url'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'region': region,
    'country': country,
    'lat': lat,
    'lon': lon,
    'url': url,
  };

  @override
  List<Object?> get props => [id, name, region, country, lat, lon, url];
}
