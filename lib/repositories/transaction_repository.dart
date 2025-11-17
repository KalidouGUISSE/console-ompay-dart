import '../interfaces/i_transaction_service.dart';
import '../interfaces/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
    final ITransactionService service;
    TransactionRepository(this.service);

    @override
    Future<Map<String, dynamic>> getAllTransactions() async {
        final result = await service.getAllTransactions();
        return result as Map<String, dynamic>;
    }

    @override
    Future<Map<String, dynamic>> getSolde() async {
        final result = await service.getSolde();
        return result as Map<String, dynamic>;
    }

    @override
    Future<Map<String, dynamic>> creerTransaction(String numero, String montant, String type_transaction) async {
        final result = await service.creerTransaction(numero,montant,type_transaction);
        return result;
    }

    @override
    Future<Map<String, dynamic>> getByIdTransactions(String id) async {
        final result = await service.getByIdTransactions(id);
        return result;
    }
}