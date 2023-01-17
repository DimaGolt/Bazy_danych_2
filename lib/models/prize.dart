class Prize {
  int? filmId;
  int? personId;
  String name;
  String dateOfSuccess;
  String? filmName;

  Prize(this.name, this.dateOfSuccess,
      {this.filmId, this.personId, this.filmName})
      : assert(filmId != null || personId != null);
}
