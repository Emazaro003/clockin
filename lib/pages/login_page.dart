import 'package:clockin/components/colors.dart';
import 'package:clockin/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(450, 900),
        builder: (context, child) => SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: corBase,
                ),
                body: Stack(children: [
                  SingleChildScrollView(
                      child: Stack(children: [
                        Column(children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: corBase,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18.r),
                                bottomRight: Radius.circular(18.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5.r,
                                  blurRadius: 7.r,
                                  offset: Offset(0, 3.h),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height - 290.h,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 360.w,
                                        height: 360.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 0.h, 15.w, 15.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5.r,
                                              blurRadius: 7.r,
                                              offset: Offset(0, 3.h),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'LOGIN',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  SizedBox(
                                                    height: 90.0,
                                                    width: double.infinity,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 3),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          const Text(
                                                            "Usuário",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(color: corBase, width: 1.5),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(color: corBase, width: 1.5),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(color: corBase, width: 1.5),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                )),style: TextStyle(fontSize: 15.sp, color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 90.0,
                                                    width: double.infinity,
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 3),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          const Text(
                                                            "Senha",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          TextFormField(
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(color: corBase, width: 1.5),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(color: corBase, width: 1.5),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                ),
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(color: corBase, width: 1.5),
                                                                  borderRadius: BorderRadius.circular(15),
                                                                )),style: TextStyle(fontSize: 15.sp, color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 50.h,
                                                    margin: EdgeInsets.fromLTRB(25.w,15.h,25.w,0.h),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: corBase,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(15.r),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                const HomePage()));
                                                      },
                                                      child: Text(
                                                        'ENTRAR',
                                                        style: TextStyle(
                                                          fontSize: 16.sp, // Tamanho do texto
                                                          color: Colors.white, // Cor do texto
                                                          fontWeight: FontWeight.bold, // Peso do texto
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        Positioned(
                          top: 125.h,
                          left: 90.w,
                          child: Container(
                            width: 300.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.r),
                                topLeft: Radius.circular(15.r),
                                bottomLeft: Radius.circular(15.r),
                                bottomRight: Radius.circular(15.r),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2.r,
                                  blurRadius: 5.r,
                                  offset: Offset(0, 2.h),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'CLOCK-IN',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color: corTextoPrincipal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]))
                ]))));
  }
}
