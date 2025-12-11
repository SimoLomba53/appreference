import 'dart:io';

import 'package:dio/dio.dart';
import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/features/terrarium/data/data_sources/local/app_database.dart';
import 'package:growingapp/features/terrarium/data/data_sources/terrarium_api_service.dart';
import 'package:growingapp/features/terrarium/data/models/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';
import 'package:growingapp/features/terrarium/domain/repository/terrariums_repository.dart';

class TerrariumRepositoryImpl implements TerrariumRepository {
  final TerrariumApiService _terrariumApiService;
  final AppDatabase _appDatabase;

  TerrariumRepositoryImpl(this._terrariumApiService, this._appDatabase);

  @override
  Future<DataState<List<TerrariumModel>>> getTerrariums({String? searchText}) async {
    try {
      final httpResponse = await _terrariumApiService.getTerrariums(searchText: searchText);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      return DataFailed(
        DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<TerrariumEntity>> getSavedTerrariums() async {
    return _appDatabase.terrariumDAO.getTerrariums();
  }

  @override
  Future<void> removeTerrarium(TerrariumEntity terrarium) {
    return _appDatabase.terrariumDAO.deleteTerrarium(TerrariumModel.fromEntity(terrarium));
  }

  @override
  Future<void> saveTerrarium(TerrariumEntity terrarium) {
    return _appDatabase.terrariumDAO.insertTerrarium(TerrariumModel.fromEntity(terrarium));
  }

  @override
  Future<void> updateTerrarium(TerrariumEntity terrarium) {
    return _appDatabase.terrariumDAO
        .updateTerrarium(TerrariumModel.fromEntity(terrarium));
  }
}
