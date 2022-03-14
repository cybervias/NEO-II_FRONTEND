import 'dart:convert';

class GruposModel {
  int? idGrupo;
  String? Nome;
  String? DataFormacao;
  int? IDGestor;

  GruposModel({
    this.idGrupo,
    this.Nome,
    this.DataFormacao,
    this.IDGestor,
  });

  Map<String, dynamic> toMap() {
    return {
      'idGrupo': idGrupo,
      'Nome': Nome,
      'DataFormacao': DataFormacao,
      'IDGestor': IDGestor,
    };
  }

  factory GruposModel.fromMap(Map<String, dynamic> map) {
    return GruposModel(
      idGrupo: map['idGrupo']?.toInt(),
      Nome: map['Nome'],
      DataFormacao: map['DataFormacao'],
      IDGestor: map['IDGestor']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GruposModel.fromJson(String source) =>
      GruposModel.fromMap(json.decode(source));
}
