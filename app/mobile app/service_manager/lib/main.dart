import 'package:flutter/material.dart';
import './Home/home.dart';
import './route_generator.dart';

const server = 'http://192.168.43.10:5000/';

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
        title: 'Service Manager',
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
              onPrimary: Color.fromARGB(255, 255, 255, 255),
              onSecondary: Color.fromARGB(255, 255, 255, 255),
              onSurface: Color.fromARGB(255, 0, 0, 0),
              primaryVariant: Color.fromARGB(255, 50, 47, 47),
              secondaryVariant: Color.fromARGB(255, 163, 157, 157),
              surface: Color.fromARGB(255, 255, 255, 255)),

          //theme for all the elevated buttons
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                (Set<MaterialState> states) {
                  return const ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  );
                },
              ),
              padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                (Set<MaterialState> states) {
                  return const EdgeInsets.only(bottom: 15, top: 15);
                },
              ),
              /*backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return const Color.fromARGB(100, 78, 71, 71);
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  return const Color.fromARGB(100, 255, 255, 255);
                },
              ),*/
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
