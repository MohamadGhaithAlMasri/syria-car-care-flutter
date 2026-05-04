import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/usecases/get_vehicles.dart';
import '../../domain/usecases/add_vehicle.dart';
import '../../domain/usecases/delete_vehicle.dart';
import '../../domain/usecases/update_vehicle.dart';
import '../../domain/usecases/upload_vehicle_image.dart';
import '../../../../core/usecases/usecase.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> {
  final GetVehicles getVehicles;
  final AddVehicle addVehicle;
  final DeleteVehicle deleteVehicle;
  final UpdateVehicle updateVehicle;
  final UploadVehicleImage uploadVehicleImage;

  VehiclesBloc({
    required this.getVehicles,
    required this.addVehicle,
    required this.deleteVehicle,
    required this.updateVehicle,
    required this.uploadVehicleImage,
  }) : super(VehiclesInitial()) {
    on<LoadVehiclesEvent>((event, emit) async {
      emit(VehiclesLoading());
      final result = await getVehicles(NoParams());
      result.fold(
        (failure) => emit(VehiclesError(failure.message)),
        (vehicles) => emit(VehiclesLoaded(vehicles)),
      );
    });

    on<AddVehicleEvent>((event, emit) async {
      emit(VehiclesLoading());
      final result = await addVehicle(event.vehicle);
      result.fold(
        (failure) => emit(VehiclesError(failure.message)),
        (success) => add(LoadVehiclesEvent()),
      );
    });

    on<DeleteVehicleEvent>((event, emit) async {
      emit(VehiclesLoading());
      final result = await deleteVehicle(event.vehicleId);
      result.fold(
        (failure) => emit(VehiclesError(failure.message)),
        (success) => add(LoadVehiclesEvent()),
      );
    });

    on<UpdateVehicleEvent>((event, emit) async {
      emit(VehiclesLoading());
      final result = await updateVehicle(event.vehicle);
      result.fold(
        (failure) => emit(VehiclesError(failure.message)),
        (success) => add(LoadVehiclesEvent()),
      );
    });

    on<UploadVehicleImageEvent>((event, emit) async {
      emit(VehiclesLoading());
      final result = await uploadVehicleImage(event.file, event.fileName);
      result.fold(
        (failure) => emit(VehiclesError(failure.message)),
        (imageUrl) => emit(VehicleImageUploaded(imageUrl)),
      );
    });
  }
}
