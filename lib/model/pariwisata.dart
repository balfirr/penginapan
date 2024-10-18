class Pariwisata {
  int? id;
  String? accomodation;
  String? room;
  int? rate;
  Pariwisata({this.id, this.accomodation, this.room, this.rate});
  factory Pariwisata.fromJson(Map<String, dynamic> obj) {
    return Pariwisata(
        id: obj['id'],
        accomodation: obj['accomodation'],
        room: obj['room'],
        rate: obj['rate']);
  }
}
