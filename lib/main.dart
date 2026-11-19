
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CVApplication());
}

class CVApplication extends StatelessWidget {
  const CVApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CV de Clemence',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF174A8B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F7FC),
      ),
      home: const LoginPage(),
    );
  }
}

// ===============================
// PAGE 1 : CONNEXION
// ===============================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final identifiant = TextEditingController();
  final motDePasse = TextEditingController();
  bool masquerMotDePasse = true;

  void seConnecter() {
    if (identifiant.text.trim() == 'clemence' &&
        motDePasse.text == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Identifiant ou mot de passe incorrect !'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    identifiant.dispose();
    motDePasse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF174A8B),
              Color(0xFF448AFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFE3EDFA),
                      child: Icon(
                        Icons.person,
                        size: 65,
                        color: Color(0xFF174A8B),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'BIENVENUE',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF174A8B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Application de présentation de mon CV',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    TextField(
                      controller: identifiant,
                      decoration: InputDecoration(
                        labelText: 'Identifiant',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    TextField(
                      controller: motDePasse,
                      obscureText: masquerMotDePasse,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            masquerMotDePasse
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              masquerMotDePasse =
                                  !masquerMotDePasse;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: seConnecter,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF174A8B),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'SE CONNECTER',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Bienvenue dans mon espace personnel',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===============================
// NAVIGATION PRINCIPALE
// ===============================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageActuelle = 0;

  final List<String> titres = [
    'Mon CV',
    'Ma famille',
    'Mes contacts',
  ];

  final List<Widget> pages = const [
    HomePage(),
    FamilyPage(),
    ContactPage(),
  ];

  void changerPage(int index) {
    setState(() {
      pageActuelle = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titres[pageActuelle],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF174A8B),
        foregroundColor: Colors.white,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF174A8B),
              ),
              accountName: Text(
                'MASIMANGO ZIADA CLEOTINE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('Étudiante en informatique'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 45,
                  color: Color(0xFF174A8B),
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil / Mon CV'),
              onTap: () => changerPage(0),
            ),

            ListTile(
              leading: const Icon(Icons.family_restroom),
              title: const Text('Ma famille'),
              onTap: () => changerPage(1),
            ),

            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Mes contacts'),
              onTap: () => changerPage(2),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Déconnexion'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: pages[pageActuelle],

      bottomNavigationBar: NavigationBar(
        selectedIndex: pageActuelle,
        onDestinationSelected: (index) {
          setState(() {
            pageActuelle = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.family_restroom),
            label: 'Famille',
          ),
          NavigationDestination(
            icon: Icon(Icons.contact_phone),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

// ===============================
// WIDGET PHOTO AVEC IMAGE PAR DEFAUT
// ===============================

class PhotoProfil extends StatelessWidget {
  final String chemin;
  final double rayon;

  const PhotoProfil({
    super.key,
    required this.chemin,
    this.rayon = 45,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: rayon,
      backgroundColor: const Color(0xFFE3EDFA),
      child: ClipOval(
        child: Image.asset(
          chemin,
          width: rayon * 2,
          height: rayon * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.person,
              size: rayon * 1.3,
              color: const Color(0xFF174A8B),
            );
          },
        ),
      ),
    );
  }
}

// ===============================
// PAGE 2 : MON CV
// ===============================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget section(
    String titre,
    IconData icone,
    List<String> informations,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 7,
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icone, color: const Color(0xFF174A8B)),
                const SizedBox(width: 10),
                Text(
                  titre,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
            const Divider(),
            ...informations.map(
              (info) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '• $info',
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),

        const Center(
          child: PhotoProfil(
            chemin: 'assets/images/profil.jpg',
            rayon: 65,
          ),
        ),

        const SizedBox(height: 15),

        const Center(
          child: Text(
            'MASIMANGO ZIADA CLEOTINE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF174A8B),
            ),
          ),
        ),

        const Center(
          child: Text(
            'Étudiante en informatique',
            style: TextStyle(fontSize: 16),
          ),
        ),

        const SizedBox(height: 10),

        const Center(
          child: Chip(
            label: Text('ISIG GOMA'),
            avatar: Icon(Icons.school),
          ),
        ),

        section(
          'À PROPOS DE MOI',
          Icons.person_outline,
          [
            'Je suis MASIMANGO ZIADA CLEOTINE.',
            'Je suis étudiante en informatique à ISIG GOMA.',
            'Je m’intéresse aux nouvelles technologies et au numérique.',
          ],
        ),

        section(
          'FORMATION',
          Icons.school,
          [
            'Formation : Informatique',
            'Établissement : ISIG GOMA',
            'Année académique : À compléter',
          ],
        ),

        section(
          'EXPÉRIENCES ET PROJETS',
          Icons.work,
          [
            'Travaux pratiques en informatique.',
            'Initiation à la programmation.',
            'Réalisation d’une application mobile avec Flutter.',
            'Autres expériences : À compléter.',
          ],
        ),

        section(
          'COMPÉTENCES TECHNIQUES',
          Icons.computer,
          [
            'Programmation avec Dart et Flutter.',
            'Programmation en C# et Python.',
            'Utilisation de Visual Studio Code.',
            'Gestion de projets avec Git et GitHub.',
            'Connaissances en informatique générale.',
          ],
        ),

        
section(
  'COMPÉTENCES LINGUISTIQUES',
  Icons.language,
  [
    'Français : Parlé',
    'Anglais : Parlé',
    'Swahili : Parlé',
    'Lingala : Parlé',
  ],
),


        section(
          'CENTRES D’INTÉRÊT',
          Icons.favorite,
          [
            'Informatique et nouvelles technologies.',
            'Programmation.',
            'Lecture.',
            'Musique et découverte.',
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ===============================
// PAGE 3 : MA FAMILLE
// ===============================

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  static const List<Map<String, String>> membres = [
    {
      'nom': 'Nom du père à compléter',
      'lien': 'Père',
      'profession': 'Profession à compléter',
      'photo': 'assets/images/pere.jpg',
    },
    {
      'nom': 'Nom de la mère à compléter',
      'lien': 'Mère',
      'profession': 'Profession à compléter',
      'photo': 'assets/images/mere.jpg',
    },
    {
      'nom': 'Nom du frère à compléter',
      'lien': 'Frère',
      'profession': 'À compléter',
      'photo': 'assets/images/frere.jpg',
    },
    {
      'nom': 'Nom de la sœur à compléter',
      'lien': 'Sœur',
      'profession': 'À compléter',
      'photo': 'assets/images/soeur.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'PRÉSENTATION DE MA FAMILLE',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF174A8B),
            ),
          ),
        ),

        const Text(
          'Voici les membres de ma famille.',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 15),

        ...membres.map((membre) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: PhotoProfil(
                chemin: membre['photo']!,
                rayon: 30,
              ),
              title: Text(
                membre['nom']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '${membre['lien']}\n${membre['profession']}',
              ),
              isThreeLine: true,
            ),
          );
        }),

        const SizedBox(height: 20),
      ],
    );
  }
}

