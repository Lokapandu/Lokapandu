import 'package:lokapandu/domain/entities/tourism_spot_entity.dart';
import 'package:lokapandu/presentation/tourism_spot/models/facility_model.dart'; // Asumsi FacilityModel ada di sini

class Tour {
  final String imageUrl;
  final String name;
  final String location;
  final List<String> galleryImageUrls;
  final String openingHours;
  final String address;
  final String aboutText;
  final String mapImageUrl;
  final List<FacilityModel> facilities;
  final List<String> tags;

  const Tour({
    required this.imageUrl,
    required this.name,
    required this.location,
    this.galleryImageUrls = const [],
    this.openingHours = '',
    this.address = '',
    this.aboutText = '',
    this.mapImageUrl = '',
    this.facilities = const [],
    this.tags = const [],
  });

  factory Tour.fromEntity(TourismSpot entity) {
    final primaryImage = entity.images.isNotEmpty
        ? entity.images.first.imageUrl
        : '';

    final galleryImages = entity.images.map((image) => image.imageUrl).toList();
    final hours = '${entity.openTime} - ${entity.closeTime}';

    final parsedFacilities = FacilityModel.parseFacilities(entity.facilities);

    return Tour(
      name: entity.name,
      location: '${entity.city}, ${entity.province}',
      imageUrl: primaryImage,
      galleryImageUrls: galleryImages,
      openingHours: hours,
      address: entity.address,
      aboutText: entity.description,
      mapImageUrl: entity.mapsLink,
      facilities: parsedFacilities,
      tags: [entity.category],
    );
  }
}
