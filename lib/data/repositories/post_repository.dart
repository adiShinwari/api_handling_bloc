import 'package:api_handling_bloc/data/models/post_model.dart';
import 'package:api_handling_bloc/data/repositories/api/api.dart';
import 'package:dio/dio.dart';

class PostRepository {
  Api api = Api();

  Future<List<PostModel>> fetchPost() async {
    try {
      Response response = await api.sendRequest.get('/posts');
      List<dynamic> postMaps = response.data;
      return postMaps.map((postMap) => PostModel.fromJson(postMap)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
