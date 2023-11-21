import 'package:flutter/material.dart';
import 'package:qr_code_flutter/app/screens/auth/widgets/custom_auth_button.dart';
import 'package:qr_code_flutter/app/screens/auth/widgets/custom_text_form_field.dart';

import '../../data/http/http_cliente.dart';
import '../../data/models/repositories/user_repository.dart';
import '../home/user_store.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _celulerController = TextEditingController();
  final _documentoCelular = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedTipoDocumento = 'RG'; // Inicialize com 'RG'

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                controller: _nomeController,
                validateText: 'Nome obrigatório',
                fieldName: 'Nome',
              ),
              CustomTextFormField(
                controller: _emailController,
                validateText: 'Email obrigatório',
                fieldName: 'Email',
              ),
              CustomTextFormField(
                controller: _celulerController,
                validateText: 'Celular obrigatório',
                fieldName: 'Celular',
              ),
              Row(
                children: [
                  Checkbox(
                    value: _selectedTipoDocumento == 'RG',
                    onChanged: (value) {
                      setState(() {
                        _selectedTipoDocumento = 'RG';
                      });
                    },
                  ),
                  Text('RG'),
                  Checkbox(
                    value: _selectedTipoDocumento == 'CNH',
                    onChanged: (value) {
                      setState(() {
                        _selectedTipoDocumento = 'CNH';
                      });
                    },
                  ),
                  Text('CNH'),
                ],
              ),
              CustomTextFormField(
                controller: _documentoCelular,
                validateText: 'Documento obrigatório',
                fieldName: 'Documento',
              ),
              CustomTextFormField(
                controller: _senhaController,
                validateText: 'Senha obrigatória',
                fieldName: 'Senha',
                obscureText: true,
              ),
              CustomTextFormField(
                controller: _confirmarSenhaController,
                validateText: 'Confirmação de senha obrigatória',
                fieldName: 'Confirme sua senha',
                obscureText: true,
              ),
              CustomAuthButton(
                onPressed: () {
                  _submitForm();
                },
                text: 'Registrar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    final UserStore store =
    UserStore(repository: UserRepository(client: HttpClient()));
    if (_formKey.currentState?.validate() ?? false) {
      if (_senhaController.text != _confirmarSenhaController.text) {
        // Senhas não coincidem
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('As senhas não coincidem.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // A execução continua apenas se o formulário for válido e as senhas coincidirem
      try {
        // Use o UserRepository para fazer o registro
        final user = await store.repository.registerUser(
          nome: _nomeController.text,
          email: _emailController.text,
          celular: _celulerController.text,
          tipoDocumento: _selectedTipoDocumento,
          documento: _documentoCelular.text,
          senha: _senhaController.text,
        );

        // Aqui você pode adicionar lógica adicional, como navegar para a tela de login
        print('Usuário registrado: ${user.nome}, Email: ${user.email}');
      } catch (e) {
        // Trate os erros aqui
        print('Erro durante o registro: $e');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro'),
              content: Text('Erro durante o registro: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

}
