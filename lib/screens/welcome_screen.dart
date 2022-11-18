import 'package:cpd/screens/login_screen.dart';
import 'package:cpd/styling/size_params.dart';
import 'package:cpd/widgets/buttons/flat_border_button.dart';
import 'package:cpd/widgets/buttons/text/button_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeParams().fullWidth(context),
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Image.asset(
                        'assets/logoAlt.PNG',
                        width: 200,
                      ),
                    ),
                    SizedBox(
                      width: SizeParams().welcomeLogoWidth(context),
                      child: Text(
                        "Part of the Innovation Driven Procurement Project",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Theme.of(context).canvasColor,
                          fontSize: 15,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                FlatBorderButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                  child: const ButtonText(
                    text: "Sign in",
                  ),
                  width: SizeParams().widthWithPadding(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
