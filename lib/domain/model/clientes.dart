import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clientes.g.dart';

@JsonSerializable()
class Clientes {
  String id;
  String nome;
  String sexo;
  String idade;
  String endereco;
  String numero;
  String bairro;
  String cidade;
  String telefone;

  Clientes({
    required this.id,
    required this.nome,
    required this.sexo,
    required this.idade,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.telefone,
  });

  // Método para criar Clientes a partir de um JSON
  factory Clientes.fromJson(Map<String, dynamic> json) =>
      _$ClientesFromJson(json);

  Map<String, dynamic> toJson() => _$ClientesToJson(this);

  factory Clientes.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Clientes(
      id: doc.id,
      nome: data['nome'] ?? '',
      sexo: data['sexo'] ?? '',
      idade: data['idade'] ?? '',
      endereco: data['endereco'] ?? '',
      numero: data['numero'] ?? '',
      bairro: data['bairro'] ?? '',
      cidade: data['cidade'] ?? '',
      telefone: data['telefone'] ?? '',
    );
  }
}
