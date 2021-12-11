//TODO: Retirar possibilidade de null assigment
// null assigment feito apenas para testes
//TODO: Arrumar o birthDay
class User {
  final String name;
  final String email;
  late String? token;
  late String? cpf;
  late String? registerDate;
  late String? userType;
  late bool? isAdmin;
  late String? password;

  User(
      {required this.name,
      required this.email,
      this.token,
      this.cpf,
      this.registerDate,
      this.userType,
      this.isAdmin,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cpf: json["cpf"],
      name: json["name"],
      token: json["token"],
      registerDate: json["birthDay"],
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
      "birthDay": registerDate,
      "userType": userType,
      "email": email,
      "isAdmin": isAdmin,
      "password": password,
    };
  }
}
