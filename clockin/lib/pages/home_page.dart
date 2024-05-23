import 'package:clockin/components/colors.dart';
import 'package:clockin/pages/detalhes_dia_page.dart';
import 'package:clockin/pages/historico_mes_page.dart';
import 'package:clockin/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 45.sp,
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
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
                          height: MediaQuery.of(context).size.height - 250.h,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 360.w,
                                      height: 70.h,
                                      margin: EdgeInsets.fromLTRB(
                                          15.w, 65.h, 15.w, 15.h),
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
                                      child: Center(
                                        child: Text(
                                          '00:00 H',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: corTextoVerde,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 360.w,
                                      height: 30.h,
                                      margin:
                                          EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                                      child: Text(
                                        'Status de hoje',
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: corTextoPrincipal,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DetalhesDia()));
                                      },
                                      child: Container(
                                        width: 360.w,
                                        height: 140.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 10.h, 15.w, 10.h),
                                        padding:
                                            EdgeInsets.fromLTRB(8.w, 0, 5.w, 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5.r,
                                              blurRadius: 7.r,
                                              offset: Offset(0, 3.h),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Dia-semana, DD/MM/AAAA',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Último ponto registrado: DD/MM/AAAA HH:MM',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              'Tempo restante: HH:MM',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HistoricoMes()));
                                      },
                                      child: Container(
                                        width: 360.w,
                                        height: 55.h,
                                        margin: EdgeInsets.fromLTRB(
                                            15.w, 15.h, 15.w, 10.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.r)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5.r,
                                              blurRadius: 7.r,
                                              offset: Offset(0, 3.h),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.query_builder_outlined,
                                                color: corTextoPrincipal,
                                                size: 30.sp,
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                'Ver histórico de ponto',
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  color: corTextoPrincipal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 360.w,
                                      height: 30.h,
                                      margin: EdgeInsets.fromLTRB(
                                          15.w, 10.h, 15.w, 0),
                                      child: Text(
                                        'Avisos',
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          color: corTextoPrincipal,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 360.w,
                                      height: 110.h,
                                      margin: EdgeInsets.fromLTRB(
                                          15.w, 10.h, 15.w, 0),
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
                                      child: Center(
                                        child: Text(
                                          'Você não possui nenhum aviso',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 48.h,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    color: Colors.white,
                                    child: Text(
                                      'SALDO',
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
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
                      left: 90.w,
                      child: Container(
                        width: 300.w,
                        height: 45.h,
                        padding: EdgeInsets.fromLTRB(32.w, 12.h, 0, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.r),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nome e Sobrenome",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: corTextoPrincipal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160.h,
                      left: 90.w,
                      child: Container(
                        width: 200.w,
                        height: 25.h,
                        padding: EdgeInsets.fromLTRB(32.w, 3.h, 0, 0),
                        decoration: BoxDecoration(
                          color: corBase,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Analista de Sistemas",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 105.h,
                      left: 20.w,
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        padding: EdgeInsets.all(2.5.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.white,
                          backgroundImage: const NetworkImage(
                            'https://img.freepik.com/fotos-gratis/fundo-texturizado-abstrato_1258-30461.jpg?t=st=1716012630~exp=1716016230~hmac=70399f2396de5461f7cc4f60ea536acb59ba8c2b9fee569cf1e837f614975be9',
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
      ),
    );
  }
}
