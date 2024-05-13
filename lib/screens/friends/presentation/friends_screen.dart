import 'package:flutter/material.dart';
import 'package:social_media_test/domain/models/friend.dart';
import 'package:social_media_test/screens/friends/repositories/friend_repository.dart';
import 'package:social_media_test/screens/friends/view_models/friends_view_model.dart';
import 'package:social_media_test/widgets/utils/image_utils.dart';

import '../../../widgets/utils/loading_utils.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  FriendsViewModel viewModel =
      FriendsViewModel(repository: FriendsRepositoryImpl());
  late int idProfile;

  @override
  Widget build(BuildContext context) {
    Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    idProfile = arguments?['idProfile'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
          future: viewModel.getListFriends(idProfile),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Center(child: Text('There is no friends'));
              }
              return ListView.builder(
                itemBuilder: friendsListBuilder,
                itemCount: snapshot.data?.length ?? 0,
              );
            } else if (snapshot.hasError) {
              return const Center(
                  child: Text('There is an error loading friends'));
            }
            return progressIndicator('Loading...');
          }
      ),
    );
  }

  Widget friendsListBuilder(BuildContext context, int index) {
    Friend friend = viewModel.friends[index];
    final size = MediaQuery.of(context).size;
    return ListTile(
      leading: RoundedImage(
        image: friend.image ?? '',
        width: size.width * 0.1,
      ),
      title: Text(friend.name ?? ''),
      subtitle: Text(friend.username ?? ''),
    );
  }
}
