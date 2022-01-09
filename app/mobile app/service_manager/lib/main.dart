import 'package:flutter/material.dart';
import './Home/home.dart';
import './route_generator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const server = 'http://192.168.8.181:5000/'; //url of the backend

const secureStorage = FlutterSecureStorage(); //storage for sensitive data

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aloni',
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
          //color theme
          colorScheme: const ColorScheme(
              primary: Color.fromARGB(255, 78, 71, 71),
              secondary: Color.fromARGB(255, 218, 214, 214),
              background: Color.fromARGB(255, 255, 255, 255),
              brightness: Brightness.light,
              error: Color.fromARGB(255, 255, 0, 0),
              onBackground: Color.fromARGB(255, 0, 0, 0),
              onError: Color.fromARGB(255, 255, 255, 255),
              onPrimary: Color.fromARGB(200, 255, 255, 255),
              onSecondary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 0, 0, 0),
              primaryVariant: Color.fromARGB(255, 50, 47, 47),
              secondaryVariant: Color.fromARGB(255, 100, 100, 100),
              surface: Color.fromARGB(255, 255, 255, 255)),

          //theme for all the elevated buttons
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
                  return const EdgeInsets.only(bottom: 15, top: 15);
                },
              ),
              textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                  (Set<MaterialState> states) {
                return const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold);
              }),
            ),
          ),
          textTheme: const TextTheme(
            bodyText2: TextStyle(fontSize: 15.0),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(textStyle:
                MaterialStateProperty.resolveWith<TextStyle>(
                    (Set<MaterialState> states) {
              return const TextStyle(
                  fontSize: 15, decoration: TextDecoration.underline);
            })),
          ),
        ),
        home: const Home());
  }
}
