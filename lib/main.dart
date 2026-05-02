import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syria_car_care2/core/widgets/navigatiopn_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syria_car_care2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:syria_car_care2/features/onboarding/presentation/pages/splash_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/bloc/services_bloc.dart';
import 'package:syria_car_care2/features/account/presentation/bloc/account_bloc.dart';
import 'package:syria_car_care2/core/constants/supabase_constants.dart';
import 'injection_container.dart' as di;

import 'package:syria_car_care2/features/services/presentation/bloc/bookings_bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseAnonKey,
  );

  await di.init();

  runApp(

    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<VehiclesBloc>()),
        BlocProvider(create: (context) => di.sl<ServicesBloc>()),
        BlocProvider(create: (context) => di.sl<AccountBloc>()),
        BlocProvider(create: (context) => di.sl<BookingsBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Syria Car Care',
        theme: ThemeData(
          primaryColor: const Color(0xFF102A43),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF102A43)),
          useMaterial3: true,
        ),

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const SplashScreen(),
      ),
    );
  }
}
