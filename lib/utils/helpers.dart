import 'dart:io';

void afficherMenuAuth() {
    print('\n=== MENU PRINCIPAL ===');
    print('1. Initier la connexion avec OTP');
    print('2. Valider votre code otp');
    print('0. Quitter');
    stdout.write('Votre choix : ');
}

bool switchCase(String? choice, [bool quitter = false] ){
    switch (choice) {
        case '1':
            print('👉 Endpoint: /api/v1/auth/initiate-login ');
            // Appelle ici ta fonction addUser()
            break;

        case '2':
            print('👉 Endpoint: /api/v1/auth/verify-otp et retourn Endpoint: /api/v1/auth/me' );
            // Appelle ici ta fonction listUsers()
            break;

        case '0':
            print('👋 Au revoir !');
            return true;

        default:
            print('❌ Choix invalide, réessayez.');
    }
    return false;
}