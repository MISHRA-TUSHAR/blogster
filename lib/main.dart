import 'package:blogster/core/secrets/app_secrets.dart';
import 'package:blogster/core/theme/theme.dart';
import 'package:blogster/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:blogster/features/auth/data/repos/auth_repo_implementation.dart';
import 'package:blogster/features/auth/domain/useCases/user_sign_up.dart';
import 'package:blogster/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogster/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            userSignUp: UserSignUp(
              AuthRepositoryImpl(
                AuthSupabaseDataSourceImpl(
                  supabase.client,
                ),
              ),
            ),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blogster',
      theme: AppTheme.darkThemeMode,
      home: const Login(),
    );
  }
}
