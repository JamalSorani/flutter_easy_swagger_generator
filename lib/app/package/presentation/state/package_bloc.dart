import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/result_builder/result.dart';
import '../../application/package_facade.dart';
import '../../infrastructure/models/package_get_all_model.dart';
import '../../infrastructure/models/package_get_by_id_model.dart';
import '../../domain/entities/package_get_all_param.dart';
import '../../domain/entities/package_get_by_id_param.dart';
part 'package_event.dart';
part 'package_state.dart';

class PackageBloc extends Bloc<PackageEvent, PackageState> {
  final PackageFacade _facade;
  PackageBloc({required PackageFacade facade})
      : _facade = facade,
        super(PackageState()) {
    on<PackageGetAllEvent>(_packageGetAll);
    on<PackageGetByIdEvent>(_packageGetById);
  }

  _packageGetAll(PackageGetAllEvent event, Emitter emit) async{
    emit(state.copyWith(packageGetAllState: const Result.loading()));
    final response = await _facade.packageGetAll(
        packageGetAllParam: event.packageGetAllParam);
    response.fold(
      (l) => emit(state.copyWith(packageGetAllState: Result.error(error: l))),
      (r) => emit(state.copyWith(packageGetAllState: Result.loaded(data: r))),
    );
  }

  _packageGetById(PackageGetByIdEvent event, Emitter emit) async{
    emit(state.copyWith(packageGetByIdState: const Result.loading()));
    final response = await _facade.packageGetById(
        packageGetByIdParam: event.packageGetByIdParam);
    response.fold(
      (l) => emit(state.copyWith(packageGetByIdState: Result.error(error: l))),
      (r) => emit(state.copyWith(packageGetByIdState: Result.loaded(data: r))),
    );
  }
}
