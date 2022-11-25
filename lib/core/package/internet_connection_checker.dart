import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnection{
  static Future<bool> get hasConnection async => await InternetConnectionChecker().hasConnection;
}