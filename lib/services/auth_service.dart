import '../core/i_api_client.dart';
import './i_auth_service.dart';
import '../utils/validators.dart';
import '../core/exceptions.dart';
import '../models/user.dart';

class AuthService implements IAuthService {
    final IApiClient apiClient;
    AuthService(this.apiClient);

    @override
    Future<Map<String, dynamic>> initiateLogin(String numero) async {
        if (!Validator.isValidPhoneNumber(numero)) {
            throw ValidationException('Numéro de téléphone invalide');
        }
        return await apiClient.post('/api/v1/auth/initiate-login', {'numeroTelephone': numero});
    }

    @override
    Future<Map<String, dynamic>> verifyOtp(String token, String otp) async {
        if (!Validator.isValidOtp(otp)) {
            throw ValidationException('OTP invalide');
        }
        return await apiClient.post('/api/v1/auth/verify-otp', {'token': token, 'otp': otp});
    }

    @override
    Future<Map<String, dynamic>> login(String numero, String pin) async {
        return await apiClient.post('/api/v1/auth/login', {'numeroTelephone': numero, 'pin': pin});
    }

    @override
    Future<Map<String, dynamic>> me() async{
        return await apiClient.get('/api/v1/auth/me') as Map<String, dynamic>;
        // return User.fromJson(response);
    }
}
