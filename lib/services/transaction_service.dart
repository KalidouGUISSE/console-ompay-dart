import '../interfaces/i_api_client.dart';
import '../interfaces/i_transaction_service.dart';

class TransactionService implements ITransactionService{
    final IApiClient apiClient;
    TransactionService(this.apiClient);

    @override
    Future<Map<String, dynamic>> getAllTransactions() async {
        final encodedNumero = Uri.encodeComponent(apiClient.numero!);
        return await apiClient.get('/api/v1/compte/$encodedNumero/transactions');
    }

    @override
    Future<Map<String, dynamic>> getSolde() async {
        return await apiClient.get('/api/v1/compte/${apiClient.numero}/solde');
    }

    @override
    Future<Map<String, dynamic>> creerTransaction(String numero, String montant, String type_transaction) async {
        return await apiClient.post('/api/v1/compte/${apiClient.numero}/transactions', 
        {
            'numero du destinataire': numero, 
            'montant': montant, 
            'type_transaction':type_transaction, 
            'date':''
        });
    }

    @override
    Future<Map<String, dynamic>> getByIdTransactions(String id) async {
        return await apiClient.get('/api/v1/transactions/$id');
    }

}