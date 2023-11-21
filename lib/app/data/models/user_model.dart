class UserModel{
  String? nome;
  String? email;
  String? celular;
  String? documento;
  String? token;
  String? senha;
  String? sqCode;
  String? tipoDocumento;





  UserModel({this.nome, this.email, this.celular, this.documento, this.token, this.sqCode, this.senha, this.tipoDocumento});

  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
      nome: map['title'],
      celular: map['celular'],
      documento: map['documento'],
      email: map['email'],
      senha: map['senha'],
      sqCode: map['qrCode'],
      tipoDocumento: map['tipoDocumento'],
      token: map['tonken'],
    );
  }
}