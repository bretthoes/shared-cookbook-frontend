class Person {
  int? personId;
  int? id;
  String? displayName;
  String? email;
  String? imagePath;
  String? password;

  Person({
    this.personId,
    this.id,
    this.displayName,
    this.email,
    this.imagePath,
    this.password,
  });

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        personId: json["personId"],
        id: json["id"],
        displayName: json["displayName"],
        email: json["email"],
        imagePath: json["imagePath"],
      );

  Map<String, dynamic> toMap() => {
        "personId": personId,
        "id": id,
        "displayName": displayName,
        "email": email,
        "imagePath": imagePath,
        "password": password,
      };
}
