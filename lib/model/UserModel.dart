
class User {
    int idUser=0;
    String lastName ='';
    String firstName ='';
    String email ='';
    String numTel ='';
    String password='';
    User (this.lastName,this.firstName,this.email,this.numTel,this.password);
    int get IdUser => idUser;
    String get LastName => lastName;
    String get FirstName => firstName;
    String get Email => email;
    String get NumTel => numTel;




    User.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    idUser =json["idUser"];
    lastName = json['lastName'];
    firstName = json['firstName'];
    numTel = json['numTel'];
    email = json['email'];
    password= json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'lastName': lastName,
      'firstName': firstName,
      'email': email,
      'numTel': numTel,
      'password': password,
    };
  }


}