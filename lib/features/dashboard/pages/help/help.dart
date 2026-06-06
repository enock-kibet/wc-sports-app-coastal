import 'package:flutter/material.dart';
import 'package:sports_app/common/app_background.dart';
import 'package:sports_app/common/app_back_button.dart';
import 'package:sports_app/common/dimens.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool showAccountSettings = false;
  bool showPasswordSettings = false;
  bool showSharingMedia = false;
  bool showSavingGames = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        childWidget: Padding(
          padding: const EdgeInsets.all(0)
              .copyWith(top: MediaQuery.of(context).viewPadding.top + kSmall),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kXLarge),
                    topRight: Radius.circular(kXLarge)),
                color: Theme.of(context).colorScheme.surface),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kLarge, horizontal: kXLMedium),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        const AppBackButton(),
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Help",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: kXXXXLarge,
                    ),
                    Accordion(
                      context: context,
                      state: showAccountSettings,
                      onTap: () {
                        setState(() {
                          showAccountSettings = !showAccountSettings;
                        });
                      },
                    ),
                    Accordion(
                        context: context,
                        state: showPasswordSettings,
                        onTap: () {
                          setState(() {
                            showPasswordSettings = !showPasswordSettings;
                          });
                        },
                        title: "Help with changing my password"),
                    Accordion(
                        context: context,
                        state: showSharingMedia,
                        onTap: () {
                          setState(() {
                            showSharingMedia = !showSharingMedia;
                          });
                        },
                        title: "Help with sharing media"),
                    Accordion(
                        context: context,
                        state: showSavingGames,
                        onTap: () {
                          setState(() {
                            showSavingGames = !showSavingGames;
                          });
                        },
                        title: "Help with saving games?")
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget Accordion({
  required BuildContext context,
  required bool state,
  required VoidCallback onTap,
  double? height,
  String? title,
}) {
  final theme = Theme.of(context);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title ?? 'Help with setting up my Account',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              state ? Icons.keyboard_arrow_down : Icons.chevron_right,
              color: theme
                  .colorScheme.onSurfaceVariant, // 🌙 icon adjusts with theme
            ),
          ],
        ),
      ),
      AnimatedContainer(
        padding: const EdgeInsets.only(top: 8),
        duration: const Duration(milliseconds: 400),
        height: state ? (height ?? 96) : 0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Help with Setting up my account, Help with Setting up my account, Help with Setting up my account, Help with Setting up my account...",
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
      Divider(
        color: theme.colorScheme.outline.withOpacity(0.3),
        endIndent: 8,
      ),
      const SizedBox(height: 14),
    ],
  );
}
