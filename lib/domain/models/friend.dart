class Friend {
  int? id;
  String? name;
  String? username;
  bool? isYourFriend;
  String? image;

  Friend({this.id, this.name, this.username, this.isYourFriend, this.image});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    isYourFriend = json['isYourFriend'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['isYourFriend'] = isYourFriend;
    data['image'] = image;
    return data;
  }
}