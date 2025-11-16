import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/home.dart';
import 'package:test/screens/make_task.dart';

late Box box;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox('tasks');
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
      initialRoute: Home.routs,
      routes: {
        Home.routs: (context) => const Home(),
        MakeTask.routs: (context) => MakeTask(),
      },
    );
  }
}
