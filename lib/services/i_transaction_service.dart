abstract class ITransactionService {
    Future<Map<String, dynamic>> getAllTransactions();
    Future<Map<String, dynamic>> getByIdTransactions(String id);
    Future<Map<String, dynamic>> getSolde();
    Future<Map<String, dynamic>> creerTransaction(String numero, String montant, String type_transaction);
    Future<Map<String, dynamic>> getTransactionsAndSolde();
}