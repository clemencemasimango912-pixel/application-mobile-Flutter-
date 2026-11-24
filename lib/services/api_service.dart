
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://api-test.test';

  // Envoyer une requête et lire la réponse JSON
  static Future<Map<String, dynamic>> envoyerRequete(
    String methode,
    String route, {
    Map<String, dynamic>? donnees,
  }) async {
    final uri = Uri.parse('$baseUrl$route');

    http.Response reponse;

    switch (methode) {
      case 'GET':
        reponse = await http.get(uri);
        break;
      case 'POST':
        reponse = await http.post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(donnees),
        );
        break;
      case 'PUT':
        reponse = await http.put(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(donnees),
        );
        break;
      case 'DELETE':
        reponse = await http.delete(uri);
        break;
      default:
        throw Exception('Méthode HTTP inconnue');
    }

    final resultat = jsonDecode(reponse.body);

    if (reponse.statusCode >= 200 &&
        reponse.statusCode < 300) {
      return Map<String, dynamic>.from(resultat);
    }

    throw Exception(
      resultat['message'] ?? 'Erreur du serveur',
    );
  }

  // Inscription
  static Future<Map<String, dynamic>> inscrire(
    String email,
    String password,
  ) {
    return envoyerRequete(
      'POST',
      '/accounts/register',
      donnees: {
        'email': email,
        'password': password,
      },
    );
  }

  // Connexion
  static Future<Map<String, dynamic>> connecter(
    String email,
    String password,
  ) {
    return envoyerRequete(
      'POST',
      '/accounts/login',
      donnees: {
        'email': email,
        'password': password,
      },
    );
  }

  // Afficher les membres
  static Future<Map<String, dynamic>> afficherFamille() {
    return envoyerRequete('GET', '/famille-membres');
  }

  // Ajouter un membre
  static Future<Map<String, dynamic>> ajouterMembre(
    Map<String, dynamic> membre,
  ) {
    return envoyerRequete(
      'POST',
      '/famille-membres',
      donnees: membre,
    );
  }

  // Modifier un membre
  static Future<Map<String, dynamic>> modifierMembre(
    int id,
    Map<String, dynamic> membre,
  ) {
    return envoyerRequete(
      'PUT',
      '/famille-membres/$id',
      donnees: membre,
    );
  }

  // Supprimer un membre
  static Future<Map<String, dynamic>> supprimerMembre(
    int id,
  ) {
    return envoyerRequete(
      'DELETE',
      '/famille-membres/$id',
    );
  }
}
