import 'package:hydrobud/core/error/exceptions.dart';
import 'package:hydrobud/core/error/failures.dart';
import 'package:hydrobud/features/auth/data/datasources/auth_supabase_source.dart';
import 'package:hydrobud/core/common/entities/user.dart';
import 'package:hydrobud/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepositoryImplementation implements AuthRepository {
  final AuthSupabaseSource authSupabaseSource;
  const AuthRepositoryImplementation(this.authSupabaseSource);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await authSupabaseSource.getCurrentUserData();

      if (user == null) {
        return left(Failure('User not signed in!'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authSupabaseSource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authSupabaseSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();

      return right(user);
    } on supabase.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
