import 'dart:convert';

class ControleModel {
  int? ID;
  int? idFracao;
  int? idEntidade;
  int? idPropriedade;
  int? idGrupo;
  String? DataEntrada;
  String? DataSaida;
  String? RequerenteSaida;
  double? AreaEscopo;
  double? AreaAuditada;
  int? CicloTrabalho;
  ControleModel({
    this.ID,
    this.idFracao,
    this.idEntidade,
    this.idPropriedade,
    this.idGrupo,
    this.DataEntrada,
    this.DataSaida,
    this.RequerenteSaida,
    this.AreaEscopo,
    this.AreaAuditada,
    this.CicloTrabalho,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'idFracao': idFracao,
      'idEntidade': idEntidade,
      'idPropriedade': idPropriedade,
      'idGrupo': idGrupo,
      'DataEntrada': DataEntrada,
      'DataSaida': DataSaida,
      'RequerenteSaida': RequerenteSaida,
      'AreaEscopo': AreaEscopo,
      'AreaAuditada': AreaAuditada,
      'CicloTrabalho': CicloTrabalho,
    };
  }

  factory ControleModel.fromMap(Map<String, dynamic> map) {
    return ControleModel(
      ID: map['ID']?.toInt(),
      idFracao: map['idFracao']?.toInt(),
      idEntidade: map['idEntidade']?.toInt(),
      idPropriedade: map['idPropriedade']?.toInt(),
      idGrupo: map['idGrupo']?.toInt(),
      DataEntrada: map['DataEntrada'],
      DataSaida: map['DataSaida'],
      RequerenteSaida: map['RequerenteSaida'],
      AreaEscopo: map['AreaEscopo']?.toDouble(),
      AreaAuditada: map['AreaAuditada']?.toDouble(),
      CicloTrabalho: map['CicloTrabalho']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ControleModel.fromJson(String source) =>
      ControleModel.fromMap(json.decode(source));
}