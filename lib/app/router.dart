import 'package:ev_bul/views/add_view/add_view.dart';
import 'package:ev_bul/views/app_view.dart';
import 'package:ev_bul/views/home_view/home_view.dart';
import 'package:ev_bul/views/login_view/login_view.dart';
import 'package:ev_bul/views/profil_view/profil_view.dart';
import 'package:ev_bul/views/splash/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: 'splash',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => const LoginView(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppView(navigatonShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.add,
              name: 'add',
              builder: (context, state) => const AddView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profil,
              name: 'profil',
              builder: (context, state) => const ProfilView(),
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final user = FirebaseAuth.instance.currentUser;
        final loggingIn = state.uri.toString() == AppRoutes.login;

        if (user == null) {
          return loggingIn ? null : AppRoutes.login;
        }
        if (loggingIn) return AppRoutes.home;
        return null;
      },
    ),
  ],
);

class AppRoutes {
  AppRoutes._();
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String add = '/add';
  static const String profil = '/profil';
}
