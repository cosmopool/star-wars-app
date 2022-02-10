import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/utils.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';

class ApiDatasource implements IApiDatasource {
  Future<Map> fetch(Endpoint endpoint) async {
    final endpointToString = parseEndpoint(endpoint);
    final url = Uri.parse(endpointToString);
    final response = await http.get(url);

    return jsonDecode(response.body);
  }

  @override
  Future<Map> call(Endpoint endpoint) async {
    final endpointToString = parseEndpoint(endpoint);
    final url = Uri.parse(endpointToString);
    final response = await http.get(url);

    return jsonDecode(response.body);
  }
}
