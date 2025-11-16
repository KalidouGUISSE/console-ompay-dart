class User {
  final String id;
  final String nom;
  final String prenom;
  final String role;

  User({required this.id, required this.nom, required this.prenom, required this.role});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    nom: json['nom'],
    prenom: json['prenom'],
    role: json['role'],
  );
}
