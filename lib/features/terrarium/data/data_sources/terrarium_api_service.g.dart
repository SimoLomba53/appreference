// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terrarium_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _TerrariumApiService implements TerrariumApiService {
  _TerrariumApiService(
    this._dio) {
    baseUrl ??= 'https://server.it/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<List<TerrariumModel>>> getTerrariums(
      {String? searchText}) async {
    //var result = terrariumsJSONMock;
    //var value = result
    //    .map((dynamic i) => TerrariumModel.fromJson(i as Map<String, dynamic>))
    //    .toList();
    CollectionReference terrariums =
        FirebaseFirestore.instance.collection('terrariums');
    QuerySnapshot querySnapshot = await terrariums.get();
    var value = querySnapshot.docs
        .map((doc) =>
            TerrariumModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    if (searchText != null && searchText.isNotEmpty) {
      value = value
          .where(
            (element) =>
                searchText.split(' ').any((word) => element.concept!
                    .toLowerCase()
                    .contains(word.toLowerCase())) ||
                searchText.split(' ').any((word) => element.description!
                    .toLowerCase()
                    .contains(word.toLowerCase())),
          )
          .toList();
    }
    final httpResponse = HttpResponse(
      value,
      Response(
        data: value,
        requestOptions: RequestOptions(),
        statusCode: HttpStatus.ok,
      ),
    );
    return httpResponse;

    //const _extra = <String, dynamic>{};
    //final queryParameters = <String, dynamic>{r'apiKey': apiKey};
    //queryParameters.removeWhere((k, v) => v == null);
    //final _headers = <String, dynamic>{};
    //final Map<String, dynamic>? _data = null;
    //final _result = await _dio.fetch<List<dynamic>>(
    //    _setStreamType<HttpResponse<List<TerrariumModel>>>(Options(
    //  method: 'GET',
    //  headers: _headers,
    //  extra: _extra,
    //)
    //        .compose(
    //          _dio.options,
    //          '/terrariums',
    //          queryParameters: queryParameters,
    //          data: _data,
    //        )
    //        .copyWith(
    //            baseUrl: _combineBaseUrls(
    //          _dio.options.baseUrl,
    //          baseUrl,
    //        ))));
    //var value = _result.data!
    //    .map((dynamic i) => TerrariumModel.fromJson(i as Map<String, dynamic>))
    //    .toList();
    //final httpResponse = HttpResponse(value, _result);
    //return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
