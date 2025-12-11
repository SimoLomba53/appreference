import 'dart:io';

import 'package:growingapp/core/constants/constants.dart';
import 'package:growingapp/features/terrarium/data/models/terrarium.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'terrarium_api_service.g.dart';

@RestApi(baseUrl: terrariumsAPIBaseUrl)
abstract class TerrariumApiService {
  factory TerrariumApiService(Dio dio) = _TerrariumApiService;

  @GET('/terrariums')
  Future<HttpResponse<List<TerrariumModel>>> getTerrariums(
      {String? searchText});
}
