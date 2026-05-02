import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/service.dart';
import '../../domain/usecases/load_services.dart';
import '../../../../core/usecases/usecase.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final LoadServices loadServices;

  ServicesBloc({required this.loadServices}) : super(ServicesInitial()) {
    on<LoadServicesEvent>((event, emit) async {
      emit(ServicesLoading());
      final result = await loadServices(NoParams());
      result.fold(
        (failure) => emit(ServicesError(failure.message)),
        (services) => emit(ServicesLoaded(services)),
      );
    });
  }
}
