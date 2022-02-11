import 'dart:io';

import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';

import '../films_response.dart';
import '../people_response.dart';

class ApiDatasourceTestStub implements IApiDatasource {
  @override
  Future<Map> call(Endpoint endpoint) async {
    return (endpoint == Endpoint.films) ? filmResponse : peopleResponse;
  }
}

class ApiDatasourceTestSocketExceptionStub implements IApiDatasource {
  @override
  Future<Map> call(Endpoint endpoint) async {
    throw const SocketException('No connection with server');
  }
}

class ApiDatasourceTestHttpExceptionStub implements IApiDatasource {
  @override
  Future<Map> call(Endpoint endpoint) async {
    throw const HttpException('Could not find resource');
  }
}

class ApiDatasourceTestFormatExceptionStub implements IApiDatasource {
  @override
  Future<Map> call(Endpoint endpoint) async {
    throw const FormatException('Could not find resource');
  }
}

class ApiDatasourceTestOtherExceptionStub implements IApiDatasource {
  @override
  Future<Map> call(Endpoint endpoint) async {
    throw Exception('Other exception');
  }
}
