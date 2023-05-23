import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_auth_flutter_firebase_ui/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

enum AppRoute { signIn, profile }

final goRouter = GoRouter(
  initialLocation: '/sign-in',
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    if (isLoggedIn) {
      if (state.location == '/sign-in') {
        return '/profile';
      }
    } else {
      if (state.location.startsWith('/profile')) {
        return '/sign-in';
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/sign-in',
      name: AppRoute.signIn.name,
      builder: (context, state) => const CustomSignInScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: AppRoute.profile.name,
      builder: (context, state) => const CustomProfileScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

final kAuthProviders = [EmailAuthProvider()];

class CustomSignInScreen extends StatelessWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: SignInScreen(
        providers: kAuthProviders,
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            context.goNamed(AppRoute.profile.name);
          }),
          AuthStateChangeAction<UserCreated>((context, state) {
            context.goNamed(AppRoute.profile.name);
          }),
        ],
      ),
    );
  }
}

class CustomProfileScreen extends StatelessWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(title: const Text('Profile')),
      providers: kAuthProviders,
      actions: [
        SignedOutAction((context) {
          context.goNamed(AppRoute.signIn.name);
        }),
      ],
    );
  }
}
