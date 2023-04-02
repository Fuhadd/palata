import 'package:get_it/get_it.dart';
import 'package:untitled8/model/message_model.dart';
import 'package:untitled8/services/database.dart';
import 'package:untitled8/services/estate_service.dart';
import 'package:untitled8/services/navigation_service.dart';
import 'package:untitled8/viewModels/auth_view_model.dart';
import 'package:untitled8/viewModels/bottom_nav_view_model.dart';
import 'package:untitled8/viewModels/home_view_model.dart';
import 'package:untitled8/views/authScreen/login_screen.dart';
import 'package:untitled8/views/authScreen/sign_up_screen.dart';
import 'package:untitled8/views/bottomNavScreen/home_screen.dart';
import 'package:untitled8/views/bottomNavScreen/message_view.dart';
import 'package:untitled8/views/bottomNavScreen/profile_screen.dart';
import 'package:untitled8/views/bottomNavScreen/search_view.dart';
import 'package:untitled8/views/percentage_view.dart';
import 'package:untitled8/views/splash_screen.dart';
import 'package:untitled8/widgets/custom_bottom_nav.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => CustomBottomNav());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => EstateService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomNavViewModel());
  locator.registerLazySingleton(() => HomeScreen());
  locator.registerLazySingleton(() => MessageView());
  locator.registerLazySingleton(() => ProfileScreen());
  locator.registerLazySingleton(() => ViewEstate());
  locator.registerLazySingleton(() => PercentageView());
  locator.registerLazySingleton(() => MessageModel());
  locator.registerLazySingleton(() => SplashScreen());
  locator.registerLazySingleton(() => MessageService());
  locator.registerLazySingleton(() => LoginScreen());
  locator.registerLazySingleton(() => SignUpScreen());
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => DatabaseInfo());
}
