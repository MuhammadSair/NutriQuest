import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:module_1/Navigation_menu.dart';
import 'package:module_1/Screens/login_screen%20.dart';
import 'package:module_1/Screens/recipes/favorite_provider.dart';
import 'package:module_1/firebase_options.dart';
// import 'package:module_1/home_page.dart';
import 'package:module_1/themes/theme.dart';
import 'package:module_1/utils/constants/text_strings.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.remove();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child: GetMaterialApp(
          title: TTexts.appName,
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          // initialBinding: GeneralBindings(),
          // home: const NavigationMenu());
          home: const LoginScreen()),
    );
  }
}
