class Transaction {
    final String id;                    // UUID
    final String typeTransaction;       // retrait, depot, transfert...
    final String expediteur;            // numeroCompte sender
    final String destinataire;          // numeroCompte receiver
    final double montant;
    final DateTime date;
    final String reference;
    final Map<String, dynamic>? metadata;

    Transaction({
        required this.id,
        required this.typeTransaction,
        required this.expediteur,
        required this.destinataire,
        required this.montant,
        required this.date,
        required this.reference,
        this.metadata,
    });

    factory Transaction.fromJson(Map<String, dynamic> json) {
        return Transaction(
        id: json['id'],
        typeTransaction: json['type_transaction'],
        expediteur: json['expediteur'],
        destinataire: json['destinataire'],
        montant: double.tryParse(json['montant'].toString()) ?? 0.0,
        date: DateTime.parse(json['date']),
        reference: json['reference'] ?? '',
        metadata: json['metadata'],
        );
    }

    Map<String, dynamic> toJson() {
        return {
        'id': id,
        'type_transaction': typeTransaction,
        'expediteur': expediteur,
        'destinataire': destinataire,
        'montant': montant,
        'date': date.toIso8601String(),
        'reference': reference,
        'metadata': metadata,
        };
    }
}
