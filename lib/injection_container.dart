import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/sign_in_with_email_password.dart';
import 'features/auth/domain/usecases/sign_up_with_email_password.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

import 'features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'features/services/presentation/bloc/services_bloc.dart';
import 'features/account/presentation/bloc/account_bloc.dart';

import 'features/vehicles/data/datasources/vehicles_remote_data_source.dart';
import 'features/vehicles/data/repositories/vehicles_repository_impl.dart';
import 'features/vehicles/domain/repositories/vehicles_repository.dart';
import 'features/vehicles/domain/usecases/get_vehicles.dart';
import 'features/services/data/datasources/services_remote_data_source.dart';
import 'features/services/data/repositories/services_repository_impl.dart';
import 'features/services/domain/repositories/services_repository.dart';
import 'features/services/domain/usecases/load_services.dart';

import 'features/vehicles/domain/usecases/add_vehicle.dart';
import 'features/vehicles/domain/usecases/delete_vehicle.dart';
import 'features/vehicles/domain/usecases/update_vehicle.dart';
import 'features/vehicles/domain/usecases/upload_vehicle_image.dart';

import 'features/services/data/datasources/bookings_remote_data_source.dart';
import 'features/services/data/repositories/bookings_repository_impl.dart';
import 'features/services/domain/repositories/bookings_repository.dart';
import 'features/services/domain/usecases/create_booking.dart';
import 'features/services/domain/usecases/get_my_bookings.dart';
import 'features/services/presentation/bloc/bookings_bloc.dart';

import 'features/account/domain/usecases/get_account_info.dart';
import 'features/account/domain/usecases/get_transactions.dart';
import 'features/account/domain/usecases/recharge_wallet.dart';
import 'features/account/domain/usecases/upgrade_plan.dart';
import 'features/account/domain/repositories/account_repository.dart';
import 'features/account/data/repositories/account_repository_impl.dart';
import 'features/account/data/datasources/account_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton(() => Supabase.instance.client);

  sl.registerFactory(() => AuthBloc(
        signUpWithEmailPassword: sl(),
        signInWithEmailPassword: sl(),
      ));
  sl.registerFactory(() => VehiclesBloc(
        getVehicles: sl(),
        addVehicle: sl(),
        deleteVehicle: sl(),
        updateVehicle: sl(),
        uploadVehicleImage: sl(),
      ));
  sl.registerFactory(() => ServicesBloc(loadServices: sl()));
  sl.registerFactory(() => AccountBloc(
        getAccountInfo: sl(),
        getTransactions: sl(),
        rechargeWallet: sl(),
        upgradePlan: sl(),
      ));
  sl.registerFactory(() => BookingsBloc(
        createBooking: sl(),
        getMyBookings: sl(),
      ));

  sl.registerLazySingleton(() => SignUpWithEmailPassword(sl()));
  sl.registerLazySingleton(() => SignInWithEmailPassword(sl()));
  sl.registerLazySingleton(() => GetVehicles(sl()));
  sl.registerLazySingleton(() => AddVehicle(sl()));
  sl.registerLazySingleton(() => DeleteVehicle(sl()));
  sl.registerLazySingleton(() => UpdateVehicle(sl()));
  sl.registerLazySingleton(() => UploadVehicleImage(sl()));
  sl.registerLazySingleton(() => LoadServices(sl()));
  sl.registerLazySingleton(() => CreateBooking(sl()));
  sl.registerLazySingleton(() => GetMyBookings(sl()));
  sl.registerLazySingleton(() => GetAccountInfo(sl()));
  sl.registerLazySingleton(() => GetTransactions(sl()));
  sl.registerLazySingleton(() => RechargeWallet(sl()));
  sl.registerLazySingleton(() => UpgradePlan(sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<VehiclesRepository>(
    () => VehiclesRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ServicesRepository>(
    () => ServicesRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<BookingsRepository>(
    () => BookingsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<VehiclesRemoteDataSource>(
    () => VehiclesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ServicesRemoteDataSource>(
    () => ServicesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<BookingsRemoteDataSource>(
    () => BookingsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AccountRemoteDataSource>(
    () => AccountRemoteDataSourceImpl(sl()),
  );
}
