part of 'vehicles_bloc.dart';

abstract class VehiclesEvent extends Equatable {
  const VehiclesEvent();

  @override
  List<Object> get props => [];
}

class LoadVehiclesEvent extends VehiclesEvent {}

class AddVehicleEvent extends VehiclesEvent {
  final Vehicle vehicle;
  const AddVehicleEvent(this.vehicle);

  @override
  List<Object> get props => [vehicle];
}

class DeleteVehicleEvent extends VehiclesEvent {
  final String vehicleId;
  const DeleteVehicleEvent(this.vehicleId);

  @override
  List<Object> get props => [vehicleId];
}

class UpdateVehicleEvent extends VehiclesEvent {
  final Vehicle vehicle;

  const UpdateVehicleEvent(this.vehicle);

  @override
  List<Object> get props => [vehicle];
}
