import 'package:get/get.dart';
import 'package:tic_tac_toe/src/modules/about_of/control/about_of_bindings.dart';
import 'package:tic_tac_toe/src/modules/about_of/presentation/page/about_of_view.dart';
import 'package:tic_tac_toe/src/modules/game_alone/view/game_alone_view.dart';
import 'package:tic_tac_toe/src/modules/game_online/controllers/game_online_bindings.dart';
import 'package:tic_tac_toe/src/modules/game_online/view/game_online_view.dart';
import 'package:tic_tac_toe/src/modules/rules/controller/rules_bindings.dart';
import 'package:tic_tac_toe/src/modules/rules/view/rules_view.dart';
import '../..//modules/home/controllers/home_bindings.dart';
import '../..//modules/home/view/home_view.dart';
import '../..//modules/settings/controllers/settings_bindings.dart';
import '../..//modules/settings/view/settings_view.dart';

import '../../modules/auth/login/controllers/login_bindings.dart';
import '../../modules/auth/login/view/login_view.dart';
import '../../modules/auth/sign_up/controllers/sign_up_bindinds.dart';
import '../../modules/auth/sign_up/view/sign_up_view.dart';
import '../../modules/game_alone/controllers/game_alone_bindings.dart';
import '../../modules/splash_screen/controllers/splash_screen_bindings.dart';
import '../../modules/splash_screen/view/splash_screen_view.dart';
import 'routes.dart';

class AppPages {
  ///
  static List<GetPage<dynamic>> getApplicacionRoutes() => <GetPage<dynamic>>[
        GetPage<SplashScreenView>(
          name: Routes.splashScreen,
          page: () => const SplashScreenView(),
          binding: SplashScreenBindings(),
        ),
        GetPage<LoginView>(
          name: Routes.login,
          page: () => const LoginView(),
          binding: LoginBindings(),
        ),
        GetPage<SignUpView>(
          name: Routes.signUp,
          page: () => const SignUpView(),
          binding: SignUpBindinds(),
        ),
        GetPage<HomeView>(
          name: Routes.home,
          page: () => const HomeView(),
          binding: HomeBindings(),
        ),
        GetPage<SettingsView>(
          name: Routes.settings,
          page: () => const SettingsView(),
          binding: SettingsBindings(),
        ),
        GetPage<AboutOfView>(
          name: Routes.aboutOf,
          page: () => const AboutOfView(),
          binding: AboutOfBindings(),
        ),
        GetPage<GameAloneView>(
          name: Routes.gameAlone,
          page: () => const GameAloneView(),
          binding: GameAloneBindings(),
        ),
        GetPage<GameOnlineView>(
          name: Routes.gameGroup,
          page: () => const GameOnlineView(),
          binding: GameOnlineBindings(),
        ),
        GetPage<RulesView>(
          name: Routes.rules,
          page: () => const RulesView(),
          binding: RulessBindings(),
        ),
      ];
}
