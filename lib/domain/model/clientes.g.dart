// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clientes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Clientes _$ClientesFromJson(Map<String, dynamic> json) => Clientes(
      id: json['id'] as String,
      nome: json['nome'] as String,
      sexo: json['sexo'] as String,
      idade: json['idade'] as String,
      endereco: json['endereco'] as String,
      numero: json['numero'] as String,
      bairro: json['bairro'] as String,
      cidade: json['cidade'] as String,
      telefone: json['telefone'] as String,
    );

Map<String, dynamic> _$ClientesToJson(Clientes instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'sexo': instance.sexo,
      'idade': instance.idade,
      'endereco': instance.endereco,
      'numero': instance.numero,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'telefone': instance.telefone,
    };
