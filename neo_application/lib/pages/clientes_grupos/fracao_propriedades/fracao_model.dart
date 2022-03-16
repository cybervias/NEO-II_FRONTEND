import 'dart:convert';

class FracaoPropModel {
  int? ID;
  int? IDEntidade;
  int? IDPropriedade;
  int? Fracao;

  FracaoPropModel({
    this.ID,
    this.IDEntidade,
    this.IDPropriedade,
    this.Fracao,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'IDEntidade': IDEntidade,
      'IDPropriedade': IDPropriedade,
      'Fracao': Fracao,
    };
  }

  factory FracaoPropModel.fromMap(Map<String, dynamic> map) {
    return FracaoPropModel(
      ID: map['ID']?.toInt(),
      IDEntidade: map['IDEntidade']?.toInt(),
      IDPropriedade: map['IDPropriedade']?.toInt(),
      Fracao: map['Fracao']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FracaoPropModel.fromJson(String source) =>
      FracaoPropModel.fromMap(json.decode(source));
}
