class BASEURL {
  static String ipAddress = '192.168.0.104';
  static String apiRegister = 'http://$ipAddress/e-medicine/register_api.php';
  static String apiLogin = 'http://$ipAddress/e-medicine/login_api.php';
  static String categoryWithProduct =
      'http://$ipAddress/e-medicine/get_product_with_category.php';
  static String getProduct = 'http://$ipAddress/e-medicine/get_product.php';
  static String addToCart = 'http://$ipAddress/e-medicine/add_to_cart.php';
  static String getProductCart =
      'http://$ipAddress/e-medicine/get_cart.php?userID=';
  static String updateQuantityProductCart =
      'http://$ipAddress/e-medicine/update_quantity.php';
  static String totalPriceCart =
      'http://$ipAddress/e-medicine/get_total_price.php?userID=';
  static String getTotalCart =
      'http://$ipAddress/e-medicine/total_cart.php?userID=';
  static String checkout = 'http://$ipAddress/e-medicine/checkout.php';
  static String historyOrder = 'http://$ipAddress/e-medicine/get_history.php?id_user=';
}
