import 'dart:developer';

import 'package:clockin/api/call_api.dart';
import 'package:clockin/components/alert.dart';
import 'package:clockin/components/colors.dart';
import 'package:clockin/pages/home_adm_page.dart';
import 'package:clockin/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  CallApi callApi = CallApi();

  final TextEditingController _matriculaController = TextEditingController();
  final FocusNode _matriculaFocusNode = FocusNode();
  final TextEditingController _senhaController = TextEditingController();
  final FocusNode _senhaFocusNode = FocusNode();
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
  }

  void _login() async {
    final matricula = _matriculaController.text;
    final senha = _senhaController.text;
    try {
      Map<String, dynamic> userData =
          await callApi.validarLogin(matricula, senha);
      String tipoUsuario = userData['tipoUsuario'];

      if (tipoUsuario == 'ADMINISTRADOR') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeADMPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      _matriculaController.text = "";
      _senhaController.text = "";
      _matriculaFocusNode.requestFocus();
      String errorMessage = e.toString().split(": ").last;
      Alert.showToast(errorMessage, Colors.red, ToastGravity.BOTTOM);
      log("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(450, 900),
        builder: (context, child) => SafeArea(
            child: Scaffold(
                // resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: corBase,
                ),
                body: SingleChildScrollView(
                  child: Stack(children: [
                    Column(children: [
                      Container(
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
                        height: MediaQuery.of(context).size.height - 310.h,
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
                                                height: 90.0.h,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      25.w, 0.h, 25.w, 3.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "Matrícula",
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            _matriculaController,
                                                        focusNode:
                                                            _matriculaFocusNode,
                                                        textInputAction:
                                                            TextInputAction
                                                                .next,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color:
                                                                          corBase,
                                                                      width: 1.5
                                                                          .w),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.r),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color:
                                                                          corBase,
                                                                      width: 1.5
                                                                          .w),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.r),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color:
                                                                          corBase,
                                                                      width: 1.5
                                                                          .w),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15.r),
                                                                )),
                                                        style: TextStyle(
                                                            fontSize: 15.sp,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 90.0.h,
                                                width: double.infinity,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      25.w, 0.h, 25.w, 3.h),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "Senha",
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            _senhaController,
                                                        focusNode:
                                                            _senhaFocusNode,
                                                        obscureText: _isObscure,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: corBase,
                                                              width: 1.5.w,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.r),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: corBase,
                                                              width: 1.5.w,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.r),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: corBase,
                                                              width: 1.5.w,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.r),
                                                          ),
                                                          suffixIcon:
                                                              IconButton(
                                                            icon: Icon(
                                                              _isObscure
                                                                  ? Icons
                                                                      .visibility
                                                                  : Icons
                                                                      .visibility_off,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _isObscure =
                                                                    !_isObscure;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        style: TextStyle(
                                                          fontSize: 15.sp,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 50.h,
                                                margin: EdgeInsets.fromLTRB(
                                                    25.w, 15.h, 25.w, 0.h),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: corBase,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.r),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // _verificaLogin();
                                                    _login();
                                                  },
                                                  child: Text(
                                                    'ENTRAR',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      // Tamanho do texto
                                                      color: Colors.white,
                                                      // Cor do texto
                                                      fontWeight: FontWeight
                                                          .bold, // Peso do texto
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
                      left: (MediaQuery.of(context).size.width - 300.w) / 2,
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
                  ]),
                ))));
  }
}
