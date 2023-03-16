import 'package:api_handling_bloc/data/models/post_model.dart';
import 'package:api_handling_bloc/logic/cubits/post%20cubits/post_cubit.dart';
import 'package:api_handling_bloc/logic/cubits/post%20cubits/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Api Handling',
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            if (state is PostErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.error,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is PostLoadedState) {
              return buildPostListView(state.posts);
            }
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('An error occured,'),
                  const SizedBox(
                    width: 0,
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<PostCubit>(context).fetchPost();
                    },
                    child: const Text(
                      'try Again',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildPostListView(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        PostModel post = posts[index];
        return ListTile(
          subtitle: Text(post.body.toString()),
          title: Text(
            post.title.toString(),
          ),
        );
      },
    );
  }
}
