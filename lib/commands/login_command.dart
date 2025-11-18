import 'dart:io';
import './i_command.dart';
import '../core/i_api_client.dart';
import '../core/constants.dart';
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
      Messages.showError(Messages.requiredField);
      return;
    }

    try {
      final result = await service.initiateLogin(numero);
      Messages.showSuccess("Numéro validé");

      // Afficher le code OTP pour les tests
      final otpServeur = result['data']['otp'].toString();
      print(Messages.otpDisplay(otpServeur));

      stdout.write("Saisir le code OTP envoyé : ");
      String? otp = stdin.readLineSync();

      if (otp == null || otp.isEmpty) {
        Messages.showError("OTP requis");
        return;
      }

      if (otp != otpServeur) {
        Messages.showError("OTP incorrect");
        return;
      }

      menuDisplay.showSuccess("OTP correct");

      final tempToken = result['data']['temp_token'];
      final resultFinal = await service.verifyOtp(tempToken, otp);
      menuDisplay.showSuccess("Connexion réussie");

      apiClient.setToken(resultFinal['data']['access_token']);
      apiClient.numero = numero;

      final meResponse = await service.me();
      if (meResponse.isValid() && meResponse.data != null) {
        Messages.showSuccess("Informations du compte récupérées");
        print("👤 Utilisateur: ${meResponse.data!.user.nom} ${meResponse.data!.user.prenom}");
        print("🏦 Compte: ${meResponse.data!.compte.numeroCompte}");
        print("💰 Solde: ${meResponse.data!.compte.statut}");
        print("📄 Dernières transactions: ${meResponse.data!.dernieresTransactions.length}");
      } else {
        Messages.showError("Impossible de récupérer les informations du compte");
      }
    } catch (e) {
      menuDisplay.showError("Erreur : $e");
    }
  }
}