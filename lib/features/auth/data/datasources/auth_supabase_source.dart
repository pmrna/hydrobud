import 'package:hydrobud/core/error/exceptions.dart';
import 'package:hydrobud/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthSupabaseSourceImplementation implements AuthSupabaseSource {
  final SupabaseClient supabaseClient;
  AuthSupabaseSourceImplementation(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw const ServerException('User is null!');
      }
      return UserModel.fromJson(
        response.user!.toJson(),
      ).copyWith();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserModel.fromJson(userData.first).copyWith();
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // TO DO: add sign in anonymously
}
