import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syria_car_care2/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:syria_car_care2/features/onboarding/presentation/pages/splash_page.dart';
import 'package:syria_car_care2/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:syria_car_care2/features/services/presentation/bloc/services_bloc.dart';
import 'package:syria_car_care2/features/account/presentation/bloc/account_bloc.dart';
import 'package:syria_car_care2/core/constants/supabase_constants.dart';
import 'injection_container.dart' as di;

import 'package:syria_car_care2/features/services/presentation/bloc/bookings_bloc.dart';
import 'package:syria_car_care2/core/theme/theme_bloc.dart';
import 'package:syria_car_care2/core/theme/app_theme.dart';
import 'package:syria_car_care2/core/services/notification_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseAnonKey,
  );

  await di.init();
  await di.sl<NotificationService>().init();
  await di.sl<NotificationService>().requestPermissions();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://9c0cfd97b4e0e0f1aa311edbe42ddf95@o4511353464815616.ingest.de.sentry.io/4511353466519632';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      SentryWidget(
        child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('ar'),
          startLocale: const Locale('ar'),
          child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return const MyApp();
            },
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()..add(LoadThemeEvent())),
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<VehiclesBloc>()),
        BlocProvider(create: (context) => di.sl<ServicesBloc>()),
        BlocProvider(create: (context) => di.sl<AccountBloc>()),
        BlocProvider(create: (context) => di.sl<BookingsBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Syria Car Care',
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
