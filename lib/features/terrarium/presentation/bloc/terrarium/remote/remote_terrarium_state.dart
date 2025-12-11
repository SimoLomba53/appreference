import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

abstract class RemoteTerrariumsState extends Equatable {
  final List<TerrariumEntity>? terrariums;
  final DioException? error;

  const RemoteTerrariumsState({this.terrariums, this.error});

  @override
  List<Object?> get props => [terrariums, error];
}

class RemoteTerrariumsLoading extends RemoteTerrariumsState {
  const RemoteTerrariumsLoading();
}

class RemoteTerrariumsDone extends RemoteTerrariumsState {
  const RemoteTerrariumsDone(List<TerrariumEntity> terrariums)
      : super(terrariums: terrariums);
}

class RemoteTerrariumsError extends RemoteTerrariumsState {
  const RemoteTerrariumsError(DioException error) : super(error: error);
}
