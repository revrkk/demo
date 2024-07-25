import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(DemoApp());
}

class DemoApp extends StatelessWidget {
  // Tetstedrsdggdf
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginWidget(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.light()),
      darkTheme: ThemeData(colorScheme: ColorScheme.dark()),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 38,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Username",
                style: TextStyle(color: Colors.blueGrey),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  this.username = value;
                },
              ),
              SizedBox(height: 30),
              Text(
                "Password",
                style: TextStyle(color: Colors.blueGrey),
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  this.password = value;
                },
              ),
              SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("Login button clicked $username and $password");
                    print("Login button clicked 2");
                  },
                  // style: ButtonStyle(
                  //   foregroundColor: WidgetStatePropertyAll(Colors.white),
                  //   backgroundColor: WidgetStatePropertyAll(Colors.red),
                  // ),
                  child: Text("Login"),
                ),
              ),
              Expanded(
                child: 
                FutureBuilder<List<dynamic>?>(
                  future: getUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (c, i) {
                          var u = snapshot.data![i];
                          return Card(
                            child: ListTile(
                              title: Text(u["name"]),
                              subtitle: Text(u["mobile"]),
                            ),
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/image/ntlogo.png"),
                  Text("|"),
                  Image.asset("assets/image/stclogo.png"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>?>? getUsers() async {
    var addr = Uri.parse("https://api.npoint.io/e26f8eaf8d071a1fd29b");
    var res = await http.get(addr);

    if (res.statusCode == 200) {
      var users = jsonDecode(res.body);
      return users;
    }
    return null;
  }
}
