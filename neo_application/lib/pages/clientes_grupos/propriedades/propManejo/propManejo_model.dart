import 'dart:convert';

class PropManejoModel {
  int? ID;
  int? IDPropriedade;
  int? IDTipoManejo;
 

  PropManejoModel({
    this.ID,
    this.IDPropriedade,
    this.IDTipoManejo,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'IDPropriedade': IDPropriedade,
      'IDTipoManejo': IDTipoManejo,
    };
  }

  factory PropManejoModel.fromMap(Map<String, dynamic> map) {
    return PropManejoModel(
      ID: map['ID']?.toInt(),
      IDPropriedade: map['IDPropriedade']?.toInt(),
      IDTipoManejo: map['IDTipoManejo']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PropManejoModel.fromJson(String source) =>
      PropManejoModel.fromMap(json.decode(source));
}
