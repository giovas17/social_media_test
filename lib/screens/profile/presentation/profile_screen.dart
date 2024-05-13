import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_test/domain/models/profile.dart';
import 'package:social_media_test/widgets/utils/image_utils.dart';
import 'package:social_media_test/widgets/utils/loading_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import '../repositories/profile_repository.dart';
import '../view_models/profile_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel viewModel =
      ProfileViewModel(repository: ProfileRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Profile?>(
        future: viewModel.fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return const Center(child: Text('There is no profile'));
            }
            return loadProfile();
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('There is an error loading the profile'));
          }
          return progressIndicator('Loading...');
        },
      ),
    );
  }

  Widget loadProfile() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          NetImage(
              imageUrl: viewModel.profile!.imageWall ?? '',
              width: size.width,
              aspectRatio: 16 / 9),
          Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedImage(
                      image: viewModel.profile!.imageProfile ?? '',
                      width: size.width * 0.3),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(viewModel.profile!.name ?? ''),
                      Text(viewModel.profile!.userName ?? ''),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/friends', arguments: {
                            'idProfile': viewModel.profile?.id ?? 0
                          });
                        },
                        child: Text(
                            'Number of friends: ${viewModel.profile!.numberOfFriends ?? 0}'),
                      ),
                    ],
                  )
                ],
              )),
          Text(
            viewModel.profile!.description ?? '',
            maxLines: 3,
          ),
          loadRepoButton(RepoButtons.github, () {
            openWeb(viewModel.profile!.github!, context);
          }),
          loadRepoButton(RepoButtons.gitlab, () {
            openWeb(viewModel.profile!.gitlab!, context);
          }),
          loadRepoButton(RepoButtons.linkedin, () {
            openWeb(viewModel.profile!.linkedin!, context);
          }),
          const SizedBox(height: 15),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/posts', arguments: {
                  'idProfile': viewModel.profile?.id ?? 0
                });
              },
              child: const Row(
                children: [
                  Icon(Icons.list, size: 18),
                  SizedBox(width: 6),
                  Text('List of Posts')
                ],
              ))
        ],
      ),
    );
  }

  openWeb(String url, BuildContext context) async {
    if (url.isNotEmpty) {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        FlutterToastr.show('There is not url for this repo', context,
            duration: FlutterToastr.lengthShort,
            position: FlutterToastr.bottom);
      }
    }
  }

  Widget loadRepoButton(RepoButtons repoButton, Function onClick) {
    late String image;
    late String text;
    final size = MediaQuery.of(context).size;
    switch (repoButton) {
      case RepoButtons.github:
        image = 'images/github_icon.webp';
        text = 'GitHub';
        break;
      case RepoButtons.gitlab:
        image = 'images/gitlab_icon.webp';
        text = 'Gitlab';
        break;
      case RepoButtons.linkedin:
        image = 'images/linkedin_icon.png';
        text = 'LinkedIn';
        break;
    }
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: FilledButton(
          onPressed: () => onClick(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image, width: size.width * 0.1, scale: 1),
              Padding(padding: const EdgeInsets.all(8.0), child: Text(text))
            ],
          ),
        ));
  }
}

enum RepoButtons { github, gitlab, linkedin }
