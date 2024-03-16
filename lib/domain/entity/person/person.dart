// TODO remove id, make params final, test
class Person {
  int? personId;
  String? displayName;
  String? email;
  String? imagePath;
  String? password;

  Person({
    this.personId,
    this.displayName,
    this.email,
    this.imagePath,
    this.password,
  });

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        personId: json["personId"],
        displayName: json["displayName"],
        email: json["email"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toMap() => {
        "personId": personId,
        "displayName": displayName,
        "email": email,
        "imagePath": imagePath,
        "password": password,
      };
}
