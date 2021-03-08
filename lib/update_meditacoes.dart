import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'comum/classes.dart';
import 'comum/myAppBar.dart';
import 'main.dart';

class UpdateMeditacoes extends StatelessWidget {
  final MinhaMeditacao meditacao;
  UpdateMeditacoes({Key key, this.meditacao}) : super(key: key);

  Future<void> updateMeditacao(MinhaMeditacao meditacao) async {
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
    final db = await database;

    // Update the given Dog.
    await db.update(
      'meditacao',
      meditacao.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [meditacao.id],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _versoController =
        TextEditingController(text: "${this.meditacao.verso}");
    final _licaoController =
        TextEditingController(text: "${this.meditacao.licao}");
    final _decisoesController =
        TextEditingController(text: "${this.meditacao.decisao}");
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
                            id: this.meditacao.id,
                            verso: _versoController.text,
                            licao: _licaoController.text,
                            decisao: _decisoesController.text,
                          );
                          updateMeditacao(meditacao);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
