import '../../../router/router.dart';
import 'package:flutter/material.dart';
import '../../../styles/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';


class AdminMain extends ConsumerWidget {
  const AdminMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Ready Artisans Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      builder: FlutterSmartDialog.init(),
      routerConfig: MyRouter(context: context, ref: ref).router(),
    );
  }
}
