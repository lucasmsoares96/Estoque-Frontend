//TODO: Retirar possibilidade de null assigment
// null assigment feito apenas para testes
class User {
  late String name;
  late String email;
  late String? token;
  late String? cpf;
  late String? entryDate;
  late String? userType;
  late bool? isAdmin;
  late String? password;

  User(
      {required this.name,
      required this.email,
      this.token,
      this.cpf,
      this.entryDate,
      this.userType,
      this.isAdmin,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      cpf: json["cpf"],
      name: json["name"],
      token: json["jwt"],
      entryDate: json["entryDate"],
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
      "entryDate": entryDate,
      "userType": userType,
      "email": email,
      "isAdmin": isAdmin,
      "password": password,
    };
  }
}
