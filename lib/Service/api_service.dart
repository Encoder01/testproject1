import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:testproject/Models/user_model.dart';

class ApiService {
  String apiURl = "https://reqres.in";
  Future<UserModel> getUsers(String query) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    };
    http.Response response =
        await http.get(Uri.parse("$apiURl/api/users?page=$query"), headers: headers);
    UserModel profileModel = userModelFromJson(response.body);
    return profileModel;
  }
}
