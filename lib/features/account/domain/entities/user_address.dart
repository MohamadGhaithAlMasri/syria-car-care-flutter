import 'package:equatable/equatable.dart';

class UserAddress extends Equatable {
  final String id;
  final String userId;
  final String type; // 'home', 'work', 'parents'
  final double latitude;
  final double longitude;
  final String addressName;

  const UserAddress({
    required this.id,
    required this.userId,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.addressName,
  });

  @override
  List<Object?> get props => [id, userId, type, latitude, longitude, addressName];
}
