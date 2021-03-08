import 'package:flutter/material.dart';
import 'comum/classes.dart';
import 'comum/myAppBar.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';
import 'update_meditacoes.dart';

class EditarMeditacoes extends StatelessWidget {
  final List<MinhaMeditacao> meditacoes;
  EditarMeditacoes({Key key, this.meditacoes}) : super(key: key);

  Future<void> deleteMeditacao(MinhaMeditacao meditacao) async {
    // Get a reference to the database.
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

    // Update the given Dog.
    await db.delete(
      'meditacao',

      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [meditacao.id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: MyAppBar(),
      body: ListView.builder(
        itemCount: meditacoes.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Verso",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${meditacoes[index].verso}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Licão",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${meditacoes[index].licao}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Decisões",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${meditacoes[index].decisao}",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateMeditacoes(
                                      meditacao: this.meditacoes[index],
                                    )),
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteMeditacao(meditacoes[index]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.black,
                              content: Text(
                                "Meditação Deletada",
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
