// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EnderecoModel {
  final String cep;
  final String logradouro;
  final String bairro;
  final String ddd;
  final String localidade;

  EnderecoModel({
    required this.cep,
    required this.logradouro,
    required this.bairro,
    required this.ddd,
    required this.localidade,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cep': cep,
      'logradouro': logradouro,
      'bairro': bairro,
      'ddd': ddd,
      'localidade': localidade,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      cep: map['cep'] as String,
      logradouro: map['logradouro'] as String,
      bairro: map['bairro'] as String,
      ddd: map['ddd'] as String,
      localidade: map['localidade'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoModel.fromJson(String source) =>
      EnderecoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  EnderecoModel copyWith({
    String? cep,
    String? logradouro,
    String? bairro,
    String? ddd,
    String? localidade,
  }) {
    return EnderecoModel(
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      bairro: bairro ?? this.bairro,
      ddd: ddd ?? this.ddd,
      localidade: localidade ?? this.localidade,
    );
  }

  @override
  String toString() {
    return 'EnderecoModel(cep: $cep, logradouro: $logradouro, bairro: $bairro, ddd: $ddd, localidade: $localidade)';
  }

  @override
  bool operator ==(covariant EnderecoModel other) {
    if (identical(this, other)) return true;

    return other.cep == cep &&
        other.logradouro == logradouro &&
        other.bairro == bairro &&
        other.ddd == ddd &&
        other.localidade == localidade;
  }

  @override
  int get hashCode {
    return cep.hashCode ^
        logradouro.hashCode ^
        bairro.hashCode ^
        ddd.hashCode ^
        localidade.hashCode;
  }
}
