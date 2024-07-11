import 'dart:developer';

import 'package:clockin/api/call_api.dart';
import 'package:clockin/components/alert.dart';
import 'package:clockin/components/colors.dart';
import 'package:clockin/models/usuarios.dart';
import 'package:clockin/pages/home_adm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  CallApi callApi = CallApi();

  final TextEditingController _nomeCompController = TextEditingController();
  final FocusNode _nomeCompFocusNode = FocusNode();
  final TextEditingController _cargoController = TextEditingController();
  final FocusNode _cargoFocusNode = FocusNode();
  final TextEditingController _matriculaController = TextEditingController();
  final FocusNode _matriculaFocusNode = FocusNode();
  final TextEditingController _senhaController = TextEditingController();
  final FocusNode _senhaFocusNode = FocusNode();
  final TextEditingController _entradaController = TextEditingController();
  final TextEditingController _saidaController = TextEditingController();
  final TextEditingController _intervaloEntradaController =
      TextEditingController();
  final TextEditingController _intervaloSaidaController =
      TextEditingController();

  final LimitedLengthTextEditingController _controller =
  LimitedLengthTextEditingController();

  bool _isObscure = true;

  final List<bool> _isChecked = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitForm() async {
    List<String> diasSelecionados = [];
    List<String> diasDaSemana = ["SEGUNDA", "TERCA", "QUARTA", "QUINTA", "SEXTA", "SABADO", "DOMINGO"];
    for (int i = 0; i < _isChecked.length; i++) {
      if (_isChecked[i]) {
        diasSelecionados.add(diasDaSemana[i]);
      }
    }

    Map<String, dynamic> requestData = {
      "nome": _nomeCompController.text,
      "cargo": _cargoController.text,
      "diasDaSemana": diasSelecionados,
      "entrada": _entradaController.text,
      "saida": _saidaController.text,
      "intervaloEntrada": _intervaloEntradaController.text,
      "intervaloSaida": _intervaloSaidaController.text,
      "usuarioResquestDTO": {
        "matricula": _matriculaController.text,
        "senha": _senhaController.text
      }
    };

    FuncionarioCadastroDTO funcionarioRequestDTO = FuncionarioCadastroDTO.fromMap(requestData);

    try {
      String responseMessage = await callApi.cadastrar(funcionarioRequestDTO);
      Alert.showToast(responseMessage, Colors.green, ToastGravity.BOTTOM);
      _clearFields();
    } catch (e) {
      Alert.showToast("Erro ao cadastrar funcionario", Colors.red, ToastGravity.BOTTOM);
    }
  }

  void _clearFields() {
    _nomeCompController.clear();
    _cargoController.clear();
    _isChecked.fillRange(0, _isChecked.length, false);
    _entradaController.clear();
    _saidaController.clear();
    _intervaloEntradaController.clear();
    _intervaloSaidaController.clear();
    _matriculaController.clear();
    _senhaController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 900),
      builder: (context, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: corBase,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 45.sp,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 50.h,
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
                      // height: MediaQuery.of(context).size.height - 10.h,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 400.w,
                                      height: 50.h,
                                      margin: EdgeInsets.fromLTRB(
                                          10.w, 15.h, 15.w, 0.h),
                                      child: Center(
                                          child: Text(
                                        "DADOS DO FUNCIONÁRIO",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))),
                                  Container(
                                    width: 400.w,
                                    height: 400.h,
                                    margin: EdgeInsets.fromLTRB(
                                        0.w, 0.h, 15.w, 15.h),
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
                                              _buildTextField(
                                                label: "Nome Completo",
                                                controller: _nomeCompController,
                                                focusNode: _nomeCompFocusNode,
                                                nextFocusNode: _cargoFocusNode,
                                              ),
                                              _buildTextField(
                                                label: "Cargo",
                                                controller: _cargoController,
                                                focusNode: _cargoFocusNode,
                                                nextFocusNode:
                                                    _matriculaFocusNode,
                                              ),
                                              _buildTextFieldMatricula(
                                                label: "Matrícula",
                                                controller:
                                                    _matriculaController,
                                                focusNode: _matriculaFocusNode,
                                                nextFocusNode: _senhaFocusNode,
                                              ),
                                              _buildTextFieldSenha(
                                                label: "Senha",
                                                controller: _senhaController,
                                                focusNode: _senhaFocusNode,
                                                isObscure: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: 360.w,
                                      height: 50.h,
                                      margin: EdgeInsets.fromLTRB(
                                          10.w, 0.h, 15.w, 0.h),
                                      child: Center(
                                          child: Text(
                                        "CARGA HORÁRIA",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ))),
                                  Container(
                                    width: 400.w,
                                    height: 350.h,
                                    margin: EdgeInsets.fromLTRB(
                                        10.w, 0.h, 10.w, 15.h),
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
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 50.h,
                                          child: Center(
                                            child: Text(
                                              "Dia da semana",
                                              style: TextStyle(
                                                fontSize: 17.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 75.h,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildDayCheckbox("SEG", 0),
                                              _buildDayCheckbox("TER", 1),
                                              _buildDayCheckbox("QUA", 2),
                                              _buildDayCheckbox("QUI", 3),
                                              _buildDayCheckbox("SEX", 4),
                                              _buildDayCheckbox("SAB", 5),
                                              _buildDayCheckbox("DOM", 6),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Entrada",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(height: 5.w),
                                                  SizedBox(
                                                    width: 103.w,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "00:00:00",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        TimeOfDay? pickedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (pickedTime !=
                                                            null) {
                                                          setState(() {
                                                            _entradaController
                                                                    .text =
                                                                pickedTime
                                                                    .format(
                                                                        context);
                                                          });
                                                        }
                                                      },
                                                      controller:
                                                          _entradaController,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.w),
                                                  Text(
                                                    "Saída Intervalo",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  SizedBox(
                                                    width: 103.w,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "00:00:00",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        TimeOfDay? pickedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (pickedTime !=
                                                            null) {
                                                          setState(() {
                                                            _intervaloSaidaController
                                                                    .text =
                                                                pickedTime
                                                                    .format(
                                                                        context);
                                                          });
                                                        }
                                                      },
                                                      controller:
                                                          _intervaloSaidaController,
                                                    ),
                                                  ),
                                                ]),
                                            SizedBox(width: 25.w),
                                            Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Entrada Intervalo",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(height: 5.w),
                                                  SizedBox(
                                                    width: 103.w,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "00:00:00",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        TimeOfDay? pickedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (pickedTime !=
                                                            null) {
                                                          setState(() {
                                                            _intervaloEntradaController
                                                                    .text =
                                                                pickedTime
                                                                    .format(
                                                                        context);
                                                          });
                                                        }
                                                      },
                                                      controller:
                                                          _intervaloEntradaController,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.w),
                                                  Text(
                                                    "Saída",
                                                    style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  SizedBox(
                                                    width: 103.w,
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: "00:00:00",
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        TimeOfDay? pickedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                        );
                                                        if (pickedTime !=
                                                            null) {
                                                          setState(() {
                                                            _saidaController
                                                                    .text =
                                                                pickedTime
                                                                    .format(
                                                                        context);
                                                          });
                                                        }
                                                      },
                                                      controller:
                                                          _saidaController,
                                                    ),
                                                  ),
                                                ])
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 50.h,
                                    margin: EdgeInsets.fromLTRB(
                                        35.w, 15.h, 35.w, 20.h),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: corBase,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                      ),
                                      onPressed: _submitForm,
                                      child: Text(
                                        'CADASTRAR',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 20.h,
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
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    bool isObscure = false,
  }) {
    return SizedBox(
      height: 90.0.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 0.h, 25.w, 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: nextFocusNode != null
                  ? TextInputAction.next
                  : TextInputAction.done,
              onFieldSubmitted: (_) {
                if (nextFocusNode != null) {
                  FocusScope.of(context).requestFocus(nextFocusNode);
                }
              },
              obscureText: isObscure,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: corBase, width: 1.5.w),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: corBase, width: 1.5.w),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: corBase, width: 1.5.w),
                  borderRadius: BorderRadius.circular(15.r),
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
    );
  }

  Widget _buildTextFieldMatricula({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
  }) {
    return SizedBox(
      height: 90.0.h,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(25.w, 0.h, 25.w, 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: corBase, width: 1.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: corBase, width: 1.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: corBase, width: 1.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                labelText: "Matrícula",
              ),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              maxLength: 4,
              buildCounter: (BuildContext context, {required int? currentLength, required bool isFocused, required int? maxLength}) => null,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldSenha({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool isObscure,
  }) {
    return SizedBox(
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
    );
  }

  Widget _buildDayCheckbox(String label, int index) {
    return Column(
      children: [
        Checkbox(
          value: _isChecked[index],
          shape: const CircleBorder(),
          onChanged: (bool? value) {
            setState(() {
              _isChecked[index] = value!;
            });
          },
        ),
        Text(label, style: TextStyle(fontSize: 16.sp)),
      ],
    );
  }
}
