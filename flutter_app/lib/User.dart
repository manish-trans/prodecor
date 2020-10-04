class User{
  int id;
  String name,email;

  User(this.id, this.name, this.email);
  User.fromJson(Map json)
      :id=json['id'],
        name=json['name'],
        email=json['email'];
  Map toJson()
  {
    return {
      'id':id,'name':name,'email':email
    };
  }



}
