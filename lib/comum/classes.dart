class MinhaMeditacao {
  int id;
  String verso;
  String licao;
  String decisao;

  MinhaMeditacao({int id, String verso, String licao, String decisao}) {
    this.id = id;
    this.verso = verso;
    this.licao = licao;
    this.decisao = decisao;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'verso': verso,
      'licao': licao,
      'decisao': decisao,
    };
  }
}
