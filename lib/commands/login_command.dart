import 'dart:io';
import './i_command.dart';
import '../core/i_api_client.dart';
import '../utils/menu_display.dart';
import '../services/i_auth_service.dart';

class LoginCommand implements ICommand {
  final IAuthService service;

  final IApiClient apiClient;
  final MenuDisplay menuDisplay = MenuDisplay();

  LoginCommand(this.service, this.apiClient);

  @override
  Future<void> execute() async {
    stdout.write("Numéro de téléphone (+221...): ");
    String? numero = stdin.readLineSync();
    if (numero == null || numero.isEmpty) {
      print("Numéro requis");
      return;
    }

    try {
      final result = await service.initiateLogin(numero);
      menuDisplay.showSuccess("Numéro validé");

      // Afficher le code OTP pour les tests
      final otpServeur = result['data']['otp'].toString();
      print("Code OTP : $otpServeur");

      stdout.write("Saisir le code OTP envoyé : ");
      String? otp = stdin.readLineSync();

      if (otp == null || otp.isEmpty) {
        menuDisplay.showError("OTP requis");
        return;
      }

      if (otp != otpServeur) {
        menuDisplay.showError("OTP incorrect");
        return;
      }

      menuDisplay.showSuccess("OTP correct");

      final tempToken = result['data']['temp_token'];
      final resultFinal = await service.verifyOtp(tempToken, otp);
      menuDisplay.showSuccess("Connexion réussie");

      apiClient.setToken(resultFinal['data']['access_token']);
      apiClient.numero = numero;

      final infoCompte = await service.me();
      print(infoCompte);
    } catch (e) {
      menuDisplay.showError("Erreur : $e");
    }
  }
}