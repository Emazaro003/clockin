import 'package:clockin/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoricoMes extends StatefulWidget {
  const HistoricoMes({super.key});

  @override
  State<HistoricoMes> createState() => _HistoricoMesState();
}

class _HistoricoMesState extends State<HistoricoMes> {
  final List<Map<String, String>> detalhes = [
    {
      "data": "01/01/2024",
      "ht": "08:00",
      "saldo": "00:00",
      "descricao": "CONCLUÍDO",
      "diaSemana": "Segunda-feira"
    },
    {
      "data": "02/01/2024",
      "ht": "07:30",
      "saldo": "-00:30",
      "descricao": "SEM CARGA HORÁRIA",
      "diaSemana": "Terça-feira"
    },
    {
      "data": "02/01/2024",
      "ht": "07:30",
      "saldo": "-00:30",
      "descricao": "SEM CARGA HORÁRIA",
      "diaSemana": "Terça-feira"
    },
    {
      "data": "02/01/2024",
      "ht": "07:30",
      "saldo": "-00:30",
      "descricao": "SEM CARGA HORÁRIA",
      "diaSemana": "Terça-feira"
    },
    {
      "data": "02/01/2024",
      "ht": "07:30",
      "saldo": "-00:30",
      "descricao": "SEM CARGA HORÁRIA",
      "diaSemana": "Terça-feira"
    },
    {
      "data": "02/01/2024",
      "ht": "07:30",
      "saldo": "-00:30",
      "descricao": "SEM CARGA HORÁRIA",
      "diaSemana": "Terça-feira"
    },
    {
      "data": "02/01/2024",
      "ht": "07:30",
      "saldo": "-00:30",
      "descricao": "SEM CARGA HORÁRIA",
      "diaSemana": "Terça-feira"
    },
    {
      "data": "02/01/2024",
      "ht": "07:30",
      "saldo": "-00:30",
      "descricao": "SEM CARGA HORÁRIA",
      "diaSemana": "Terça-feira"
    },
  ];

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
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
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
                      height: MediaQuery.of(context).size.height - 200.h,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Container(
                                  width: 420.w,
                                  height: 550.h,
                                  margin: EdgeInsets.fromLTRB(
                                      15.w, 60.h, 15.w, 0.h),
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 18, 5, 0),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              'SALDO',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            Text(
                                              'HH:MM',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: corTextoVerde,
                                              ),
                                            ),
                                            SizedBox(height: 20.h),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(8.w,10.h,8.w,0.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "Data",
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          "H.T",
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Text(
                                                          "SALDO",
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(
                                                          "DESCRIÇÃO",
                                                          style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(thickness: 1.5,),
                                                  SizedBox(
                                                    height: 380.h,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          detalhes.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final item =
                                                            detalhes[index];
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      8.h),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          item[
                                                                              "data"]!,
                                                                          style:
                                                                              TextStyle(fontSize: 14.sp),
                                                                        ),
                                                                        Text(
                                                                          item[
                                                                              "diaSemana"]!,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                13.sp,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      item[
                                                                          "ht"]!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Text(
                                                                      item[
                                                                          "saldo"]!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Text(
                                                                      item[
                                                                          "descricao"]!,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14.sp),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              // const Divider(),
                                                            ],
                                                          ),
                                                        );
                                                      },
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
                          Positioned(
                            top: 43.h,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                child: Text(
                                  'MÊS',
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
              ),
              Positioned(
                top: 125.h,
                left: 90.w,
                child: Container(
                  width: 300.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2.r,
                        blurRadius: 5.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'Histórico mensal',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: corTextoPrincipal,
                      ),
                    ),
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
