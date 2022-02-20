
class Child {
  
  int idChild = null;

  String firstName = null;

  String lastName = null;

  int age = null;

  DateTime dateNais = null;

  Child();

  @override
  String toString() {
    return 'Child[idChild=$idChild, firstName=$firstName, lastName=$lastName, age=$age, dateNais=$dateNais, ]';
  }

  Child.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    idChild = json['idChild'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    dateNais = json['dateNais'] == null ? null : DateTime.parse(json['dateNais']);
  }

  Map<String, dynamic> toJson() {
    return {
      'idChild': idChild,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'dateNais': dateNais == null ? '' : dateNais.toUtc().toIso8601String()
     };
  }

  static List<Child> listFromJson(List<dynamic> json) {
    return json == null ? new List<Child>() : json.map((value) => new Child.fromJson(value)).toList();
  }

  static Map<String, Child> mapFromJson(Map<String, Map<String, dynamic>> json) {
    var map = new Map<String, Child>();
    if (json != null && json.length > 0) {
      json.forEach((String key, Map<String, dynamic> value) => map[key] = new Child.fromJson(value));
    }
    return map;
  }
}
