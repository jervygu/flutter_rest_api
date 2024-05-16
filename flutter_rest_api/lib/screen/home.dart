import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Rest API Call'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (
            context,
            index,
          ) {
            final user = users[index];
            final email = user['email'];
            final firstName = user['name']['first'];
            final lastName = user['name']['last'];
            final imageUrl = user['picture']['large'];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(imageUrl),
              ), // Text('${index + 1}')
              title: Text(firstName + ' ' + lastName),
              subtitle: Text('✉' + ' ' + email), 
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async {
    print('Fetch users');
    const url = 'https://randomuser.me/api/?results=100&seed=xyz';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });

    print('users: $users');
    print('Fetch users completed');
  }
}
