part of 'posts_public_cubit.dart';

@immutable
abstract class PostsPublicState {}

final class PostsPublicInitial extends PostsPublicState {}

class PostLoading extends PostsPublicState {}

class PostLoaded extends PostsPublicState {
  final List<PostModel> posts;

  PostLoaded(this.posts);
}

class PostError extends PostsPublicState {
  final String message;

  PostError(this.message);
}
