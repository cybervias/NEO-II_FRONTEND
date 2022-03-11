import 'dart:convert';

class EntidadesModel {
  int? Id;
  String? Nome;
  String? Contato;
  String? Telefone;
  String? Email;
 

  EntidadesModel({
    this.Id,
    this.Nome,
    this.Contato,
    this.Telefone,
    this.Email,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'Nome': Nome,
      'Contato': Contato,
      'Telefone': Telefone,
      'Email': Email,
    };
  }

  factory EntidadesModel.fromMap(Map<String, dynamic> map) {
    return EntidadesModel(
      Id: map['Id']?.toInt(),
      Nome: map['Nome'],
      Contato: map['Contato'],
      Telefone: map['Telefone'],
      Email: map['Email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EntidadesModel.fromJson(String source) =>
      EntidadesModel.fromMap(json.decode(source));
}
