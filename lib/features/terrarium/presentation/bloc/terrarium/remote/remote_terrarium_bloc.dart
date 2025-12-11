import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/features/terrarium/domain/usecases/get_terrariums.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/remote/remote_terrarium_event.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/remote/remote_terrarium_state.dart';

class RemoteTerrariumsBloc
    extends Bloc<RemoteTerrariumsEvent, RemoteTerrariumsState> {
  final GetTerrariumsUseCase _getTerrariumsUseCase;

  RemoteTerrariumsBloc(this._getTerrariumsUseCase)
      : super(const RemoteTerrariumsLoading()) {
    on<GetTerrariums>(onGetTerrariums);
  }

  Future<void> onGetTerrariums(
      GetTerrariums event, Emitter<RemoteTerrariumsState> emit) async {
    emit(const RemoteTerrariumsLoading());
    final dataState = await _getTerrariumsUseCase(params: event.searchText);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteTerrariumsDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteTerrariumsError(dataState.error!));
    }
  }
}
