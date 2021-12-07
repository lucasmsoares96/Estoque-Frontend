//TODO: Retirar possibilidade de null assigment
// null assigment feito apenas para testes
class User {
  final String name;
  final String email;
  final String token;
  late String? cpf;
  late String? birthDay;
  late String? userType;
  late String? isAdmin;
  late String? password;

  User(
      {required this.name,
      required this.email,
      required this.token,
      this.cpf,
      this.birthDay,
      this.userType,
      this.isAdmin,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cpf: json["cpf"],
      name: json["name"],
      token: json["token"],
      birthDay: json["birthDay"],
      userType: json["userType"],
      email: json["email"],
      isAdmin: json["isAdmin"],
      password: json["password"],
    );
  }
  toMap() {
    return <String, dynamic>{
      "cpf": cpf,
      "name": name,
      "birthDay": birthDay,
      "userType": userType,
      "email": email,
      "isAdmin": isAdmin,
      "password": password,
    };
  }
}
