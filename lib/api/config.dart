// import 'package:flutter_dotenv/flutter_dotenv.dart';
class Config {
  // Base URL for WooCommerce
  static const String  baseUrl = 'https://gangtarang.com'; // your woocommerce site
  // WooCommerce API credentials
  static const String consumerKey = 'ck_faa8936966453996bb7e7ef41ade12c8419d9b7c'; //your_consumer_key
  static const String consumerSecret = 'cs_49382dfee72c48efb49008b26824031bf643bbf6'; //your_consumer_secret
  // User Registertation
  static const String username = 'ishuagarwal3'; //your_wordpress_username
  static const String password= 'wALf KK7D G7k7 s6lb J086 8DJk'; //your_wordress_application_password

   // User Authentication Endpoints
  static const String registerEndpoint = "$baseUrl/wp/v2/users";
  static const String loginEndpoint = "$baseUrl/jwt-auth/v1/token";  // JWT token endpoint
 // static const String registerEndpoint = "$baseUrl/wp/v2/users";
 // JWT token endpoint



  // // Base URL for WooCommerce
  // static String get baseUrl => dotenv.env['baseUrl']!; // your woocommerce site
  // static String get base => baseUrl;
  // // WooCommerce API credentials
  // static  String consumerKey = dotenv.env['consumerKey']!; //your_consumer_key
  // static  String consumerSecret = dotenv.env['consumerSecret']!; //your_consumer_secret
  // // User Registertation
  // static  String username = dotenv.env['username']!; //your_wordpress_username
  // static  String password= dotenv.env['password']!; //your_wordress_application_password
}
