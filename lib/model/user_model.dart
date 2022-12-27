class UserModel {
  String? name;
  String? id;
  String? phone;
  String? childEmail;
  String? parentEmail;
  String? usertype;
  UserModel(
      {this.name,
      this.id,
      this.phone,
      this.childEmail,
      this.parentEmail,
      this.usertype});

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'id': id,
        'childEmail': childEmail,
        'parentEmail': parentEmail,
        'type': usertype,
      };
}
