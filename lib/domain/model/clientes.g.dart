// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clientes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clientes _$ClientesFromJson(Map<String, dynamic> json) => Clientes(
      id: json['id'] as String,
      nome: json['nome'] as String,
      sexo: json['sexo'] as String,
      dtCadastro: DateTime.parse(json['dtCadastro'] as String),
      nascimento: DateTime.parse(json['nascimento'] as String),
      endereco: json['endereco'] as String,
      email: json['email'] as String,
      numero: json['numero'] as String,
      bairro: json['bairro'] as String,
      cep: json['cep'] as String,
      uf: json['uf'] as String,
      complemento: json['complemento'] as String,
      cidade: json['cidade'] as String,
      telefone: json['telefone'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$ClientesToJson(Clientes instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'sexo': instance.sexo,
      'dtCadastro': instance.dtCadastro.toIso8601String(),
      'nascimento': instance.nascimento.toIso8601String(),
      'endereco': instance.endereco,
      'email': instance.email,
      'numero': instance.numero,
      'bairro': instance.bairro,
      'cep': instance.cep,
      'uf': instance.uf,
      'complemento': instance.complemento,
      'cidade': instance.cidade,
      'telefone': instance.telefone,
      'userId': instance.userId,
    };
