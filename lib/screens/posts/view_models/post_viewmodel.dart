import 'package:social_media_test/domain/models/post_result.dart';
import 'package:social_media_test/screens/posts/repositories/post_repository.dart';

import '../../../domain/utils/results_utils.dart';

class PostViewModel {
  late PostResult postResult;
  late PostRepository repository;

  PostViewModel({required this.repository});

  List<Posts> get posts => postResult.posts ?? [];

  setPostResult(PostResult newResult) {
    postResult = newResult;
  }

  Future<List<Posts>> getPosts(int idProfile) async {
    final response = await repository.fetchPosts(idProfile);
    if (response is Success) {
      setPostResult(response.response as PostResult);
    }
    return posts;
  }
}