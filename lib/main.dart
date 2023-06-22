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
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeView(),
    );
  }

  final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.lightBlue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.lightBlue),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.black
      ),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey[200]

      ),
      iconTheme: const IconThemeData(
          color: Colors.deepPurple
      ),
      listTileTheme: ListTileThemeData(
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
        color: Colors.deepPurple[200]
      ),
      listTileTheme: const ListTileThemeData(
          tileColor: Colors.green,
          selectedTileColor: Colors.orange
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












