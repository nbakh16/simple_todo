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

    final ThemeData _lightTheme = ThemeData(

    );

    final ThemeData _darkTheme = ThemeData(

    );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Todo',
      home: HomeView(),
    );
  }
}












