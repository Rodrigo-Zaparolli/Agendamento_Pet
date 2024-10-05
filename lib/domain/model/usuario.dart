import 'package:json_annotation/json_annotation.dart';
part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  final String id;
  final String name;
  final String email;
  final String? photoURL;
  final String? cpf;
  final String? birthDate;
  final String? phone;
  final String? cep;
  final String? state;
  final String? city;

  Usuario({
    required this.id,
    required this.name,
    required this.email,
    this.photoURL,
    this.cpf,
    this.birthDate,
    this.phone,
    this.cep,
    this.state,
    this.city,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
