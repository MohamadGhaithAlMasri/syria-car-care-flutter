import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/service_model.dart';

abstract class ServicesRemoteDataSource {
  Future<List<ServiceModel>> getServices();
}

class ServicesRemoteDataSourceImpl implements ServicesRemoteDataSource {
  final SupabaseClient supabaseClient;

  ServicesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final response = await supabaseClient
          .from('services')
          .select()
          .eq('is_active', true);

      return (response as List)
          .map((json) => ServiceModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
