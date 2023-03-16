import 'package:api_handling_bloc/data/models/post_model.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostModel> posts;
  PostLoadedState({
    required this.posts,
  });
}

class PostErrorState extends PostState {
  final String error;
  PostErrorState({
    required this.error,
  });
}
