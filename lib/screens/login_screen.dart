import 'package:cpd/functions/firebase_functions.dart';
import 'package:cpd/functions/messages.dart';
import 'home_screen.dart';
import 'package:cpd/styling/custom_border.dart';
import 'package:cpd/widgets/buttons/flat_border_button.dart';
import 'package:cpd/widgets/buttons/flat_colour_button.dart';
import 'package:cpd/widgets/buttons/text/button_text.dart';
import 'package:cpd/widgets/buttons/text/contrast_button_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'intro.dart';


//TODO: Ensure iOS is correctly configured for mobile login at https://firebase.flutter.dev/docs/auth/phone/
//TODO: May need to change SHA-1 in Firestore if Package Name changes
//TODO: Improve the layout and feel of this page

/*
https://medium.com/codechai/firebase-user-authentication-using-phone-verification-in-flutter-c34dc0f7a9f8
https://medium.com/firebase-developers/dive-into-firebase-auth-on-flutter-phone-and-anonymous-authentication-6ce4f17eb2a8
https://firebase.flutter.dev/docs/auth/phone/
https://stackoverflow.com/questions/67037392/sms-verification-code-request-failed-unknown-status-code-17093-null-firebase-p
https://stackoverflow.com/questions/51845559/generate-sha-1-for-flutter-react-native-android-native-app
 */

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Initialise the required functionality for receiving and processing entered data
  final GlobalKey<FormState> _numberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _usernameKey = GlobalKey<FormState>();

  final GlobalKey<FormState> _verifyKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _verificationCode = TextEditingController();

  late FocusNode _phoneNumberFN;
  late FocusNode _usernameFN;
  late FocusNode _verifyFN;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _showVerificationField = false, _isLoading = false;
  String? _verificationId;

  @override
  void initState() {
    // Initialise the focus nodes, for listening to on-click events
    _phoneNumberFN = FocusNode();
    _usernameFN = FocusNode();
    _verifyFN = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // Close the focus nodes to prevent memory leaks
    _phoneNumberFN.dispose();
    _usernameFN.dispose();
    _verifyFN.dispose();
    super.dispose();
  }

  Future<void> _navigateToHome() async {
    // Navigate to the home page
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => OnBoardingPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  // Verifies the mobile number entered
  Future<void> _checkAndVerify() async {
    // Validates the field where the mobile number has been entered
    bool isValidated = _numberKey.currentState!.validate();
    if (isValidated) {
      // Lower the keyboard from the field
      _verifyFN.unfocus();
      // Verify the mobile number
      _auth.verifyPhoneNumber(
        // Pass in the entered mobile number
        phoneNumber: "+44" + _phoneNumber.text,
        // Set an SMS received timeout of 1 minute
        timeout: const Duration(minutes: 1),
        // Run when the verification is complete
        verificationCompleted: (AuthCredential authCredential) {
          // Sign the user in with the entered mobile number and navigate to the
          // home page, otherwise, show an error
          _auth
              .signInWithCredential(authCredential)
              .then(
                (value) => _navigateToHome,
              )
              .catchError(
                (e) => Functions().showSnackBar(
                  context: context,
                  isError: true,
                  message: e,
                ),
              );
        },
        // Shows any errors via a snackbar
        verificationFailed: (Exception e) {
          // "mounted" checks that the screen is still active and in view,
          // if not then the code doesn't run to prevent memory leaks
          if (mounted) {
            Functions().showSnackBar(
              context: context,
              isError: true,
              message: e.toString(),
            );
          }
        },
        // Run when the SMS verification code has been set
        codeSent: (String verificationId, int? forceResendingToken) {
          setState(() {
            // Show the SMS verification field and update the verification ID
            _showVerificationField = true;
            _verificationId = verificationId;
          });
          // Show a toast to indicate the SMS message has been sent
          Functions().showToast(
            context: context,
            message: "Code sent!",
          );
        },
        // Run when the code has not been entered in 1 minute of it being sent
        codeAutoRetrievalTimeout: (String verificationId) {
          if (mounted) {
            Functions().showSnackBar(
              context: context,
              isError: true,
              message: "Sign in timed out, please try again",
            );
          }
        },
      );
    }
  }

  // Checks that the user account has been setup
  Future<void> _checkAccount() async {
    FirebaseFunctions().user.get().then((doc) {
      bool accountSetup = false;
      if (doc.data() != null) {
        accountSetup =
            (doc.data() as Map<String, dynamic>)["account_setup"] ?? false;
      }
      if (!accountSetup) {
        FirebaseFunctions().user.set({
          "level": 1,
          "current_points": 0,
        }).then(
          (value) => FirebaseFunctions().user.set({
            "full_name": _username.text,
            "profile_url": "",
            "account_setup": true,
          }),
        );
        FirebaseFunctions().Module1.set({
          "completed": false,
          "correct": 0,
          "progress": 0,
        });
        FirebaseFunctions().Module2.set({
          "completed": false,
          "correct": 0,
          "progress": 0,
        });
        FirebaseFunctions().Module3.set({
          "completed": false,
          "correct": 0,
          "progress": 0,
        });
        FirebaseFunctions().Module4.set({
          "completed": false,
          "correct": 0,
          "progress": 0,
        });
      }
    });
  }

  // Verify the SMS code and login the user
  Future<void> _verifyAndLogin() async {
    bool isValidated = _verifyKey.currentState!.validate();
    if (_verificationId != null && isValidated) {
      // Show the loading indicator
      setState(() {
        _isLoading = true;
      });
      //Create an instance of a mobile phone login request,
      // using the verification ID and code
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _verificationCode.text.trim(),
      );
      // Sign in the user with the above credentials, showing any errors
      _auth
          .signInWithCredential(credential)
          .then((_) => _checkAccount())
          .then(
            (value) => setState(() {
              _isLoading = false;
            }),
          )
          .then((_) => _navigateToHome())
          .catchError(
            (e) => Functions().showSnackBar(
              context: context,
              isError: true,
              message: e,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(padding: EdgeInsets.zero),
                  Center(
                    child: Text(
                      "Sign Up\nor\nLogin",
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Form(
                        //Used for validation
                        key: _usernameKey,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _username,
                                  onTap: () => _usernameFN.requestFocus(),
                                  onEditingComplete: () {
                                    _usernameFN.unfocus();
                                  },
                                  maxLength: 15,
                                  focusNode: _usernameFN,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: CustomBorder().borderRadius,
                                    ),
                                    labelText: "Username",
                                    hintText: "E.g., JohnSmith",
                                  ),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  validator: (name) {
                                    if (name == null || name.isEmpty) {
                                      return "Enter a valid username";
                                    }
                                    return null;
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      // If true, show the form field, if not show nothing
                      Form(
                        //Used for validation
                        key: _numberKey,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _phoneNumber,
                                onTap: () => _phoneNumberFN.requestFocus(),
                                onEditingComplete: () {
                                  _phoneNumberFN.unfocus();
                                },
                                focusNode: _phoneNumberFN,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: CustomBorder().borderRadius,
                                  ),
                                  labelText: "Mobile number",
                                  hintText: "E.g., 07123456789",
                                ),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.phone,
                                validator: (number) {
                                  if (number == null || number.isEmpty) {
                                    return "Enter a valid mobile number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only( left: 10),
                              child: FlatBorderButton(
                                onTap: () {
                                  _phoneNumberFN.unfocus();
                                  _checkAndVerify();
                                },
                                child: Icon(
                                  Icons.done,
                                  color: Theme.of(context).primaryColor,
                                ),
                                width: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(""
                            "Enter your mobile number and press the tick to "
                            "receive a confirmation code. Enter this code into the box that will "
                            "appear below.",
                        ),
                      ),

                      _showVerificationField
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 16.0, bottom: 16.0),
                                  child: Form(
                                    key: _verifyKey,
                                    child: TextFormField(
                                      controller: _verificationCode,
                                      onTap: () => _verifyFN.requestFocus(),
                                      onEditingComplete: () {
                                        _verifyFN.unfocus();
                                      },
                                      focusNode: _verifyFN,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              CustomBorder().borderRadius,
                                        ),
                                        labelText: "Verification code",
                                      ),
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.number,
                                      validator: (number) {
                                        if (number == null || number.isEmpty) {
                                          return "Enter a valid verification code";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                FlatColourButton(
                                    onTap: () => _verifyAndLogin(),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _isLoading
                                            ? SizedBox(
                                                width: 12,
                                                height: 12,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  strokeWidth: 1,
                                                ),
                                              )
                                            : Container(),
                                        const ContrastButtonText(
                                          text: "Login",
                                        ),
                                        const SizedBox(width: 0)
                                      ],
                                    ),
                                    width: double.infinity)
                              ],
                            )
                          : Container(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const ButtonText(
                        text: "Cancel",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
