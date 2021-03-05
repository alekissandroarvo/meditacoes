import 'package:flutter/material.dart';
import 'comum/myAppBar.dart';
import 'comum/myDrawer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'meditacao.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE meditacao(id INTEGER PRIMARY KEY, verso TEXT, licao TEXT, decisao TEXT)",
      );
    },
    version: 1,
  );

  //inserir meditação

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String verso = '''
"Bem-aventurado o homem que não anda segundo o conselho dos ímpios, nem se detém no caminho dos pecadores, nem se assenta na roda dos escarnecedores; antes tem seu prazer na lei do Senhor, e na sua lei medita de dia e noite."
Salmos 1.1,2
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.amber.shade50,
      appBar: MyAppBar(),
      body: Center(
        child: Text(
          "$verso",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
