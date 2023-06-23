import 'package:flutter/material.dart';
import 'package:simple_todo_ostad/view/home_view.dart';

// TODO 1 - Button for switch theme

main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  bool isLight = true;
  void switchTheme() {
    setState(() {
      isLight = !isLight;
    });
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
      home: HomeView(switchTheme, isLight),
    );
  }

  final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.light,
      // appBarTheme: const AppBarTheme(backgroundColor: Colors.lightBlue),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          // backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white
      ),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200]

      ),
      iconTheme: const IconThemeData(
          color: Colors.teal
      ),
      listTileTheme: const ListTileThemeData(
          tileColor: Colors.lightGreen,
          selectedTileColor: Colors.deepOrange
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          )
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.blue
        )
      )
  );

  final ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white
      ),
      inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.black54,
          labelStyle: TextStyle(color: Colors.white)
      ),
      iconTheme: IconThemeData(
        color: Colors.deepPurple[100]
      ),
      listTileTheme: const ListTileThemeData(
          tileColor: Colors.lightGreen,
          selectedTileColor: Colors.deepOrange
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
          )
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.deepPurple[200]
          )
      )
  );
}












