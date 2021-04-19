bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);
  // si puede parsear n a numero devuelve true y si no falso.
  return (n == null) ? false : true;
}
