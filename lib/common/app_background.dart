import 'package:flutter/cupertino.dart';

class AppBackground extends StatelessWidget {
  final Widget? childWidget;
  const AppBackground({super.key,this.childWidget});


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:double.infinity,
          width:double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0XFF50035D),Color(0XFFDF0929),]),
            shape: BoxShape.rectangle,),

        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0XFF000000),Color(0X00000000)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
              )
          ),
          child: childWidget,
        ),
        // Positioned(
        //   bottom: -100,
        //   right: -100,
        //   child: Container(
        //     height: 200,
        //     width:200,
        //     decoration: const BoxDecoration(gradient: RadialGradient(colors: [Color(0XA0FFFFFF),Color(0X00FFFFFF)]),),
        //   ),
        // )
      ],
    );
  }
}
