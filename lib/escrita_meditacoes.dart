import 'package:flutter/material.dart';
import 'package:meditacoes/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'comum/myAppBar.dart';
import 'comum/classes.dart';

class EscritaMeditacoes extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _versoController = TextEditingController();
  final _licaoController = TextEditingController();
  final _decisoesController = TextEditingController();

  Future<void> insertMeditacao(MinhaMeditacao meditacao) async {
    final Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'meditacao.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE meditacao(id INTEGER PRIMARY KEY, verso TEXT, licao TEXT, decisao TEXT, data TEXT)",
        );
      },
      version: 1,
    );
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'meditacao',
      meditacao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //ler meditações

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: MyAppBar(),
      body: Center(
        child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                      ),
                      //Texto Bíblico
                      Text(
                        "Versículo",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          controller: _versoController,
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                      //Lição
                      Text(
                        "Lição",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          controller: _licaoController,
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                      //Decisões
                      Text(
                        "Decisões",
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          controller: _decisoesController,
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            MinhaMeditacao meditacao = MinhaMeditacao(
                              verso: _versoController.text,
                              licao: _licaoController.text,
                              decisao: _decisoesController.text,
                            );
                            insertMeditacao(meditacao);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  "Meditação Salva",
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
                          child: Text("Salvar"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
