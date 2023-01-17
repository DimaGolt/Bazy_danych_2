class Person {
  int id;
  String role;
  String name;
  String surname;
  String dateOfBirth;
  String? dateOfDeath;
  String homeCountry;

  Person(this.id, this.role, this.name, this.surname, this.dateOfBirth,
      this.homeCountry,
      {this.dateOfDeath});
}
