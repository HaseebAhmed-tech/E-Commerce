import 'package:e_commerce/ui/bottom_nav_controller.dart';
import 'package:e_commerce/ui/bottom_nav_pages/home.dart';
import 'package:e_commerce/ui/bottom_nav_pages/search_screen.dart';
import 'package:e_commerce/ui/login_screen.dart';
import 'package:e_commerce/ui/product_details_screen.dart';
import 'package:e_commerce/ui/signup_screen.dart';
import 'package:e_commerce/ui/splashscreen.dart';
import 'package:get/get.dart';

const String loginRoute = '/login';
const String homeRoute = '/home';
const String signupRoute = '/signup';
const String splashRoute = '/splash';
const String bottomNavigator = '/botNav';
const String searchRoute = '/search';
const String productDetailsRoute = '/productDetails';
appRoutes() => [
      GetPage(
        name: splashRoute,
        page: () => const SplashScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: loginRoute,
        page: () => const LoginScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: homeRoute,
        page: () => const Home(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(
        name: searchRoute,
        page: () => const SearchScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: productDetailsRoute,
        page: () => ProductDetailsScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: signupRoute,
        page: () => const SignupScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: const Duration(milliseconds: 200),
      ),
      GetPage(
        name: bottomNavigator,
        page: () => const BottomNavController(),
        transition: Transition.downToUp,
        transitionDuration: const Duration(milliseconds: 200),
      ),
    ];
