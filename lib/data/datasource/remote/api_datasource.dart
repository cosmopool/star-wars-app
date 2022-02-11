import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/utils.dart';
import 'package:star_wars_app/infra/datasources/api_datasource_interface.dart';

class ApiDatasource implements IApiDatasource {
  @override
  Future<Map> call(Endpoint endpoint) async {
    print('======================================= endpoint3: $endpoint');
    final endpointToString = convertEndpoint(endpoint);
    final url = Uri.https(endpointToString, '');
    print('======================================= url: $url');
    final response = await http.get(url);
    print('======================================= response: $response');

    return jsonDecode(response.body);
  }
}
