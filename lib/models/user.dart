class User {
  String name;
  String email;
  String imageUrl;
  String college;
  int batch;
  int semester;
  String branch;
  String uid;

  User(
      {this.name,
      this.email,
      this.imageUrl,
      this.batch,
      this.college,
      this.branch,
      this.semester,
      this.uid});

  User.fromJson(Map<String, dynamic> json) {
    uid = json['UID'];
    name = json['Name'];
    email = json['Email'];
    imageUrl = json['ImageURL'];
    college = json['College'];
    batch = json['Batch'];
    branch = json['Branch'];
    semester = json['Semester'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userDetail = new Map<String, dynamic>();
    userDetail['UID'] = this.uid;
    userDetail['Name'] = this.name;
    userDetail['Email'] = this.email;
    userDetail['ImageURL'] = this.imageUrl;
    userDetail['College'] = this.college;
    userDetail['Batch'] = this.batch;
    userDetail['Branch'] = this.branch;
    userDetail['Semester'] = this.semester;
    return userDetail;
  }
}
