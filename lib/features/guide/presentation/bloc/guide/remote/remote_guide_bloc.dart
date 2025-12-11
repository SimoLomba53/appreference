import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/features/guide/domain/usecases/get_guides.dart';
import 'package:growingapp/features/guide/presentation/bloc/guide/remote/remote_guide_event.dart';
import 'package:growingapp/features/guide/presentation/bloc/guide/remote/remote_guide_state.dart';

class RemoteGuidesBloc extends Bloc<RemoteGuidesEvent, RemoteGuidesState> {
  final GetGuidesUseCase _getGuidesUseCase;

  RemoteGuidesBloc(this._getGuidesUseCase)
      : super(const RemoteGuidesLoading()) {
    on<GetGuides>(onGetGuides);
  }

  Future<void> onGetGuides(
      GetGuides event, Emitter<RemoteGuidesState> emit) async {
    emit(const RemoteGuidesLoading());

    final dataState = await _getGuidesUseCase(
        params: GetGuidesUseCaseInputParam(
      searchText: event.searchText,
      terrarium: event.terrarium,
    ));

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemoteGuidesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.error);
      emit(RemoteGuidesError(dataState.error!));
    }
  }
}
