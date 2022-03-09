import 'dart:convert';

class UserModel {
  int? idAuditor;
  String? Nome;
  String? DataInicio;
  String? Especialidade;
  String? qAuditor;
  String? qAuditorLider;
  String? qLiderExperiencia;
  String? Usuario;
  UserModel({
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
      'idAuditor': idAuditor,
      'Nome': Nome,
      'DataInicio': DataInicio,
      'Especialidade': Especialidade,
      'qAuditor': qAuditor,
      'qAuditorLider': qAuditorLider,
      'qLiderExperiencia': qLiderExperiencia,
      'Usuario': Usuario,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      idAuditor: map['idAuditor']?.toInt(),
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

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
