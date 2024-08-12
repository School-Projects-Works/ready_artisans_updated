import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/state_managers/navigation_state.dart';
import '../../components/custom_input.dart';
import '../../constant/strings.dart';
import '../../styles/app_colors.dart';
import '../../generated/assets.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Center(
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
                    Text('RESET PASSWORD',
                        style: GoogleFonts.alfaSlabOne(
                            decoration: TextDecoration.underline,
                            fontSize: 25,
                            color: secondaryColor)),
                    const SizedBox(height: 15),
                    CustomTextFields(
                      label: 'Email',
                      prefixIcon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !emailRegEx.hasMatch(value)) {
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
                    ElevatedButton(
                      onPressed: () => reset(),
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
                        'Reset',
                        style: GoogleFonts.nunito(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        text: 'Go back',
                        style: GoogleFonts.nunito(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            ref.read(authNavProvider.notifier).state = 0;
                          },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  reset() {}
}
