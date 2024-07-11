import 'package:clockin/components/colors.dart';
import 'package:clockin/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetalhesDia extends StatefulWidget {
  final String diaDaSemana;
  final String dataAtual;
  final Duration tempoRestante;
  final Duration cargahoraria;

  const DetalhesDia({
    super.key,
    required this.diaDaSemana,
    required this.dataAtual,
    required this.tempoRestante,
    required this.cargahoraria,
  });

  @override
  State<DetalhesDia> createState() => _DetalhesDiaState();
}

class _DetalhesDiaState extends State<DetalhesDia> {
  late Duration tempoTrabalhado;
  late Duration tempoRestante;
  late Duration cargaHoraria;

  @override
  void initState() {
    super.initState();
    cargaHoraria = widget.cargahoraria;
    tempoTrabalhado = widget.tempoRestante;
  }


  @override
  Widget build(BuildContext context) {
    Duration tempoFaltante = cargaHoraria - tempoTrabalhado;

    return WillPopScope(
      onWillPop: () async {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        return false;
      },
      child: ScreenUtilInit(
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
                Column(
                  children: [
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
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                Container(
                                  width: 360.w,
                                  height: 250.h,
                                  margin: EdgeInsets.fromLTRB(
                                      15.w, 85.h, 15.w, 15.h),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              'CARGA HORÁRIA',
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                color: corTextoPrincipal,
                                              ),
                                            ),
                                            Text(
                                              formatDuration(cargaHoraria),
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: corTextoVerde,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Trabalhadas:',
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                    Text(
                                                      'Faltantes:',
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: Colors.grey[700],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      formatDuration(tempoTrabalhado),
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color:Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      formatDuration(tempoFaltante),
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: corTextoPrincipal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
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
                            top: 70.h,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                color: Colors.white,
                                child: Text(
                                  '${widget.diaDaSemana}, ${widget.dataAtual}',
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
                          'Detalhe do dia',
                          style: TextStyle(
                            fontSize: 18.sp,
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
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
