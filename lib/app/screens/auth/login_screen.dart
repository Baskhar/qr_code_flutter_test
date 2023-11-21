import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_flutter/app/data/http/http_cliente.dart';
import 'package:qr_code_flutter/app/data/models/repositories/user_repository.dart';
import 'package:qr_code_flutter/app/screens/auth/widgets/custom_auth_button.dart';
import 'package:qr_code_flutter/app/screens/auth/widgets/custom_text_form_field.dart';
import 'package:qr_code_flutter/app/screens/home/user_store.dart';
import 'package:provider/provider.dart';

import '../../models/auth_provider.dart'; // Importe o pacote provider

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserStore store =
  UserStore(repository: UserRepository(client: HttpClient()));
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: _emailController,
                validateText: 'Email Obrigatório',
                fieldName: 'Informe seu Email',
              ),
              CustomTextFormField(
                controller: _senhaController,
                validateText: 'Senha Obrigatória',
                fieldName: 'Informe sua senha',
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                child: Text('Não possui cadastro'),
              ),
              CustomAuthButton(
                onPressed: () {
                  _submitForm(context); // Adicione o contexto ao método
                },
                text: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      store.isLoading.value = true;
      try {
        // Chame a função loginUser da UserStore
        await store.loginUser(
          email: _emailController.text,
          senha: _senhaController.text,
        );
        Provider.of<AuthProvider>(context, listen: false).setToken(store.state.value.token);
        // Aqui você pode adicionar a navegação para a próxima tela ou realizar outras ações após o login bem-sucedido
        // Exemplo: Navigator.of(context).pushNamed('/home');
      } catch (e) {
        // Trate os erros aqui
        print('Erro durante o login: $e');
        // Exemplo: Exibir uma mensagem de erro para o usuário
        // store.error.value = 'Erro durante o login: $e';
      } finally {
        store.isLoading.value = false;
      }
    }
  }
}
