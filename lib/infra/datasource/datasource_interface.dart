import 'package:star_wars_app/core/enums.dart';

abstract class IDatasource {
  Map<String, dynamic> call(Endpoint endpoint);
}
