import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sagemcom/api/apiclient.dart';
import 'package:sagemcom/pages/AddTesteurscreen.dart';
import 'package:sagemcom/pages/AddUserscreen.dart';
import 'package:sagemcom/pages/EditProfilScreen.dart';
import 'package:sagemcom/pages/EditTesteurscreen.dart';
import 'package:sagemcom/pages/EditUserScreen.dart';
import 'package:sagemcom/pages/loginscreen.dart';
import 'package:sagemcom/pages/profilscrenn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int _selectedIndex = 0; // L'index de la page actuellement sélectionnée

  // Liste des pages
  List<Widget> _pages = [
    ProfileScreen(),
    UserScreen(), // Remplacez par le bon widget pour l'écran User
    TesterScreen(), // Remplacez par le bon widget pour l'écran Testeur
  ];

  // Map des AppBars avec des couleurs de fond et texte centré en blanc
  Map<int, AppBar> _appBars = {
    0: AppBar(
      title: Text(
        'Profil',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      centerTitle: true,
    ),
    1: AppBar(
      title: Text(
        'User',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    ),
    2: AppBar(
      title: Text(
        'Testeur',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
      centerTitle: true,
    ),
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Pour fermer la sidebar après le clic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 248),
      appBar: _appBars[_selectedIndex], // Sélection de l'AppBar appropriée
      drawer: SideBar(
        onItemTapped: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  final Function(int) onItemTapped;

  SideBar({required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 8, 59, 100),
            ),
            child: Image.asset("assets/sagem.png", height: 150, width: 400),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profil'),
            onTap: () => onItemTapped(0),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User'),
            onTap: () => onItemTapped(1),
          ),
          ListTile(
            leading: Icon(Icons.engineering),
            title: Text('Testeur'),
            onTap: () => onItemTapped(2),
          ),
          ListTile(
            leading: Icon(Icons.timeline),
            title: Text('Ligne'),
            onTap: () => onItemTapped(2),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => loginscreen()),
                (Route<dynamic> route) => false,
              ); // Fermer la sidebar après le clic
            },
          ),
        ],
      ),
    );
  }
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Map<String, dynamic> users = {};

  @override
  void initState() {
    super.initState();
    fetchAndSetUsers();
  }

  Future<void> fetchAndSetUsers() async {
    final fetchedUsers = await ApiClient.fetchUsers(context);
    setState(() {
      users = fetchedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeUsers = users['active_users'] ?? [];
    final inactiveUsers = users['inactive_users'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: activeUsers.length + inactiveUsers.length,
        itemBuilder: (context, index) {
          final isActive = index < activeUsers.length;
          final user = isActive
              ? activeUsers[index]
              : inactiveUsers[index - activeUsers.length];
          return ListTile(
            title: Text(user['username']),
            subtitle: Text(user['email']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                                email: user["email"],
                                nom: user["username"],
                                prenom: user["username"],
                              )),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    ApiClient.deleteUser(context, user["email"]);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigation vers la page d'ajout d'utilisateur
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserscreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _confirmDeleteUser(BuildContext context, String userName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $userName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Add functionality for delete user
                print('Delete confirmed for $userName');
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class TesterScreen extends StatefulWidget {
  @override
  _TesterScreenState createState() => _TesterScreenState();
}

class _TesterScreenState extends State<TesterScreen> {
  List<dynamic> testeurs = [];

  @override
  void initState() {
    super.initState();
    fetchAndSetTesteurs();
  }

  Future<void> fetchAndSetTesteurs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    if (email != null) {
      final fetchedTesteurs = await ApiClient.fetchTesteurs(context);
      setState(() {
        testeurs = fetchedTesteurs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tester Screen'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: testeurs.length,
        itemBuilder: (context, index) {
          final item = testeurs[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStyledText('Name Testeur: ', item['name']),
                  SizedBox(height: 4.0),
                  _buildStyledText('Username: ', item['username']),
                  SizedBox(height: 4.0),
                  _buildStyledText('Host: ', item['host']),
                  SizedBox(height: 4.0),
                  _buildStyledText('Chemin d\'accès: ', item['chemin']),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditTesteurscreen(
                                  name: item["name"],
                                  username: item["username"],
                                  host: item["host"],
                                  password: item["password"],
                                  path: item["chemin"],
                                  ligne: item["ligne"],
                                  id: item["id"],
                                )),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ApiClient.deleteTesteur(
                          context: context, testeurId: item["id"]);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTesteurscreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildStyledText(String label, String? value) {
    return RichText(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 16.0,
        ),
        children: [
          TextSpan(
            text: value ?? '',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey[700],
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteTesteur(BuildContext context, String testeurName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $testeurName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                print('Delete confirmed for $testeurName');
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
