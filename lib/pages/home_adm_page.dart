import 'dart:developer';

import 'package:clockin/api/call_api.dart';
import 'package:clockin/components/alert.dart';
import 'package:clockin/components/colors.dart';
import 'package:clockin/dataBase/db_login.dart';
import 'package:clockin/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeADMPage extends StatefulWidget {
  const HomeADMPage({Key? key}) : super(key: key);

  @override
  State<HomeADMPage> createState() => _HomeADMPageState();
}

class _HomeADMPageState extends State<HomeADMPage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  CallApi callApi = CallApi();

  final LimitedLengthTextEditingController _controller =
      LimitedLengthTextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _logout() async {
    await dbHelper.deleteAllUsers();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    log('Deslogado');
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR');
    return ScreenUtilInit(
      designSize: const Size(450, 900),
      builder: (context, child) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: corBase,
            automaticallyImplyLeading: false,
            actions: [
              PopupMenuButton<String>(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 42.sp,
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'Cadastrar funcionário':
                      Alert.showToast("Em Desenvolvimento", Colors.orange,
                          ToastGravity.CENTER);
                      break;
                    case 'Logout':
                      _logout();
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Cadastrar funcionário', 'Logout'}
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Container(
                          width: 180.w,
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                          child: Text(choice)),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 90.h,
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
                    height: MediaQuery.of(context).size.height / 1.4,
                    color: Colors.white,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Container(
                                width: 390.w,
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
                                margin:
                                    EdgeInsets.fromLTRB(15.w, 65.h, 15.w, 15.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5.r,
                                      blurRadius: 7.r,
                                      offset: Offset(0, 3.h),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      20.w, 10.h, 20.w, 0.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(height: 10.h),
                                      TextFormField(
                                        controller: _controller,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: corBase, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: corBase, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: corBase, width: 1.5),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          labelText: "Matrícula",
                                        ),
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                        maxLength: 4,
                                        // Limita o número de caracteres exibidos visualmente
                                        buildCounter: (BuildContext context,
                                                {required int? currentLength,
                                                required bool isFocused,
                                                required int? maxLength}) =>
                                            null,
                                      ),
                                      SizedBox(height: 20.h),
                                      Expanded(
                                        child: GridView.count(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 8.w,
                                          mainAxisSpacing: 8.h,
                                          children: [
                                            for (int i = 1; i <= 9; i++)
                                              SizedBox(
                                                width: 50.w,
                                                height: 10.h,
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _controller.text +=
                                                          i.toString();
                                                    });
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .grey[300]),
                                                    shape: MaterialStateProperty
                                                        .all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    i.toString(),
                                                    style: TextStyle(
                                                        fontSize: 22.sp),
                                                  ),
                                                ),
                                              ),
                                            SizedBox(
                                              width: 100.w,
                                              height: 100.h,
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _controller.clear();
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.red),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 40.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100.w,
                                              height: 100.h,
                                              child: TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _controller.text += '0';
                                                  });
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey[300]),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  '0',
                                                  style: TextStyle(
                                                      fontSize: 22.sp),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 100.w,
                                              height: 100.h,
                                              child: TextButton(
                                                onPressed: () async {
                                                  String matricula =
                                                      _controller.text;
                                                  String resultMessage =
                                                      await callApi
                                                          .registrarPontoComMatricula(
                                                              matricula);
                                                  _controller.clear();

                                                  Color toastColor =
                                                      resultMessage.contains(
                                                              'sucesso')
                                                          ? Colors.green
                                                          : Colors.red;
                                                  ToastGravity toastGravity =
                                                      ToastGravity.TOP;

                                                  Alert.showToast(resultMessage,
                                                      toastColor, toastGravity);
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.green),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                  size: 40.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 50.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              color: Colors.white,
                              child: Text(
                                DateFormat('EEEE, dd/MM/yyyy', 'pt_BR')
                                    .format(DateTime.now())
                                    .replaceFirstMapped(
                                      RegExp(r'^(\w)'),
                                      (match) => match.group(0)!.toUpperCase(),
                                    ),
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: corTextoPrincipal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 70.h,
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
            ],
          ),
        ),
      ),
    );
  }
}

class LimitedLengthTextEditingController extends TextEditingController {
  LimitedLengthTextEditingController({String? text}) : super(text: text);

  @override
  set text(String newText) {
    String trimmedText = newText.substring(0, newText.length.clamp(0, 4));
    value = value.copyWith(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: trimmedText.length),
      composing: TextRange.empty,
    );
    notifyListeners();
  }
}
