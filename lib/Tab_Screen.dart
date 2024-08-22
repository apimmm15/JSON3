import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  // ignore: prefer_typing_uninitialized_variables
  // ignore: unused_local_variable
  var bodyText2;
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
      hintColor: Colors.orangeAccent,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black87, fontFamily: 'Montserrat'),
        titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
      ),
      appBarTheme: AppBarTheme(
        color: Colors.deepPurple, toolbarTextStyle: TextTheme(
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        // ignore: prefer_const_constructors
        ).bodyMedium, titleTextStyle: TextTheme(
          titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.white),
        ).titleLarge,
      ),
    ),
    home: TabScreen(),
  ));
}

class TabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('SMK Negeri 4 - Services'),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            BerandaTab(),
            UsersTab(),
            ProfilTab(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.dashboard_rounded), text: 'Dashboard'),
            Tab(icon: Icon(Icons.group_rounded), text: 'Students'),
            Tab(icon: Icon(Icons.account_circle_rounded), text: 'Profile'),
          ],
          labelColor: Colors.orangeAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.deepPurple,
        ),
      ),
    );
  }
}

class BerandaTab extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.school_rounded, 'label': 'Academics', 'color': Colors.blue},
    {'icon': Icons.book_rounded, 'label': 'Library', 'color': Colors.green},
    {'icon': Icons.schedule_rounded, 'label': 'Timetable', 'color': Colors.orange},
    {'icon': Icons.notifications_rounded, 'label': 'Announcements', 'color': Colors.red},
    {'icon': Icons.assignment_rounded, 'label': 'Assignments', 'color': Colors.purple},
    {'icon': Icons.forum_rounded, 'label': 'Forum', 'color': Colors.pink},
    {'icon': Icons.settings_rounded, 'label': 'Settings', 'color': Colors.teal},
    {'icon': Icons.support_agent_rounded, 'label': 'Support', 'color': Colors.cyan},
    {'icon': Icons.map_rounded, 'label': 'Campus Map', 'color': Colors.amber},
    {'icon': Icons.event_rounded, 'label': 'Events', 'color': Colors.lime},
    {'icon': Icons.contact_mail_rounded, 'label': 'Contact Us', 'color': Colors.indigo},
    {'icon': Icons.info_rounded, 'label': 'About', 'color': Colors.deepOrange},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurpleAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row for a more spacious layout
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: () {
                print('${item['label']} tapped');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [item['color'], item['color'].withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'], size: 50.0, color: Colors.white),
                      SizedBox(height: 12.0),
                      Text(
                        item['label'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UsersTab extends StatelessWidget {
  Future<List<User>> fetchUsers() async {
    // Custom list of users
    return [
      User(firstName: 'Siti Aisyah', email: 'Siti.Aisyah@example.com'),
      User(firstName: 'Nadia Nur Alifah', email: 'Nadia.Nur Alifah@example.com'),
      User(firstName: 'Siti Lutfiyah', email: 'Siti.Lutfiyah@example.com'),
      User(firstName: 'Lusi Nuraini', email: 'Lusi.Nurainie@example.com'),
      User(firstName: 'Afril Lestari', email: 'Afril.Lestari@example.com'),
      User(firstName: 'Dewi Sri', email: 'Dewi.Sri@example.com'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurpleAccent,
                      child: Icon(Icons.person_rounded, color: Colors.white),
                    ),
                    title: Text(user.firstName, style: TextStyle(color: Colors.black)),
                    subtitle: Text(user.email, style: TextStyle(color: Colors.black54)),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}


class ProfilTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile_picture.jpg'), // Ganti dengan path gambar profil
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Afril Lestari',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
                color: Colors.deepPurpleAccent),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Email: AfrilLestari@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Biodata',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Colors.deepPurpleAccent),
          ),
          Divider(color: Colors.deepPurpleAccent),
          ListTile(
            leading: Icon(Icons.person_rounded, color: Colors.deepPurpleAccent),
            title: Text('Nama Lengkap'),
            subtitle: Text('Afril Lestari', style: TextStyle(color: Colors.black87)),
          ),
          ListTile(
            leading: Icon(Icons.cake_rounded, color: Colors.deepPurpleAccent),
            title: Text('Tanggal Lahir'),
            subtitle: Text('15 April 2000', style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}

class User {
  final String firstName;
  final String email;

  User({required this.firstName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      email: json['email'],
    );
  }
}
