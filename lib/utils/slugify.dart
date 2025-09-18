
String toSlug(String title) {
  return title
      .toLowerCase()
      // remplace les accents : é → e, ô → o, etc.
      .replaceAll(RegExp(r'[àáâãäå]'), 'a')
      .replaceAll(RegExp(r'[èéêë]'), 'e')
      .replaceAll(RegExp(r'[ìíîï]'), 'i')
      .replaceAll(RegExp(r'[òóôõö]'), 'o')
      .replaceAll(RegExp(r'[ùúûü]'), 'u')
      .replaceAll(RegExp(r'[ç]'), 'c')
      // remplace espaces et underscores par des tirets
      .replaceAll(RegExp(r'[\s_]+'), '-')
      // supprime tout ce qui n’est pas a-z, 0-9 ou -
      .replaceAll(RegExp(r'[^a-z0-9\-]'), '')
      // supprime les tirets en double
      .replaceAll(RegExp(r'-{2,}'), '-')
      // supprime les tirets au début/fin
      .replaceAll(RegExp(r'^-+|-+$'), '');
}
