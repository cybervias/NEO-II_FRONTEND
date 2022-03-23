import 'dart:convert';

class PropFlorestaModel {
  int? ID;
  int? IDPropriedade;
  int? IDTipoManejo;
  PropFlorestaModel({
    this.ID,
    this.IDPropriedade,
    this.IDTipoManejo,
  });

  PropFlorestaModel copyWith({
    int? ID,
    int? IDPropriedade,
    int? IDTipoManejo,
  }) {
    return PropFlorestaModel(
      ID: ID ?? this.ID,
      IDPropriedade: IDPropriedade ?? this.IDPropriedade,
      IDTipoManejo: IDTipoManejo ?? this.IDTipoManejo,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(ID != null){
      result.addAll({'ID': ID});
    }
    if(IDPropriedade != null){
      result.addAll({'IDPropriedade': IDPropriedade});
    }
    if(IDTipoManejo != null){
      result.addAll({'IDTipoManejo': IDTipoManejo});
    }
  
    return result;
  }

  factory PropFlorestaModel.fromMap(Map<String, dynamic> map) {
    return PropFlorestaModel(
      ID: map['ID']?.toInt(),
      IDPropriedade: map['IDPropriedade']?.toInt(),
      IDTipoManejo: map['IDTipoManejo']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PropFlorestaModel.fromJson(String source) => PropFlorestaModel.fromMap(json.decode(source));

  @override
  String toString() => 'PropFlorestaModel(ID: $ID, IDPropriedade: $IDPropriedade, IDTipoManejo: $IDTipoManejo)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PropFlorestaModel &&
      other.ID == ID &&
      other.IDPropriedade == IDPropriedade &&
      other.IDTipoManejo == IDTipoManejo;
  }

  @override
  int get hashCode => ID.hashCode ^ IDPropriedade.hashCode ^ IDTipoManejo.hashCode;
}
