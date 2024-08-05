class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://10.0.2.2:5001/api";

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
  static String getPerson(int personId) => '$baseUrl/Users/$personId';
  static String getPersonByEmail(String email) =>
      '$baseUrl/Users/by-email/$email';
  static const String postLogin = '$baseUrl/Users/login';
  static const String addPerson = '$baseUrl/Users';
  static String patchPerson(int personId) => '$baseUrl/Users/$personId';

  // recipe endpoints
  static String getRecipe(int recipeId) => '$baseUrl/Recipes/$recipeId';
  static String getRecipes(int cookbookId) =>
      '$baseUrl/Recipes/by-cookbook/$cookbookId';
  static String addRecipe = '$baseUrl/Recipes';
}
