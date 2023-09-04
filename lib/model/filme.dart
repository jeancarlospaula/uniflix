class Filme {
  int id;
  int duracao;
  String capa;
  String titulo;
  String resumo;
  String atores;

  Filme(
      {this.id = 0,
      this.capa = "",
      this.titulo = "",
      this.resumo = "",
      this.atores = "",
      this.duracao = 0});

  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      id: json['id'],
      capa: json['capa'],
      titulo: json['titulo'],
      resumo: json['resumo'],
      atores: json['atores'],
      duracao: json['duracao'],
    );
  }
}
