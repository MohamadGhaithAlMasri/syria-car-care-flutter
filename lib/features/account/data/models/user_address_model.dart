import '../../domain/entities/user_address.dart';

class UserAddressModel extends UserAddress {
  const UserAddressModel({
    required super.id,
    required super.userId,
    required super.type,
    required super.latitude,
    required super.longitude,
    required super.addressName,
  });

  factory UserAddressModel.fromJson(Map<String, dynamic> json) {
    return UserAddressModel(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      type: json['type'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      addressName: json['address_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'address_name': addressName,
    };
  }
}
