import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'services/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CVApplication());
}

// =====================================================
// APPLICATION PRINCIPALE
// =====================================================

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

// =====================================================
// PAGE 1 : CONNEXION
// =====================================================

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
    if (identifiant.text.trim() == 'clemence' && motDePasse.text == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
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
            colors: [Color(0xFF174A8B), Color(0xFF448AFF)],
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
                      child: Icon(Icons.person, size: 65, color: Color(0xFF174A8B)),
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
                    const Text('Application de présentation de mon CV', textAlign: TextAlign.center),
                    const SizedBox(height: 30),
                    TextField(
                      controller: identifiant,
                      decoration: InputDecoration(
                        labelText: 'Identifiant',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                          icon: Icon(masquerMotDePasse ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              masquerMotDePasse = !masquerMotDePasse;
                            });
                          },
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('SE CONNECTER', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Bienvenue dans mon espace personnel', style: TextStyle(color: Colors.grey)),
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

// =====================================================
// NAVIGATION PRINCIPALE
// =====================================================

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pageActuelle = 0;

  final List<String> titres = ['Mon CV', 'Ma famille', 'Mes contacts'];

  final List<Widget> pages = const [
    HomePage(),
    FamilyPage(),
    ContactPage(),
  ];

  void changerPage(int index) {
    Navigator.pop(context);
    setState(() {
      pageActuelle = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titres[pageActuelle], style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF174A8B),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF174A8B)),
              accountName: Text('MASIMANGO ZIADA CLEOTINE', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('Étudiante en informatique'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 45, color: Color(0xFF174A8B)),
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
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: pageActuelle,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageActuelle,
        onDestinationSelected: (index) {
          setState(() {
            pageActuelle = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.family_restroom), label: 'Famille'),
          NavigationDestination(icon: Icon(Icons.contact_phone), label: 'Contact'),
        ],
      ),
    );
  }
}

// =====================================================
// PHOTO DE PROFIL
// =====================================================

class PhotoProfil extends StatelessWidget {
  final String chemin;
  final double rayon;

  const PhotoProfil({super.key, required this.chemin, this.rayon = 45});

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
            return Icon(Icons.person, size: rayon * 1.3, color: const Color(0xFF174A8B));
          },
        ),
      ),
    );
  }
}

// =====================================================
// PAGE 2 : MON CV
// =====================================================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget section(String titre, IconData icone, List<String> informations) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
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
                Text(titre, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
              ],
            ),
            const Divider(),
            ...informations.map(
              (info) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• $info', style: const TextStyle(fontSize: 14)),
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
          child: PhotoProfil(chemin: 'assets/images/profil.jpg', rayon: 65),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'MASIMANGO ZIADA CLEOTINE',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Color(0xFF174A8B)),
          ),
        ),
        const Center(
          child: Text('Étudiante en informatique', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Chip(label: Text('ISIG GOMA'), avatar: Icon(Icons.school)),
        ),
        section('À PROPOS DE MOI', Icons.person_outline, [
          'Je suis MASIMANGO ZIADA CLEOTINE.',
          'Je suis étudiante en informatique à ISIG GOMA.',
          'Je m’intéresse aux nouvelles technologies et au numérique.',
        ]),
        section('FORMATION', Icons.school, [
          'Formation : Informatique',
          'Établissement : ISIG GOMA',
          'Année académique : À compléter',
        ]),
        section('EXPÉRIENCES ET PROJETS', Icons.work, [
          'Travaux pratiques en informatique.',
          'Initiation à la programmation.',
          'Réalisation d’une application mobile avec Flutter.',
          'Autres expériences : À compléter.',
        ]),
        section('COMPÉTENCES TECHNIQUES', Icons.computer, [
          'Programmation avec Dart et Flutter.',
          'Programmation en C# et Python.',
          'Utilisation de Visual Studio Code.',
          'Gestion de projets avec Git et GitHub.',
          'Connaissances en informatique générale.',
        ]),
        section('COMPÉTENCES LINGUISTIQUES', Icons.language, [
          'Français : Parlé',
          'Anglais : Parlé',
          'Swahili : Parlé',
          'Lingala : Parlé',
        ]),
        section('CENTRES D’INTÉRÊT', Icons.favorite, [
          'Informatique et nouvelles technologies.',
          'Programmation.',
          'Lecture.',
          'Musique et découverte.',
        ]),
        const SizedBox(height: 20),
      ],
    );
  }
}

// =====================================================
// PAGE 3 : MA FAMILLE
// =====================================================

