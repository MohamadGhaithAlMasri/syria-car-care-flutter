import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword(
    String email,
    String password,
    String name,
    String phoneNumber,
  );
  Future<UserModel> signInWithEmailPassword(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final supabase.SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailPassword(
    String email,
    String password,
    String name,
    String phoneNumber,
  ) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name, 'phone_number': phoneNumber},
      );

      if (response.user != null) {
        if (response.session == null) {
          throw Exception(
            'الرجاء التحقق من بريدك الإلكتروني لتفعيل الحساب (تأكيد الإيميل مطلوب في Supabase)',
          );
        }
        return UserModel(email: response.user!.email ?? email);
      } else {
        throw Exception('فشل إنشاء الحساب');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return UserModel(email: response.user!.email ?? email);
      } else {
        throw Exception('فشل تسجيل الدخول');
      }
    } catch (e) {
      rethrow;
    }
  }
}
