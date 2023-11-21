import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomAuthButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text,style: TextStyle(color: Colors.white),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Cor de fundo do botão

        minimumSize: Size(double.infinity, 48.0), // Largura e altura mínimas
        padding: EdgeInsets.symmetric(vertical: 16.0), // Espaçamento interno
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Borda arredondada
        ),
      ),
    );
  }
}
