import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/pages/welcome_page/sign_up_page.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import '../../styles/Widgets/bezier_container.dart';
import '../../state_managers/navigation_state.dart';
import 'forgot_password.dart';
import 'login_page.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 30,
                          child: Icon(
                            Icons.exit_to_app,
                            size: 24,
                            color: Colors.white,
                          )),
                      const SizedBox(height: 10),
                      Text(
                        'Do you want to exit an App ?',
                        style: GoogleFonts.nunito(
                            fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ));
  }

  final EdgeInsets _viewInsets = EdgeInsets.zero;
  FlutterView? window;
  @override
  void initState() {
    super.initState();
    // window = View.of(context);
    // window?.onMetricsChanged = () {
    //   if (mounted) {
    //     setState(() {
    //       final window = this.window;
    //       if (window != null) {
    //         _viewInsets = EdgeInsets.fromWindowPadding(
    //           window.viewInsets,
    //           window.devicePixelRatio,
    //         ).add(EdgeInsets.fromWindowPadding(
    //           window.padding,
    //           window.devicePixelRatio,
    //         )) as EdgeInsets;
    //       }
    //     });
    //   }
    // };
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () => _showExitDialog(context),
        child: Scaffold(
            backgroundColor: primaryColor,
            body: SizedBox(
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: -size.height * .15,
                      right: -size.width * .4,
                      child: const StyleShape(
                        color: [Colors.white, Colors.white],
                      )),
                  Positioned(
                    top: 50,
                    left: 0,
                    child: Tooltip(
                      message: 'Exit',
                      textStyle:
                          GoogleFonts.nunito(fontSize: 15, color: Colors.white),
                      child: IconButton(
                        icon: const Icon(FontAwesomeIcons.arrowLeft),
                        color: Colors.white,
                        onPressed: () => _showExitDialog(context),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: _viewInsets.bottom),
                        child: IndexedStack(
                          index: ref.watch(authNavProvider),
                          children: const [
                            LoginPage(),
                            SignUpPage(),
                            ForgotPasswordPage()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
