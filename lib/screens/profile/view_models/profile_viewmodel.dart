import 'package:social_media_test/domain/models/profile.dart';
import 'package:social_media_test/domain/utils/results_utils.dart';
import '../repositories/profile_repository.dart';

class ProfileViewModel {
  Profile? _profile;
  late ProfileRepository repository;

  ProfileViewModel({required this.repository});

  Profile? get profile => _profile;

  setProfile(Profile newProfile) async {
    _profile = newProfile;
  }

  Future<Profile?> fetchProfile() async {
    final response = await repository.fetchProfile();
    if (response is Success) {
      setProfile(response.response as Profile);
    }
    return profile;
  }
}
