import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/dimens.dart';
import 'package:sports_app/theme/app_colors.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AppBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(0).copyWith(top:MediaQuery.of(context).viewPadding.top+kSmall),
          child: Container(
            height: double.infinity,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(kXLarge),
                      topRight: Radius.circular(kXLarge)),
                  color: AppColors.inputFillColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(width: double.infinity,child: Image.asset("assets/images/about_us.png",fit: BoxFit.fitWidth,)),
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0,top: 7,bottom: 7),
                          child: IconButton.filledTonal(
                            onPressed: ()=> context.pop(),
                            icon:  Icon(Icons.arrow_back,color: AppColors.inputFillColor,),
                            style: IconButton.styleFrom(backgroundColor: Color(0X66000000),fixedSize: Size(48, 48)),
                          ),
                        ),
                        Align(alignment: Alignment.center,child: Text("About Us",style: TextStyle(fontSize: kXLMedium,fontWeight: FontWeight.bold,color: AppColors.inputFillColor),)
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: kXLMedium,),
                      Text("Why did we start Sports App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.left,),
                      SizedBox(height: 14,),
                      Text("At Wence Techologies, we empower businesses to achieve sustainability and  growth through innovative software solutions. We are committed to  transforming the way businesses operate, ensuring they can deliver exceptional value to their customers without compromising on quality or  efficiency.",
                        style: TextStyle(fontSize: 12),textAlign: TextAlign.justify,),
                      SizedBox(height: 36,),
                      Text("Find Us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.left,),
                      SizedBox(height: 14,),
                      Row(
                        children: [
                          Image.asset("assets/icons/web.png",height: 18,),
                          SizedBox(width: kSmall,),
                          Text("www.wencetechnologies.com",style: TextStyle(fontSize: 12))
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          Image.asset("assets/icons/twitter.png",height: 18,),
                          SizedBox(width: kSmall,),
                          Text("@wencetechnologies",style: TextStyle(fontSize: 12))
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          Image.asset("assets/icons/instagram.png",height: 18,),
                          SizedBox(width: kSmall,),
                          Text("@wencetechnologies",style: TextStyle(fontSize: 12),)
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          Image.asset("assets/icons/facebook.png",height: 18,),
                          SizedBox(width: kSmall,),
                          Text("@wencetechnologies",style: TextStyle(fontSize: 12))
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          Image.asset("assets/icons/linkedin.png",height: 18,),
                          SizedBox(width: kSmall,),
                          Text("@wencetechnologies",style: TextStyle(fontSize: 12))
                        ],
                      )

                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
