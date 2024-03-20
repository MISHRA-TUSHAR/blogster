import 'package:blogster/core/secrets/app_secrets.dart';
import 'package:blogster/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:blogster/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:blogster/features/auth/domain/repos/auth_repo.dart';
import 'package:blogster/features/auth/domain/useCases/user_login.dart';
import 'package:blogster/features/auth/domain/useCases/user_sign_up.dart';
import 'package:blogster/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // data sources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthSupabaseDataSourceImpl(
        serviceLocator(),
      ),
    )
    // repos
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    // use cases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )

    // use cases
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )

    // bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ),
    );
}
