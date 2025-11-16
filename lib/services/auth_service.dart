import '../core/api_client.dart';

class AuthService {
    final ApiClient apiClient;
    AuthService(this.apiClient);

    Future<Map<String, dynamic>> initiateLogin(String numero) async {
        return await apiClient.post('/api/v1/auth/initiate-login', {'numeroTelephone': numero});
    }

    Future<Map<String, dynamic>> verifyOtp(String token, String otp) async {
        return await apiClient.post('/api/v1/auth/verify-otp', {'token': token, 'otp': otp});
    }

    Future<Map<String, dynamic>> login(String numero, String pin) async {
        return await apiClient.post('/api/v1/auth/login', {'numeroTelephone': numero, 'pin': pin});
    }

    Future<Map<String,dynamic>> me() async{
        return await apiClient.get('/api/v1/auth/me');
    }
}
