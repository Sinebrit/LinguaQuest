import 'package:LinguaQuest/pages/posts/EditPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../components/Post.dart';
import '../../core/data/cubit/posts_public_cubit.dart';
import '../../core/data/cubit/posts_user_cubit.dart';

class ProfilePosts extends StatefulWidget {
  const ProfilePosts({super.key});

  @override
  State<ProfilePosts> createState() => _ProfilePostsState();
}

bool _showFab = true;

// NotificationListener<UserScrollNotification>(
//                         onNotification: (notification) {
//                           final ScrollDirection direction =
//                               notification.direction;
//                           setState(() {
//                             if (direction == ScrollDirection.reverse) {
//                               _showFab = false;
//                             } else if (direction == ScrollDirection.forward) {
//                               _showFab = true;
//                             }
//                           });
//                           return true;
//                         },
class _ProfilePostsState extends State<ProfilePosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: context.read<PostsUserCubit>().getPostsUser(),
              builder: (context, snapshot) {
                return BlocBuilder<PostsUserCubit, PostsUserState>(
                    builder: (context, state) {
                  if (state is PostUserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostUserLoaded) {
                    if (state.posts.isEmpty) {
                      return const Center(
                          child: Text(
                        "There are no publications, you can publish your entry.",
                        textAlign: TextAlign.center,
                      ));
                    }
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        final post = state.posts[index];
                        return Column(
                          children: [
                            Post(
                                isPostPublic: false,
                                description: post.description,
                                userAvatar: "",
                                user: "Max",
                                like: false,
                                status: post.publicationStatusId!),
                            SizedBox(
                              height: index == state.posts.length - 1 ? 60 : 0,
                            )
                          ],
                        );
                      },
                    );
                  } else if (state is PostUserError) {
                    return Text(state.message);
                  } else {
                    return const SizedBox();
                  }
                });
              }),
          Positioned(
              right: 15,
              bottom: 80,
              child: AnimatedSlide(
                duration: Duration(milliseconds: 350),
                offset: _showFab ? Offset.zero : Offset(0, 2),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 350),
                  opacity: _showFab ? 1 : 0,
                  child: FloatingActionButton.extended(
                      onPressed: () {
                        Get.to(EditorPost());
                      },
                      label: Text("Добавить пост")),
                ),
              ))
        ],
      ),
      // floatingActionButton:
    );
  }
}
