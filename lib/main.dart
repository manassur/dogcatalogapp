import 'package:dogcatalogapp/controllers/breed_controller.dart';
import 'package:dogcatalogapp/view/screens/breed_list_screen.dart';
import 'package:dogcatalogapp/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/navigator_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BreedController()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dog App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: ((context) =>  const HomeScreen()),
        BreedListScreen.route: (context) {
          final breed = ModalRoute.of(context)?.settings.arguments as String;
          return BreedListScreen(breed: breed);
        },      },


    );
  }
}
