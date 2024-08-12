import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ready_artisans/pages/home_page/home_page.dart';
import 'package:ready_artisans/pages/welcome_page/welcome_page.dart';
import 'package:ready_artisans/state_managers/location_data_state.dart';
import 'package:ready_artisans/styles/app_colors.dart';
import 'package:ready_artisans/models/user_model.dart';
import 'package:ready_artisans/services/firebase_auth_services.dart';
import 'package:ready_artisans/services/firestore_services.dart';
import 'package:ready_artisans/state_managers/user_data_state.dart';
import 'admin/main/views/admin_main.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _initUser() async {
    //final Random _random = Random();
    //var cat = CategoryModel.dummyData;
    // for (var c in cat) {
    //   c.id = FireStoreServices.getDocumentId('categories');
    //   await FireStoreServices.addCategory(c);
    // }
    // List<UserModel> artisans = await FireStoreServices.getAllArtisans();

    // for (var user in artisans) {
    //   for (int i = 0; i < 5; i++) {
    //     var sender = artisans[_random.nextInt(artisans.length)];
    //     ReviewModel review = ReviewModel(
    //       id: FireStoreServices.getDocumentId('reviews'),
    //       artisanId: user.id,
    //       senderId: sender.id,
    //       message: messages[_random.nextInt(messages.length)],
    //       senderImage: sender.image,
    //       senderName: sender.name,
    //       rating: 1.5 + _random.nextDouble() * (5.0 - 1.5),
    //       createdAt: DateTime.now().millisecondsSinceEpoch,
    //     );
    //     await FireStoreServices.addReview(review);
    //   }
    // }
    // for (var user in artisans) {
    //   user.id = FireStoreServices.getDocumentId('users');
    //   user.createdAt = DateTime.now().toUtc().millisecondsSinceEpoch;
    //   await FireStoreServices.saveUser(user);
    // }

    var location = ref.watch(locationStreamProvider);
    if (FirebaseAuthService.isUserLogin()) {
      var user = FirebaseAuthService.getCurrentUser();
      //set user Online
      await FireStoreServices.setUserOnline(user.uid);
      UserModel userData = await FireStoreServices.getUserData(user.uid);
      
      //update user location
      location.whenData((location) async {
        if (location.latitude != null && location.longitude != null) {
          userData = userData.copyWith(
            location: location.toMap(),
            latitude: location.latitude,
            longitude: location.longitude,
            city: location.city,
            region: location.region,
          );
          await FireStoreServices.updateUserLocation(userData);
        }
      });

      //check if widget is build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.watch(userProvider.notifier).setUser(userData);
      });
      return true;
            } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const AdminMain();
    }
    return MaterialApp(
      title: 'Ready Artisans',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        indicatorColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.black87),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 5,
          margin: const EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black87),
        canvasColor: primaryColor,
      ),
      builder: FlutterSmartDialog.init(),
      home: FutureBuilder<bool>(
          future: _initUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                return const HomePage();
              } else {
                return const WelcomePage();
              }
            } else {
              return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
