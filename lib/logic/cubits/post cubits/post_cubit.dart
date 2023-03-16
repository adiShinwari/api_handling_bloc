import 'package:api_handling_bloc/data/models/post_model.dart';
import 'package:api_handling_bloc/data/repositories/post_repository.dart';
import 'package:api_handling_bloc/logic/cubits/post%20cubits/post_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()) {
    fetchPost();
  }

  PostRepository postRepository = PostRepository();

  void fetchPost() async {
    emit(PostLoadingState());
    try {
      List<PostModel> posts = await postRepository.fetchPost();
      emit(PostLoadedState(posts: posts));
    } on DioError catch (ex) {
      emit(
        PostErrorState(
          error: ex.type.toString(),
        ),
      );
    }
  }
}
