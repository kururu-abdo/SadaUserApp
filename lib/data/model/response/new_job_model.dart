class NewJobModel {
  


  String? name;
  int? jobId;

  String? email;
  String? phoneNumber;

  String? desc;
  int? cityId;

  String? profilePhoto; //base64






  Map<String, dynamic>  toJson(){
    return {
      'name':name ,
      'user_job_id':jobId,
      'email':email,
      'phone_number':phoneNumber,
      'des':desc,
      'city_id':cityId,
      'profile_photo':profilePhoto 
    };
  }
}