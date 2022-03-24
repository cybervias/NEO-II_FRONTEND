import 'dart:convert';

class ControleModel {
  int? ID;
  int? idFracao;
  var fracao;
  int? idEntidade;
  var entidades;
  int? idPropriedade;
  var propriedades;
  int? idGrupo;
  var grupos;
  String? DataEntrada;
  String? DataSaida;
  String? RequerenteSaida;
  double? AreaEscopo;
  double? AreaAuditada;
  int? CicloTrabalho;

  
  ControleModel({
    this.ID,
    this.idFracao,
    this.fracao,
    this.idEntidade,
    this.entidades,
    this.idPropriedade,
    this.propriedades,
    this.idGrupo,
    this.grupos,
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
      'fracao': fracao,
      'idEntidade': idEntidade,
      'entidades': entidades,
      'idPropriedade': idPropriedade,
      'propriedades': propriedades,
      'idGrupo': idGrupo,
      'grupos': grupos,
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
      fracao: map['fracao'],
      idEntidade: map['idEntidade']?.toInt(),
      entidades: map['entidades'],
      idPropriedade: map['idPropriedade']?.toInt(),
      propriedades: map['propriedades'],
      idGrupo: map['idGrupo']?.toInt(),
      grupos: map['grupos'],
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