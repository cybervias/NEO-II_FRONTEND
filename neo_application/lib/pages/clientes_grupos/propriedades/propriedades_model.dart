import 'dart:convert';

class PropriedadesModel {
  int? idPropriedade;
  String? Nome;
  String? CNPJ;
  int? XCoord;
  int? yCoord;
  int? AreaPropriedade;
  int? AreaTotal;
  int? AreaPlantada;
  int? AreaEstimaConservacao;
  int? AreaInfraestrutura;
  int? AreaOutrosUsos;
  String? Localizacao;
  String? UF;
  int? ID;

  PropriedadesModel({
    this.idPropriedade,
    this.Nome,
    this.CNPJ,
    this.XCoord,
    this.yCoord,
    this.AreaPropriedade,
    this.AreaTotal,
    this.AreaPlantada,
    this.AreaEstimaConservacao,
    this.AreaInfraestrutura,
    this.AreaOutrosUsos,
    this.Localizacao,
    this.UF,
    this.ID,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPropriedade': idPropriedade,
      'Nome': Nome,
      'CNPJ': CNPJ,
      'XCoord': XCoord,
      'yCoord': yCoord,
      'AreaPropriedade': AreaPropriedade,
      'AreaTotal': AreaTotal,
      'AreaPlantada': AreaPlantada,
      'AreaEstimaConservacao': AreaEstimaConservacao,
      'AreaInfraestrutura': AreaInfraestrutura,
      'AreaOutrosUsos': AreaOutrosUsos,
      'Localizacao': Localizacao,
      'UF': UF,
      'ID': ID,
    };
  }

  factory PropriedadesModel.fromMap(Map<String, dynamic> map) {
    return PropriedadesModel(
      idPropriedade: map['idPropriedade']?.toInt(),
      Nome: map['Nome'],
      CNPJ: map['CNPJ'],
      XCoord: map['XCoord']?.toInt(),
      yCoord: map['yCoord']?.toInt(),
      AreaPropriedade: map['AreaPropriedade']?.toInt(),
      AreaTotal: map['AreaTotal']?.toInt(),
      AreaPlantada: map['AreaPlantada']?.toInt(),
      AreaEstimaConservacao: map['AreaEstimaConservacao']?.toInt(),
      AreaInfraestrutura: map['AreaInfraestrutura']?.toInt(),
      AreaOutrosUsos: map['AreaOutrosUsos']?.toInt(),
      Localizacao: map['Localizacao'],
      UF: map['UF'],
      ID: map['ID']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PropriedadesModel.fromJson(String source) =>
      PropriedadesModel.fromMap(json.decode(source));
}
