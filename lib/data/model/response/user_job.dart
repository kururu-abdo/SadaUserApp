class UserJob {
  int id;
  String name;
  int userJobId;
  String profilePhoto;
  String des;
  String phoneNumber;
  String email;
  int isActive;
  String job;
  String city;
  String region;
  int cityId;

  UserJob(
      {this.id,
      this.name,
      this.userJobId,
      this.profilePhoto,
      this.des,
      this.phoneNumber,
      this.email,
      this.isActive,
      this.cityId});

  UserJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userJobId = json['user_job_id'];
    profilePhoto = json['profile_photo'];
    job=json['job'];
    city=json['city_name'];
    region=json['region_name'];
    des = json['des'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    isActive = json['is_active'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_job_id'] = this.userJobId;
    data['profile_photo'] = this.profilePhoto;
    data['des'] = this.des;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['city_id'] = this.cityId;
    return data;
  }
}
