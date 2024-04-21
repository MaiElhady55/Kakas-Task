class ApiConstance {
  static const String baseUrl = 'https://test.kakas.app/api';

  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static String products(String? title) {
    if (title != null) {
      return '/products/?title=$title';
    } else {
      return '/products/';
    }
  }

  static const String addProducts = '/products/';
  static String deleteProduct({required int id}) => '/products/?id=$id';
  static String editProduct({required int id}) => '/products/?id=$id';
  static const String uploadImage = '/upload/';
}
