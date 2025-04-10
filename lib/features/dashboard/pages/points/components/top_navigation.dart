part of '../points_page.dart';


class TopNavigation extends StatelessWidget {
  final VoidCallback back;
  final String title;

  const TopNavigation({super.key, required this.back, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Ensures back button stays left
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomIconButton(
          onButtonPress: back,
          icon: Icons.arrow_back,
          size: 40,
          borderColor: Color(0xff828282),
          iconColor: Colors.white,
          backgroundColor: Color(0xff828282),
        ),
        //SizedBox(width: 12), // Space between icon and text
        Expanded( // Expands to fill available space and center the title properly
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: 40), // Matches the icon's width to balance layout
      ],
    );
  }
}

