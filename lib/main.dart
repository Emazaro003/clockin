import 'package:clockin/dataBase/db_login.dart';
import 'package:clockin/pages/home_adm_page.dart';
import 'package:clockin/pages/home_page.dart';
import 'package:clockin/pages/login_page.dart';
import 'package:clockin/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseHelper dbHelper = DatabaseHelper();
  Widget tela = const LoginPage();
  late String tipoUsuario;
  bool isLogado = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    Map<String, dynamic> userData = await dbHelper.isLoggedIn();
    tipoUsuario = userData['tipoUsuario'];
    isLogado = tipoUsuario != "" ? true : false;
    _loadNextScreen(isLogado);
  }

  void _loadNextScreen(bool isLogado) {
    setState(() {
      if (isLogado) {
        tela = tipoUsuario == 'ADMINISTRADOR'
            ? const HomeADMPage()
            : const HomePage();
      } else {
        tela = const LoginPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: tela == null
                ? const Center(child: CircularProgressIndicator())
                : SplashScreen(
                    nextScreenBuilder: () => tela,
                    logo: '',
                  ));
      },
    );
  }
}
