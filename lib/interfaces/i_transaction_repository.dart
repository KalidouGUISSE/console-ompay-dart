abstract class ITransactionRepository {
    Future<Map> getAllTransactions();
    Future<Map<String, dynamic>> getByIdTransactions(String id);
    Future<Map<String, dynamic>> getSolde();
    Future<Map<String, dynamic>> creerTransaction(String numero, String montant, String type_transaction);
}