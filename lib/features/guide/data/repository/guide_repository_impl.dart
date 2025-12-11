import 'dart:io';

import 'package:dio/dio.dart';
import 'package:growingapp/core/resources/data_state.dart';
import 'package:growingapp/features/guide/data/data_sources/guide_api_service.dart';
import 'package:growingapp/features/guide/data/models/guide.dart';
import 'package:growingapp/features/guide/domain/repository/guides_repository.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

class GuideRepositoryImpl implements GuideRepository {
  final GuideApiService _guideApiService;

  GuideRepositoryImpl(this._guideApiService);

  @override
  Future<DataState<List<GuideModel>>> getGuides({
    String? searchText,
    TerrariumEntity? terrarium,
  }) async {
    try {
      final httpResponse = await _guideApiService.getGuides(
        searchText: searchText,
        terrarium: terrarium,
      );

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
}
