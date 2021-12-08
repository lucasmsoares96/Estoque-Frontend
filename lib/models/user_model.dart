//TODO: Retirar possibilidade de null assigment
// null assigment feito apenas para testes
//TODO: Arrumar o birthDay
class User {
  final String name;
  final String email;
  late String? token;
  late String? cpf;
  String birthDay;
  late String? userType;
  late bool? isAdmin;
  late String? password;

  User(
      {required this.name,
      required this.email,
      this.token,
      this.cpf,
      this.birthDay = '1999-01-01',
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
