import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/pages/home_page/home_page.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/state_managers/navigation_state.dart';
import '../../components/custom_input.dart';
import '../../components/smart_dialog.dart';
import '../../constant/functions.dart';
import '../../constant/strings.dart';
import '../../generated/assets.dart';
import '../../models/user_model.dart';
import '../../services/firebase_auth_services.dart';
import '../../services/firestore_services.dart';
import '../../state_managers/user_data_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(Assets.imagesLogoSmallT,
                              width: 100, height: 100),
                          Text('LOGIN',
                              style: GoogleFonts.alfaSlabOne(
                                  decoration: TextDecoration.underline,
                                  fontSize: 30,
                                  color: secondaryColor)),
                          const SizedBox(height: 15),
                          CustomTextFields(
                            label: 'Email',
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !emailRegEx.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          CustomTextFields(
                            label: 'Password',
                            prefixIcon: Icons.lock,
                            obscureText: _obscureText,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: primaryColor,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: RichText(
                                text: TextSpan(
                              text: 'Forgot Password?',
                              style: GoogleFonts.nunito(
                                color: secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  ref.read(authNavProvider.notifier).state = 2;
                                },
                            )),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => signUserIn(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              textStyle: GoogleFonts.nunito(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.nunito(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 15),
                          RichText(
                              text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: ' Sign Up',
                                style: GoogleFonts.nunito(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ref.read(authNavProvider.notifier).state =
                                        1;
                                  },
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  signUserIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      CustomDialog.showLoading(message: 'Signing in... Please wait');
      final user = await FirebaseAuthService().signIn(email!, password!);
      if (user != null) {
        if (user.emailVerified) {
          await FireStoreServices.updateUserOnlineStatus(user.uid, true);
          UserModel? userModel = await FireStoreServices.getUser(user.uid);
          if (userModel != null) {
            if(userModel.status=='banned'){
              CustomDialog.showError(
                title: 'Account Banned',
                message: 'Your account has been banned, contact support for more information',
              );
              return;
            }
            ref.read(userProvider.notifier).setUser(userModel);
            CustomDialog.dismiss();
            if (mounted) {
              noReturnSendToPage(context, const HomePage());
            }
          } else {
            CustomDialog.showError(
                title: 'Data Error',
                message: 'Unable to get User info, try again later');
          }
        } else {
          await FirebaseAuthService.signOut();
          CustomDialog.dismiss();
          CustomDialog.showInfo(
              message:
                  'User Email account is not verified, visit you email ($email) to verify your account.',
              title: 'User Verification',
              onConfirmText: 'Send Link',
              onConfirm: () {
                sendVerification();
              });
        }
      } else {}
    }
  }

  void sendVerification() {
    FirebaseAuthService.sendEmailVerification();
    CustomDialog.dismiss();
    CustomDialog.showInfo(
        message:
            'Verification link has been sent to your email ($email), visit your email to verify your account.',
        title: 'User Verification',
        onConfirmText: 'Ok',
        onConfirm: () {
          CustomDialog.dismiss();
        });
  }
}
