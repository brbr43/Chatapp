class Masseg {
  final String masseges;
  final String id;
  Masseg(this.masseges, this.id);

  factory Masseg.fromjason(jasondata) {
    return Masseg(jasondata['masseges'], jasondata['id']);
  }
}