// ===============================
// PAGE 4 : MES CONTACTS
// ===============================

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> ouvrirLien(String lien) async {
    final uri = Uri.parse(lien);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget contact(
    IconData icone,
    String titre,
    String valeur,
    VoidCallback? action,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        leading: Icon(
          icone,
          color: const Color(0xFF174A8B),
          size: 30,
        ),
        title: Text(
          titre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(valeur),
        trailing: action != null
            ? const Icon(Icons.open_in_new)
            : null,
        onTap: action,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const SizedBox(height: 20),

        const Icon(
          Icons.contact_mail,
          size: 75,
          color: Color(0xFF174A8B),
        ),

        const Text(
          'MES COORDONNÉES',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xFF174A8B),
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Vous pouvez me contacter à travers les coordonnées suivantes.',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),

       contact(
  Icons.phone,
  'Téléphone',
  '0982283890',
  () => ouvrirLien('tel:0982283890'),
),

contact(
  Icons.email,
  'Adresse e-mail',
  'clemencemasimango912@gmail.com',
  () => ouvrirLien(
    'mailto:clemencemasimango912@gmail.com',
  ),
),

        contact(
          Icons.location_on,
          'Adresse',
          'Goma, République démocratique du Congo',
          null,
        ),

        contact(
          Icons.code,
          'GitHub',
          'Votre profil GitHub',
          () => ouvrirLien('https://github.com/'),
        ),

        contact(
          Icons.work,
          'LinkedIn',
          'Votre profil LinkedIn',
          () => ouvrirLien('https://www.linkedin.com/'),
        ),

        const SizedBox(height: 20),

        const Center(
          child: Text(
            '© 2026 - MASIMANGO ZIADA CLEOTINE',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
