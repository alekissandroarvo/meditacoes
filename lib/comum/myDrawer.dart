import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../leitura_meditacoes.dart';
import '../editar_meditacoes.dart';

import '../escrita_meditacoes.dart';
import 'classes.dart';

Future<List<MinhaMeditacao>> leituraMeditacoes() async {
  final Future<Database> database = openDatabase(
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
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('meditacao');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return MinhaMeditacao(
      id: maps[i]['id'],
      verso: maps[i]['verso'],
      licao: maps[i]['licao'],
      decisao: maps[i]['decisao'],
    );
  });
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'MENU',
              style: TextStyle(fontSize: 18),
            ),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Escrever Meditação'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EscritaMeditacoes()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Ler Meditações'),
              onTap: () {
                List<MinhaMeditacao> lista;
                leituraMeditacoes().then((value) => lista = value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeituraMeditacoes(meditacoes: lista),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Editar Meditações'),
              onTap: () {
                List<MinhaMeditacao> lista;
                leituraMeditacoes().then((value) => lista = value);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditarMeditacoes(meditacoes: lista),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
