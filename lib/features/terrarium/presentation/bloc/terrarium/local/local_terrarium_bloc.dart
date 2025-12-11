import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/features/terrarium/domain/usecases/get_saved_terrariums.dart';
import 'package:growingapp/features/terrarium/domain/usecases/remove_terrarium.dart';
import 'package:growingapp/features/terrarium/domain/usecases/save_terrarium.dart';
import 'package:growingapp/features/terrarium/domain/usecases/update_terrarium.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_event.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_state.dart';

class LocalTerrariumsBloc
    extends Bloc<LocalTerrariumsEvent, LocalTerrariumsState> {
  final GetSavedTerrariumsUseCase _getSavedTerrariumsUseCase;
  final SaveTerrariumUseCase _saveTerrariumUseCase;
  final RemoveTerrariumUseCase _removeTerrariumUseCase;
  final UpdateTerrariumUseCase _updateTerrariumUseCase;

  LocalTerrariumsBloc(this._getSavedTerrariumsUseCase,
      this._saveTerrariumUseCase, this._removeTerrariumUseCase,
      this._updateTerrariumUseCase)
      : super(const LocalTerrariumsLoading()) {
    on<GetSavedTerrariums>(onGetSavedTerrariums);
    on<SaveTerrarium>(onSaveTerrarium);
    on<RemoveTerrarium>(onRemoveTerrarium);
    on<UpdateTerrarium>(onUpdateTerrarium);
  }

  Future<void> onGetSavedTerrariums(GetSavedTerrariums getSavedTerrariums,
      Emitter<LocalTerrariumsState> emit) async {
    final terrariums = await _getSavedTerrariumsUseCase();
    emit(LocalTerrariumsDone(terrariums));
  }

  Future<void> onRemoveTerrarium(RemoveTerrarium removeTerrarium,
      Emitter<LocalTerrariumsState> emit) async {
    await _removeTerrariumUseCase(params: removeTerrarium.terrarium);
    final terrariums = await _getSavedTerrariumsUseCase();
    emit(LocalTerrariumsDone(terrariums));
  }

  Future<void> onSaveTerrarium(
      SaveTerrarium saveTerrarium, Emitter<LocalTerrariumsState> emit) async {
    await _saveTerrariumUseCase(params: saveTerrarium.terrarium);
    final terrariums = await _getSavedTerrariumsUseCase();
    emit(LocalTerrariumsDone(terrariums));
  }

  Future<void> onUpdateTerrarium(
      UpdateTerrarium updateTerrarium, Emitter<LocalTerrariumsState> emit) async {
    await _updateTerrariumUseCase(params: updateTerrarium.terrarium);
    final terrariums = await _getSavedTerrariumsUseCase();
    emit(LocalTerrariumsDone(terrariums));
  }
}
