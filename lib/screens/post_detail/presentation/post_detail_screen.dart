import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:social_media_test/domain/models/post_result.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/utils/image_utils.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    Posts post = arguments?['post'] as Posts;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Post Detail'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          foregroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NetImage(
                imageUrl: post.urlToImage ?? '',
                width: size.width,
                aspectRatio: 9 / 6),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  post.title ?? '',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 4),
              child: Text(
                'From: ${post.user?.name ?? ''}',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                'Published At: ${post.publishedAt ?? ''}',
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                post.description ?? '',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                post.content ?? '',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextButton(
                child: Text(
                  'Open the link for more information -> ${post.url ?? ''}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.normal),
                ),
                onPressed: () async {
                  if (post.url != null) {
                    final Uri url = Uri.parse(post.url!);
                    if (!await launchUrl(url)) {
                      FlutterToastr.show(
                          'Is not possible to open the link', context,
                          duration: FlutterToastr.lengthShort,
                          position: FlutterToastr.bottom);
                    }
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Row(
                    children: [
                      RoundedImage(
                          image: post.user?.image ?? '',
                          width: size.width * 0.06),
                      const SizedBox(width: 5.0),
                      Text(post.user?.name ?? '')
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.favorite_border, size: 18.0),
                      const SizedBox(width: 5.0),
                      Text('Likes: ${post.likes ?? 0}')
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.share, size: 18.0),
                      const SizedBox(width: 5.0),
                      Text('Shares: ${post.shares ?? 0}')
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
