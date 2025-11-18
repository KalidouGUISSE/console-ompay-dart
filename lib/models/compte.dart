class Compte {
    final String id;               // UUID
    final String numeroCompte;
    final String? numeroTelephone;
    final String type;             // simple | marchand
    final String statut;           // actif | bloque | ferme
    final DateTime dateCreation;
    final Map<String, dynamic>? metadata;
    final String? codeQr;

    Compte({
        required this.id,
        required this.numeroCompte,
        this.numeroTelephone,
        required this.type,
        required this.statut,
        required this.dateCreation,
        this.metadata,
        this.codeQr,
    });

    factory Compte.fromJson(Map<String, dynamic> json) {
        return Compte(
        id: json['id'],
        numeroCompte: json['numeroCompte'],
        numeroTelephone: json['numeroTelephone'],
        type: json['type'],
        statut: json['statut'],
        dateCreation: DateTime.parse(json['dateCreation']),
        metadata: json['metadata'],
        codeQr: json['code_qr'],
        );
    }

    Map<String, dynamic> toJson() {
        return {
        'id': id,
        'numeroCompte': numeroCompte,
        'numeroTelephone': numeroTelephone,
        'type': type,
        'statut': statut,
        'dateCreation': dateCreation.toIso8601String(),
        'metadata': metadata,
        'code_qr': codeQr,
        };
    }
}
