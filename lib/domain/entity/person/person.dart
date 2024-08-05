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
        personId: json["id"],
        displayName: json["userName"],
        email: json["email"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toMap() => {
        "id": personId,
        "userName": displayName,
        "email": email,
        "imagePath": imagePath,
        "password": password,
      };
}
