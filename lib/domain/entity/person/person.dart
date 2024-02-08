class Person {
  int? personId;
  int? id;
  String? displayName;
  String? email;

  Person({
    this.personId,
    this.id,
    this.displayName,
    this.email,
  });

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        personId: json["personId"],
        id: json["id"],
        displayName: json["displayName"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "personId": personId,
        "id": id,
        "displayName": displayName,
        "email": email,
      };
}
