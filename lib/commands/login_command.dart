import 'dart:io';
import '../interfaces/i_command.dart';
import '../interfaces/i_auth_repository.dart';
import '../interfaces/i_api_client.dart';

class LoginCommand implements ICommand {
  final IAuthRepository authRepository;
  final IApiClient apiClient;

  LoginCommand(this.authRepository, this.apiClient);

  @override
  Future<void> execute() async {
    stdout.write("Numéro de téléphone (+221...): ");
    String? numero = stdin.readLineSync();
    if (numero == null || numero.isEmpty) return;

    try {
      final result = await authRepository.initiateLogin(numero);
      final otpsend = result['data']['otp'];
      print("Numéro validé : $otpsend");

      stdout.write("Saisir le code OTP envoyé : ");
      String? otp = stdin.readLineSync();

      if (otp == null || otp.isEmpty) {
        print("OTP invalide");
        return;
      }

      final otpServeur = result['data']['otp'].toString();
      if (otp != otpServeur) {
        print("OTP incorrect");
        return;
      }

      print("OTP correct");

      final tempToken = result['data']['temp_token'];
      final resultFinal = await authRepository.loginWithOtp(tempToken, otp);
      print("Connexion réussie");

      apiClient.token = resultFinal['data']['access_token'];
      apiClient.numero = numero;

      final infoCompte = await authRepository.me();
      print(infoCompte);
    } catch (e) {
      print("Erreur API : $e");
      // print("Numero invalide: $e");
    }
  }
}