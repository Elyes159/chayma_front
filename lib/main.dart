import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:sagemcom/database.dart';
import 'package:sagemcom/pages/homescreen.dart';
import 'package:sagemcom/pages/loginscreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: loginscreen());
  }
}

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  Future<void> ConnectToDatabase() async {
    MySqlConnection conn = (await Database.getconnection()) as MySqlConnection;
    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CupertinoButton(
      child: Text('connect to database'),
      onPressed: () {
        ConnectToDatabase();
      },
    )));
  }
}
