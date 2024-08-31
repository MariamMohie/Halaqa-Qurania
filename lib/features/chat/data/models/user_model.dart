class user_model {
  String? userid;
  String? username;
  String? userimage;

  user_model({this.userid, this.username, this.userimage});

  user_model.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    userimage = json['userimage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = userid;
    data['username'] = username;
    data['userimage'] = userimage;
    return data;
  }

}