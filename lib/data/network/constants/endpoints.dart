class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://10.0.2.2:7144/api";
  //"http://jsonplaceholder.typicode.com"; //"http://10.0.2.2:7251/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // cookbook endpoints
  static String getCookbooks(int personId) =>
      '$baseUrl/Cookbooks/person/$personId';

  // person endpoints
  static String getPerson(int personId) => '$baseUrl/People/$personId';
  static const String postLogin = '$baseUrl/People/login';
}
