import 'package:amazmart/screens/coupons_screen/Coupons_Screen.dart';
import 'package:amazmart/screens/profile_page/profile_page.dart';
import 'package:amazmart/screens/wishlist_page/wishlist_page.dart';
import 'package:flutter/material.dart';
import '../screens/splash_screen/splash_screen.dart';
import '../screens/choose_your_language_screen/choose_your_language_screen.dart';
import '../screens/onboarding_screen/onboarding_screen.dart';
import '../screens/sign_up_screen/sign_up_screen.dart';
import '../screens/sign_in_screen/sign_in_screen.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/cart_screen/cart_screen.dart';
import '../screens/edit_profile_screen/edit_profile_screen.dart';
import '../screens/delivery_address_screen/delivery_address_screen.dart';
import '../screens/add_delivery_address_screen/add_delivery_address_screen.dart';
import '../screens/payment_screen/payment_screen.dart';
import '../screens/add_card_screen/add_card_screen.dart';
import '../screens/checkout_screen/checkout_screen.dart';
import '../screens/my_order_ongoing_screen/my_order_ongoing_screen.dart';
import '../screens/write_review_screen/write_review_screen.dart';
import '../screens/track_order_screen/track_order_screen.dart';
import '../screens/products_list_screen/products_list_screen.dart';
import '../screens/products_screen/products_screen.dart';
import '../screens/search_screen/search_screen.dart';
import '../screens/notifications_screen/notifications_screen.dart';
import '../screens/chat_list_screen/chat_list_screen.dart';
import '../screens/chat_screen/chat_screen.dart';
import '../screens/enter_code_otp_screen/enter_code_otp_screen.dart';
import '../screens/forgot_password_screen/forgot_password_screen.dart';
import '../screens/saved_card_screen/saved_card_screen.dart';
import '../screens/saved_address_screen/saved_address_screen.dart';


// ignore_for_file: must_be_immutable

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String OnboardingScreen = '/onboarding_screen';
  static const String chooseYourLanguageScreen = '/choose_your_language_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String signInScreen = '/sign_in_screen';
  static const String homeScreen = '/home_screen';

  static const String wishlistPage = '/wishlist_page';
  static const String cartScreen = '/cart_screen';
  static const String categoryPage = '/category_page';
  static const String profilePage = '/profile_page';
  static const String deliveryAddressScreen = '/delivery_address_screen';
  static const String addDeliveryAddressScreen = '/add_delivery_address_screen';
  static const String paymentScreen = '/payment_screen';
  static const String addCardScreen = '/add_card_screen';
  static const String checkoutScreen = '/checkout_screen';
  static const String myOrderOngoingScreen = '/my_order_ongoing_screen';
  static const String writeReviewScreen = '/write_review_screen';
  static const String trackOrderScreen = '/track_order_screen';

  static const String productsScreen = '/products_screen';
  static const String productsSortitTabPage = '/products_sortit_tab_page';
  static const String productsListScreen = '/products_list_screen';
  static const String shopDetailsScreen = '/shop_details_screen';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String searchScreen = '/search_screen';
  static const String notificationsScreen = '/notifications_screen';
  static const String chatListScreen = '/chat_list_screen';
  static const String chatScreen = '/chat_screen';
  static const String orderlistTabPage = '/orderlist_tab_page';
  static const String otpScreen = '/otp_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String enterCodeOtpScreen = '/enter_code_otp_screen';
  static const String homeInitialPage = '/home_initial_page';
  static const String couponscreen = '/coupons_screen';
  static const String savedcardscreen = '/saved_card_screen';
  static const String savedaddressscreen = '/saved_address_screen';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    chooseYourLanguageScreen: (context) => ChooseYourLanguageScreen(),
    OnboardingScreen: (context) => onboardingScreen(),
    signUpScreen: (context) => SignUpScreen(),
    signInScreen: (context) => SignInScreen(),
    homeScreen: (context) => HomeScreen(),
    cartScreen: (context) => CartScreen(),
    editProfileScreen: (context) => EditProfileScreen(),
    deliveryAddressScreen: (context) => DeliveryAddressScreen(),
    addDeliveryAddressScreen: (context) => AddDeliveryAddressScreen(),
    paymentScreen: (context) => PaymentScreen(),
    addCardScreen: (context) => AddCardScreen(),
    checkoutScreen: (context) => CheckoutScreen(),
    myOrderOngoingScreen: (context) => MyOrderOngoingScreen(),
    // writeReviewScreen: (context) => WriteReviewScreen(),
    // trackOrderScreen: (context) => TrackOrderScreen(),
    productsListScreen: (context) => ProductsListScreen(),
    productsScreen: (context) => ProductsScreen(),
    searchScreen: (context) => SearchScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    chatListScreen: (context) => ChatListScreen(),
    chatScreen: (context) => ChatScreen(),
    wishlistPage: (context) => WishlistPage(),
    profilePage: (context) => ProfilePage(),
    forgotPasswordScreen: (context) => ForgotPasswordScreen(),
    otpScreen: (context) => EnterCodeOtpScreen(),
    couponscreen: (context) => CouponsScreen(),
    savedcardscreen: (context) => SavedCardScreen(),
    savedaddressscreen : (context) => SavedAddressScreen(),

    initialRoute: (context) => SplashScreen()
  };

}