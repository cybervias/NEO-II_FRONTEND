import 'dart:convert';

class ColaboradorModel {
  
  int? idAuditor;
  String? Nome;
  String? DataInicio;
  String? Especialidade;
  String? qAuditor;
  String? qAuditorLider;
  String? qLiderExperiencia;
  String? Usuario;

  
  ColaboradorModel({
    this.idAuditor,
    this.Nome,
    this.DataInicio,
    this.Especialidade,
    this.qAuditor,
    this.qAuditorLider,
    this.qLiderExperiencia,
    this.Usuario,
  });

  Map<String, dynamic> toMap() {
    return {
      "idAuditor": idAuditor,
      "Nome": Nome,
      "DataInicio": DataInicio,
      "Especialidade": Especialidade,
      "qAuditor": qAuditor,
      "qAuditorLider": qAuditorLider,
      "qLiderExperiencia": qLiderExperiencia,
      "Usuario": Usuario,
    };
  }

  factory ColaboradorModel.fromMap(Map<String, dynamic> map) {
    return ColaboradorModel(
      idAuditor: map['idAuditor'],
      Nome: map['Nome'],
      DataInicio: map['DataInicio'],
      Especialidade: map['Especialidade'],
      qAuditor: map['qAuditor'],
      qAuditorLider: map['qAuditorLider'],
      qLiderExperiencia: map['qLiderExperiencia'],
      Usuario: map['Usuario'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ColaboradorModel.fromJson(String source) =>
      ColaboradorModel.fromMap(json.decode(source));
}