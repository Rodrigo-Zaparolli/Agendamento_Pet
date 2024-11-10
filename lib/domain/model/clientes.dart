import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'clientes.g.dart';

@JsonSerializable()
class Clientes {
  String id;
  String nome;
  String sexo;
  DateTime dtCadastro;
  DateTime nascimento;
  String endereco;
  String numero;
  String bairro;
  String cep;
  String uf;
  String complemento;
  String cidade;
  String telefone;
  String userId;

  Clientes({
    required this.id,
    required this.nome,
    required this.sexo,
    required this.dtCadastro,
    required this.nascimento,
    required this.endereco,
    required this.numero,
    required this.bairro,
    required this.cep,
    required this.uf,
    required this.complemento,
    required this.cidade,
    required this.telefone,
    required this.userId,
  });

  factory Clientes.fromJson(Map<String, dynamic> json) =>
      _$ClientesFromJson(json);

  Map<String, dynamic> toJson() => _$ClientesToJson(this);

  factory Clientes.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Clientes(
      id: doc.id,
      nome: data['nome'] ?? '',
      sexo: data['sexo'] ?? '',
      dtCadastro: data['dtCadastro'] is String
          ? DateTime.parse(data['dtCadastro'])
          : (data['dtCadastro'] as Timestamp).toDate(),
      nascimento: data['nascimento'] is String
          ? DateTime.parse(data['nascimento'])
          : (data['nascimento'] as Timestamp).toDate(),
      endereco: data['endereco'] ?? '',
      numero: data['numero'] ?? '',
      bairro: data['bairro'] ?? '',
      cep: data['cep'] ?? '',
      uf: data['uf'] ?? '',
      complemento: data['complemento'] ?? '',
      cidade: data['cidade'] ?? '',
      telefone: data['telefone'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}
