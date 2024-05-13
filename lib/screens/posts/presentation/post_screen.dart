import 'package:flutter/material.dart';
import 'package:social_media_test/domain/models/post_result.dart';
import 'package:social_media_test/screens/posts/repositories/post_repository.dart';
import 'package:social_media_test/screens/posts/view_models/post_viewmodel.dart';
import '../../../widgets/utils/image_utils.dart';
import '../../../widgets/utils/loading_utils.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late int idProfile;
  PostViewModel viewModel = PostViewModel(repository: PostRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    idProfile = arguments?['idProfile'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: viewModel.getPosts(idProfile),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Center(child: Text('There are no posts'));
              }
              return ListView.builder(
                itemBuilder: postsBuilder,
                itemCount: snapshot.data?.length ?? 0,
              );
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('There is an error loading post'));
            }
            return progressIndicator('Loading...');
          }),
    );
  }

  Widget postsBuilder(BuildContext context, int index) {
    final size = MediaQuery.of(context).size;
    Posts post = viewModel.posts[index];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/post_detail', arguments: {'post': post});
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        elevation: 6.0,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: RoundedImage(
                  image: post.urlToImage ?? "", width: size.width * 0.7),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Text(post.title ?? ""),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: Text(post.description ?? ""),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: measuredLikes(
                  post.likes ?? 0, post.shares ?? 0, post.user ?? User()),
            )
          ],
        ),
      ),
    );
  }

  Widget measuredLikes(int numLikes, int numShares, User user) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Row(
          children: [
            RoundedImage(image: user.image ?? '', width: size.width * 0.06),
            const SizedBox(width: 5.0),
            Text(user.name ?? '')
          ],
        ),
        const SizedBox(width: 10.0),
        Row(
          children: [
            const Icon(Icons.favorite_border, size: 18.0),
            const SizedBox(width: 5.0),
            Text('Likes: $numLikes')
          ],
        ),
        const SizedBox(width: 10.0),
        Row(
          children: [
            const Icon(Icons.share, size: 18.0),
            const SizedBox(width: 5.0),
            Text('Shares: $numShares')
          ],
        )
      ],
    );
  }
}
