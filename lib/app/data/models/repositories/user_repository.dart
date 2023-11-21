import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:qr_code_flutter/app/data/http/http_cliente.dart';

import '../../../models/auth_provider.dart';
import '../../http/exeptions.dart';
import '../user_model.dart';

abstract class IUserRepository {
  Future<UserModel> getUser();
  Future<UserModel> registerUser({
    required String nome,
    required String email,
    required String celular,
    required String tipoDocumento,
    required String documento,
    required String senha,
  });
  Future<UserModel> loginUser({
    required String email,
    required String senha,
  });
}

class UserRepository implements IUserRepository {
final IHttpClient client;
 String? token; // Adicione este campo para armazenar o token

UserRepository({required this.client,  this.token});

@override
Future<UserModel> getUser() async {
  final response = await client.get(url: 'url dos usuários', token: token);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    final UserModel user = UserModel.fromMap(body);
    return user;
  } else {
    throw NotFoundExeption(message: 'Erro ao obter usuário. Status code: ${response.statusCode}');
  }
}

  @override
  Future<UserModel> registerUser({
    required String nome,
    required String email,
    required String celular,
    required String tipoDocumento,
    required String documento,
    required String senha,
  }) async {
    final url = 'sua_url_de_registro_aqui';
    final body = {
      'nome': nome,
      'email': email,
      'celular': celular,
      'tipoDocumento': tipoDocumento,
      'documento': documento,
      'senha': senha,
    };

    final response = await client.post(url: url, body: body);

    if (response.statusCode == 200) {
      final user = UserModel.fromMap(jsonDecode(response.body));
      return user;
    } else {
      // Trate o caso em que o status code não é igual a 200
      throw NotFoundExeption(message: 'Erro durante o registro. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<UserModel> loginUser({
    required String email,
    required String senha,
  }) async {
    final url = 'sua_url_de_login_aqui';
    final body = {
      'email': email,
      'senha': senha,
    };

    final response = await client.post(url: url, body: body);

    if (response.statusCode == 200) {
      final user = UserModel.fromMap(jsonDecode(response.body));

      return user;
    } else {
      // Trate o caso em que o status code não é igual a 200
      throw NotFoundExeption(message: 'Erro durante o login. Status code: ${response.statusCode}');
    }
  }
}
