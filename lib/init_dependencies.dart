import 'package:blogster/core/common/cubits/app_users/app_user_cubit.dart';
import 'package:blogster/core/secrets/app_secrets.dart';
import 'package:blogster/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:blogster/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:blogster/features/auth/domain/repos/auth_repo.dart';
import 'package:blogster/features/auth/domain/useCases/current_user.dart';
import 'package:blogster/features/auth/domain/useCases/user_login.dart';
import 'package:blogster/features/auth/domain/useCases/user_sign_up.dart';
import 'package:blogster/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogster/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blogster/features/blog/data/repos/bog_repo_impl.dart';
import 'package:blogster/features/blog/domain/repos/blog_repo.dart';
import 'package:blogster/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blogster/features/blog/domain/usecases/upload_blog.dart';
import 'package:blogster/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit());
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
    ..registerFactory(() => CurrentUser(
          serviceLocator(),
        ))

    // bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )

    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
