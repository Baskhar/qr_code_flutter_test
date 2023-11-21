import 'package:flutter/cupertino.dart';
import 'package:qr_code_flutter/app/data/http/exeptions.dart';
import 'package:qr_code_flutter/app/data/models/repositories/user_repository.dart';
import 'package:qr_code_flutter/app/data/models/user_model.dart';

class UserStore {
  final IUserRepository repository;
  UserStore({required this.repository});

  // Variável reativa para os isLoading
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // Variável reativa para o state
  final ValueNotifier<UserModel> state = ValueNotifier(UserModel());

  // Variável reativa para o error
  final ValueNotifier<String> error = ValueNotifier('');

  Future getUser() async {
    isLoading.value = true;
    try {
      final result = await repository.getUser();
      state.value = result;
    } on NotFoundExeption catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  Future registerUser({
    required String nome,
    required String email,
    required String celular,
    required String tipoDocumento,
    required String documento,
    required String senha,
  }) async {
    isLoading.value = true;
    try {
      final result = await repository.registerUser(
        nome: nome,
        email: email,
        celular: celular,
        tipoDocumento: tipoDocumento,
        documento: documento,
        senha: senha,
      );
      state.value = result;
    } on NotFoundExeption catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }

  Future loginUser({
    required String email,
    required String senha,
  }) async {
    isLoading.value = true;
    try {
      final result = await repository.loginUser(
        email: email,
        senha: senha,
      );

      // Adicione aqui a lógica para armazenar o token no AuthProvider
      // Obtém a instância do AuthProvider e seta o token

      // final AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
      // authProvider.setToken(result.token);

      state.value = result;
    } on NotFoundExeption catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
