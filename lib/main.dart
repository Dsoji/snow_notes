import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_snow/features/home/view/home_view.dart';
import 'package:notes_snow/features/models/note_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initializing hive
  await Hive.initFlutter();
  //hive box
  await Hive.openBox('note_database');
  //

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
  //   runApp(const MyApp());
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light().copyWith(
          textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Avenir'),
        ),
        darkTheme: ThemeData.dark().copyWith(
          textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Avenir'),
        ),
        themeMode: Provider.of<NoteData>(context).isDarkMode
            ? ThemeMode.dark
            : ThemeMode.light,
        home: const HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
