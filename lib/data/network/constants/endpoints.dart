class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://10.0.2.2:5238/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  // cookbook endpoints
  static String getCookbooks(int personId) =>
      '$baseUrl/Cookbooks/by-person/$personId';
  static String addCookbook = '$baseUrl/Cookbooks';

  // person endpoints
  static String getPerson(int personId) => '$baseUrl/People/$personId';
  static String getPersonByEmail(String email) =>
      '$baseUrl/People/by-email/$email';
  static const String postLogin = '$baseUrl/People/login';
  static const String addPerson = '$baseUrl/People';
  static String patchPerson(int personId) => '$baseUrl/People/$personId';

  // recipe endpoints
  static String getRecipe(int recipeId) => '$baseUrl/Recipes/$recipeId';
  static String getRecipes(int cookbookId) =>
      '$baseUrl/Recipes/by-cookbook/$cookbookId';
  static String addRecipe = '$baseUrl/Recipes';
}
