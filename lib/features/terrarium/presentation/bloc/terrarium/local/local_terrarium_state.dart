import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

abstract class LocalTerrariumsState extends Equatable {
  final List<TerrariumEntity>? terrariums;
  final DioException? error;

  const LocalTerrariumsState({this.terrariums, this.error});

  @override
  List<Object?> get props => [terrariums, error];
}

class LocalTerrariumsLoading extends LocalTerrariumsState {
  const LocalTerrariumsLoading();
}

class LocalTerrariumsDone extends LocalTerrariumsState {
  const LocalTerrariumsDone(List<TerrariumEntity> terrariums)
      : super(terrariums: terrariums);
}
