import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_flutter/app/data/http/http_cliente.dart';
import 'package:qr_code_flutter/app/data/models/repositories/user_repository.dart';
import 'package:qr_code_flutter/app/screens/home/user_store.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserStore store =
      UserStore(repository: UserRepository(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    store.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.error,
          store.state,
        ]),
        builder: (context, child) {
          if(store.isLoading.value){
            return const CircularProgressIndicator();
          }

          if(store.error.value.isNotEmpty){
            return Center(
              child: Text(store.error.value,style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,),
            );
          }else{
            return Container(
              child: store.state.value.sqCode != null ?QrImageView(
                data: store.state.value.sqCode!,
                version: QrVersions.auto,
                size: 200.0,
              ) : Text('NENHUMA QR CODE RECUPERADO'),
            );
          }
        },
      ),
    );
  }
}
