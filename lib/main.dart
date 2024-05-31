import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrobud/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:hydrobud/core/theme/theme.dart';
import 'package:hydrobud/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hydrobud/features/auth/presentation/pages/sign_in_page.dart';
import 'package:hydrobud/features/graph/presentation/bloc/chart_data_bloc.dart';
import 'package:hydrobud/features/navigation/presentation/pages/wrapper.dart';
import 'package:hydrobud/init_dependencies.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'lib/.env');

  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ChartDataBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserSignedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hydrobud",
      theme: AppTheme.lightThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserSignedIn;
        },
        builder: (context, isSignedIn) {
          if (isSignedIn) {
            return const Wrapper();
          }
          return const SignInPage();
        },
      ),
    );
  }
}
