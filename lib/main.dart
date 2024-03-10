import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EnterWindow extends StatefulWidget {
  const EnterWindow({super.key});

  @override
  _APICallState createState() => _APICallState();
}
class _APICallState extends State<EnterWindow> {
  final String apiUrl = 'http://test.shubizle11.beget.tech/v1/jwt-auth/v1/token';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String result = '';

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _postData() async {
    try {
      final response = await http.post(
        Uri.parse('http://test.shubizle11.beget.tech/v1/jwt-auth/v1/token'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': usernameController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          result = 'Username: ${responseData['username']}\nPassword: ${responseData['password']}';
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileWindow()));
      } else {
        throw Exception('Ошибка отправки данных');
      }
    }
    catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 121, 225, 255),
          appBar: AppBar(
            title: const Align(
              alignment: Alignment.center,
              child: Text('Тестовое приложение регистрации',
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 225, 255),
                  )
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 0, 159, 203),
          ),
          body: Align(
              alignment: Alignment.center,
              child: Column(
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: "Введите логин",
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 159, 203),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            hintText: "Введите пароль",
                            border: UnderlineInputBorder(),
                          ),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 159, 203),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    Padding(padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: _postData,
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 73, 197, 229)),
                        ),
                        child: const Text('Войти',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 120, 223, 253),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),),
                  ]
              )
          ),
        )
    );
  }
}

class MainWindow extends StatelessWidget {
  const MainWindow({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 121, 225, 255),
            appBar: AppBar(
              title: const Align( alignment: Alignment.center,
                  child: Text('Тестовое приложение регистрации',
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 225, 255),
                  ) ),
            ),
              backgroundColor: const Color.fromARGB(255, 0, 159, 203),
            ),
            body: Align(
              alignment: Alignment.center,
              child: Column(
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ElevatedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const EnterWindow()));},
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 73, 197, 229)),
                ),
                child: const Text('Вход',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 225, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
                  Padding(padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationWindow()));},
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 73, 197, 229)),
                        ),
                          child: const Text('Регистрация',
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 120, 223, 253),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),)]
            )
        )
        )
    );
  }
}

class RegistrationWindow extends StatefulWidget {
  const RegistrationWindow({super.key});

  @override
  _RegState createState() => _RegState();
}
class _RegState extends State<RegistrationWindow> {
  final String apiUrl = 'http://test.shubizle11.beget.tech/v1/methods/reg';
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String result = '';

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _postRegData() async {
    try {
      final response = await http.post(
        Uri.parse('http://test.shubizle11.beget.tech/v1/methods/reg'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': usernameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          result = 'Username: ${responseData['username']}\nEmail: ${responseData['email']}\nPassword: ${responseData['password']}';
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileWindow()));
      } else {
        throw Exception('Ошибка отправки данных');
      }
    }
    catch (e) {
      setState(() {
        result = 'Error: $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 121, 225, 255),
          appBar: AppBar(
            title: const Align( alignment: Alignment.center,
              child: Text('Тестовое приложение регистрации',
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 225, 255),
                  )
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 0, 159, 203),
          ),
          body: Align(
              alignment: Alignment.center,
              child: Column(
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: "Введите логин",
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 159, 203),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Введите адрес эл. почты",
                            border: UnderlineInputBorder(),
                          ),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 159, 203),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    SizedBox(
                        width: 250,
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            hintText: "Введите пароль",
                            border: UnderlineInputBorder(),
                          ),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 159, 203),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    Padding(padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: _postRegData,
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 73, 197, 229)),
                        ),
                        child: const Text('Войти',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 120, 223, 253),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),)
                  ]
              )
          ),
        )
    );
  }
}

class ProfileWindow extends StatelessWidget{
  const ProfileWindow({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 121, 225, 255),
          appBar: AppBar(
            title: const Align( alignment: Alignment.center,
              child: Text('Тестовое приложение регистрации',
                style: TextStyle(
                  color: Color.fromARGB(255, 121, 225, 255),
                )
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 0, 159, 203),
          ),
          body: Align(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 0, 159, 203),
              ),
              child: Column(
                  verticalDirection: VerticalDirection.down,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                        decoration: const BoxDecoration(
                         shape: BoxShape.circle,
                        ),
                        child: Padding(padding: const EdgeInsets.all(20),
                          child: Image.asset("assets/images/profileicon.jpg", fit: BoxFit.fill,),
                        ),
                    ),
                    const Padding(padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: 400,
                        child: Text('Имя пользователя: username',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 121, 225, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: 400,
                        child: Text('Адрес электронной почты: email',
                          textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 121, 225, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: 400,
                        child: Text('Пароль: password',
                          textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 121, 225, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: (){Navigator.pop(context);},
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 73, 197, 229)),
                        ),
                        child: const Text('Выход',
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 120, 223, 253),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          )
        )
    );
  }
}

void main() {
  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainWindow(),
      )
  );
  }