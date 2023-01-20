class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String defaultImageUrl;
  final String shinyImageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.defaultImageUrl,
    required this.shinyImageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    List<String> typeToList(dynamic types) {
      List<String> ret = [];
      for(int i=0; i<types.length; i++) {
        ret.add(types[i]['type']['name']);
      }
      return ret;
    }

    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: typeToList(json['types']),
      defaultImageUrl: json['sprites']['other']['official-artwork']['front_default'],
      shinyImageUrl: json['sprites']['other']['official-artwork']['front_shiny'],
    );
  }
}