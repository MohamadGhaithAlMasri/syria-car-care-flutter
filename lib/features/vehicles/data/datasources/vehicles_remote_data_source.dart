import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/vehicle_model.dart';

abstract class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> getVehicles();
  Future<VehicleModel> addVehicle(VehicleModel vehicle);
  Future<void> deleteVehicle(String vehicleId);
  Future<VehicleModel> updateVehicle(VehicleModel vehicle);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final SupabaseClient supabaseClient;

  VehiclesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<VehicleModel>> getVehicles() async {
    try {
      final response = await supabaseClient
          .from('vehicles')
          .select()
          .eq('user_id', supabaseClient.auth.currentUser!.id);

      return (response as List)
          .map((json) => VehicleModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VehicleModel> addVehicle(VehicleModel vehicle) async {
    try {
      final data = vehicle.toJson();
      if (data['id'] == '' || data['id'] == null) {
        data.remove('id');
      }
      data['user_id'] = supabaseClient.auth.currentUser!.id;

      final response = await supabaseClient
          .from('vehicles')
          .insert(data)
          .select()
          .single();

      return VehicleModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteVehicle(String vehicleId) async {
    try {
      await supabaseClient
          .from('vehicles')
          .delete()
          .eq('id', vehicleId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<VehicleModel> updateVehicle(VehicleModel vehicle) async {
    try {
      final response = await supabaseClient
          .from('vehicles')
          .update(vehicle.toJson())
          .eq('id', vehicle.id)
          .select()
          .single();
      return VehicleModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
