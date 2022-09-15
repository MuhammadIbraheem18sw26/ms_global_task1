import 'dart:developer';

import 'package:gs_global_task1/models/post_model.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';
import '../models/user_model.dart';

class ApiService {
  Future<List<UserModel>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<UserModel> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<PostModel>?> getPosts() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.postsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<PostModel> model = postModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
