import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrobud/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:hydrobud/features/auth/data/datasources/auth_supabase_source.dart';
import 'package:hydrobud/features/auth/domain/repository/auth_repository.dart';
import 'package:hydrobud/features/auth/domain/usecases/current_user.dart';
import 'package:hydrobud/features/auth/domain/usecases/user_sign_in.dart';
import 'package:hydrobud/features/auth/domain/usecases/user_sign_up.dart';
import 'package:hydrobud/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hydrobud/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  // Core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // Datasource
  serviceLocator
    ..registerFactory<AuthSupabaseSource>(
      () => AuthSupabaseSourceImplementation(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImplementation(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
