class Profile {
  int? id;
  String? name;
  String? userName;
  String? description;
  String? imageProfile;
  String? imageWall;
  int? numberOfFriends;
  String? github;
  String? gitlab;
  String? linkedin;

  Profile(
      {this.id,
        this.name,
        this.userName,
        this.description,
        this.imageProfile,
        this.imageWall,
        this.numberOfFriends,
        this.github,
        this.gitlab,
        this.linkedin});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userName = json['user_name'];
    description = json['description'];
    imageProfile = json['image_profile'];
    imageWall = json['image_wall'];
    numberOfFriends = json['number_of_friends'];
    github = json['github'];
    gitlab = json['gitlab'];
    linkedin = json['linkedin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_name'] = userName;
    data['description'] = description;
    data['image_profile'] = imageProfile;
    data['image_wall'] = imageWall;
    data['number_of_friends'] = numberOfFriends;
    data['github'] = github;
    data['gitlab'] = gitlab;
    data['linkedin'] = linkedin;
    return data;
  }
}