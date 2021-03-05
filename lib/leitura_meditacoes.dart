import 'package:flutter/material.dart';
import 'comum/myAppBar.dart';
import 'comum/classes.dart';

class LeituraMeditacoes extends StatelessWidget {
  final List<MinhaMeditacao> meditacoes;
  LeituraMeditacoes({Key key, this.meditacoes}) : super(key: key);

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
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
