import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:star_wars_app/core/enums.dart';
import 'package:star_wars_app/core/utils.dart';

class ApiDatasource {
  Future<Map> fetch(Endpoint endpoint) async {
    final endpointToString = parseEndpoint(endpoint);
    final url = Uri.parse(endpointToString);
    final response = await http.get(url);

    return jsonDecode(response.body);
  }
}