class FamilyPage extends StatefulWidget {
  const FamilyPage({super.key});

  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  List<Map<String, dynamic>> membres = [];
  bool chargement = true;

  @override
  void initState() {
    super.initState();
    chargerMembres();
  }

  Future<void> chargerMembres() async {
    if (!mounted) return;
    setState(() => chargement = true);

    try {
      final resultat = await ApiService.afficherFamille();
      if (!mounted) return;
      setState(() {
        membres = List<Map<String, dynamic>>.from(resultat['data'] ?? []);
        chargement = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => chargement = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de chargement : $e')),
      );
    }
  }

  Future<void> ouvrirFormulaire({Map<String, dynamic>? membre}) async {
    final donnees = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return FamilyMemberDialog(membre: membre);
      },
    );

    // Délai pour laisser le dialogue se fermer
    await Future.delayed(const Duration(milliseconds: 300));

    if (donnees == null || !mounted) return;

    try {
      if (membre == null) {
        await ApiService.ajouterMembre(donnees);
      } else {
        final id = int.parse(membre['id'].toString());
        await ApiService.modifierMembre(id, donnees);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(membre == null ? 'Membre ajouté avec succès' : 'Membre modifié avec succès'),
        ),
      );

      await chargerMembres();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  Future<void> supprimerMembre(Map<String, dynamic> membre) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Voulez-vous supprimer ${membre['nom']} ${membre['prenom']} ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmation != true || !mounted) return;

    try {
      final id = int.parse(membre['id'].toString());
      await ApiService.supprimerMembre(id);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Membre supprimé avec succès')),
      );

      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      await chargerMembres();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: chargement
              ? const Center(child: CircularProgressIndicator())
              : membres.isEmpty
                  ? const Center(child: Text('Aucun membre enregistré.'))
                  : RefreshIndicator(
                      onRefresh: chargerMembres,
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 90),
                        itemCount: membres.length,
                        itemBuilder: (context, index) {
                          final membre = membres[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: membre['photo'] != null &&
                                        membre['photo'].toString().isNotEmpty
                                    ? (membre['photo'].toString().startsWith('http')
                                        ? NetworkImage(membre['photo'])
                                        : FileImage(File(membre['photo'])) as ImageProvider)
                                    : null,
                                child: membre['photo'] == null || membre['photo'].toString().isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Text('${membre['nom']} ${membre['postnom']} ${membre['prenom']}'),
                              subtitle: Text(
                                'Lien : ${membre['parente']}\n'
                                'Naissance : ${membre['date_naissance']}\n'
                                'Lieu : ${membre['lieu_naissance']}',
                              ),
                              isThreeLine: true,
                              trailing: PopupMenuButton<String>(
                                onSelected: (choix) {
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    if (!mounted) return;
                                    if (choix == 'modifier') {
                                      ouvrirFormulaire(membre: membre);
                                    } else if (choix == 'supprimer') {
                                      supprimerMembre(membre);
                                    }
                                  });
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem(
                                    value: 'modifier',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 8),
                                        Text('Modifier'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'supprimer',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Supprimer'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: () => ouvrirFormulaire(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

// =====================================================
// FORMULAIRE INDEPENDANT : AJOUT ET MODIFICATION
// =====================================================

class FamilyMemberDialog extends StatefulWidget {
  final Map<String, dynamic>? membre;

  const FamilyMemberDialog({super.key, this.membre});

  @override
  State<FamilyMemberDialog> createState() => _FamilyMemberDialogState();
}

class _FamilyMemberDialogState extends State<FamilyMemberDialog> {
  final formulaireKey = GlobalKey<FormState>();

  late String nom;
  late String postnom;
  late String prenom;
  late String lieu;
  late String date;
  late String parente;
  String? cheminPhoto;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final membre = widget.membre;
    nom = membre?['nom']?.toString() ?? '';
    postnom = membre?['postnom']?.toString() ?? '';
    prenom = membre?['prenom']?.toString() ?? '';
    lieu = membre?['lieu_naissance']?.toString() ?? '';
    date = membre?['date_naissance']?.toString() ?? '';
    parente = membre?['parente']?.toString() ?? '';
    cheminPhoto = membre?['photo']?.toString();
  }

  Future<void> _choisirImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        cheminPhoto = image.path;
      });
    }
  }

  String? verifierChamp(String? valeur) {
    if (valeur == null || valeur.trim().isEmpty) return 'Champ obligatoire';
    return null;
  }

  String? verifierDate(String? valeur) {
    if (valeur == null || valeur.trim().isEmpty) return 'Champ obligatoire';
    final dateSaisie = valeur.trim();
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(dateSaisie)) {
      return 'Format attendu : AAAA-MM-JJ';
    }
    return null;
  }

  void _sauvegarder() {
    if (formulaireKey.currentState!.validate()) {
      formulaireKey.currentState!.save();
      final donnees = <String, dynamic>{
        'nom': nom.trim(),
        'postnom': postnom.trim(),
        'prenom': prenom.trim(),
        'lieu_naissance': lieu.trim(),
        'date_naissance': date.trim(),
        'parente': parente.trim(),
        'photo': cheminPhoto,
      };
      Navigator.pop(context, donnees);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.membre == null ? 'Ajouter un membre' : 'Modifier un membre'),
      content: SingleChildScrollView(
        child: Form(
          key: formulaireKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _choisirImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: cheminPhoto != null && cheminPhoto!.isNotEmpty
                      ? (cheminPhoto!.startsWith('http')
                          ? NetworkImage(cheminPhoto!)
                          : FileImage(File(cheminPhoto!)) as ImageProvider)
                      : null,
                  child: cheminPhoto == null || cheminPhoto!.isEmpty
                      ? const Icon(Icons.camera_alt, size: 30, color: Colors.grey)
                      : null,
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: nom,
                decoration: const InputDecoration(labelText: 'Nom', prefixIcon: Icon(Icons.person)),
                validator: verifierChamp,
                onSaved: (value) => nom = value ?? '',
              ),
              TextFormField(
                initialValue: postnom,
                decoration: const InputDecoration(labelText: 'Postnom', prefixIcon: Icon(Icons.person_outline)),
                validator: verifierChamp,
                onSaved: (value) => postnom = value ?? '',
              ),
              TextFormField(
                initialValue: prenom,
                decoration: const InputDecoration(labelText: 'Prénom', prefixIcon: Icon(Icons.person)),
                validator: verifierChamp,
                onSaved: (value) => prenom = value ?? '',
              ),
              TextFormField(
                initialValue: lieu,
                decoration: const InputDecoration(labelText: 'Lieu de naissance', prefixIcon: Icon(Icons.location_on)),
                validator: verifierChamp,
                onSaved: (value) => lieu = value ?? '',
              ),
              TextFormField(
                initialValue: date,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                  hintText: '2000-05-15',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: verifierDate,
                onSaved: (value) => date = value ?? '',
              ),
              TextFormField(
                initialValue: parente,
                decoration: const InputDecoration(
                  labelText: 'Lien de parenté',
                  hintText: 'Père, mère...',
                  prefixIcon: Icon(Icons.family_restroom),
                ),
                validator: verifierChamp,
                onSaved: (value) => parente = value ?? '',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _sauvegarder,
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}

// =====================================================
// PAGE 4 : MES CONTACTS
// =====================================================

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> ouvrirLien(String lien) async {
    final uri = Uri.parse(lien);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Erreur ouverture du lien : $e');
    }
  }

  Widget contact(IconData icone, String titre, String valeur, VoidCallback? action) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        leading: Icon(icone, color: const Color(0xFF174A8B), size: 30),
        title: Text(titre, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(valeur),
        trailing: action != null ? const Icon(Icons.open_in_new) : null,
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
        const Icon(Icons.contact_mail, size: 75, color: Color(0xFF174A8B)),
        const Text(
          'MES COORDONNÉES',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xFF174A8B)),
        ),
        const SizedBox(height: 10),
        const Text('Vous pouvez me contacter à travers les coordonnées suivantes.', textAlign: TextAlign.center),
        const SizedBox(height: 20),
        contact(Icons.phone, 'Téléphone', '0982283890', () => ouvrirLien('tel:0982283890')),
        contact(Icons.email, 'Adresse e-mail', 'clemencemasimango912@gmail.com',
            () => ouvrirLien('mailto:clemencemasimango912@gmail.com')),
        contact(Icons.location_on, 'Adresse', 'Goma, République démocratique du Congo', null),
        contact(Icons.code, 'GitHub', 'Votre profil GitHub', () => ouvrirLien('https://github.com/')),
        contact(Icons.work, 'LinkedIn', 'Votre profil LinkedIn', () => ouvrirLien('https://www.linkedin.com/')),
        const SizedBox(height: 20),
        const Center(
          child: Text('© 2026 - MASIMANGO ZIADA LEONTINE', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}