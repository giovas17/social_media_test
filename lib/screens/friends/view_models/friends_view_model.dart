import 'package:social_media_test/domain/utils/results_utils.dart';
import 'package:social_media_test/screens/friends/repositories/friend_repository.dart';

import '../../../domain/models/friend.dart';

class FriendsViewModel {
  List<Friend> _friends = List.empty(growable: true);
  late FriendsRepository repository;

  FriendsViewModel({required this.repository});

  List<Friend> get friends => _friends;

  setFriends(List<Friend> newList) {
    _friends = newList;
  }

  Future<List<Friend>> getListFriends(int idProfile) async {
    final response = await repository.fetchFriends(idProfile);
    if (response is Success) {
      setFriends(response.response as List<Friend>);
    }
    return friends;
  }
}