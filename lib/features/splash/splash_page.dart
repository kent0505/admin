import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../core/constants/constants.dart';
import '../../core/router/app_routes.dart';
import '../../core/utils.dart';
import '../../core/widgets/action/logo_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future _check() async {
    await Utils.getToken();

    final decodedToken = JwtDecoder.tryDecode(Const.token);

    final now = DateTime.now().millisecondsSinceEpoch / 1000;

    if (Const.token.isNotEmpty && decodedToken != null) {
      if (decodedToken['expiry'] >= now) {
        Future.delayed(const Duration(seconds: 2), () {
          context.go(AppRoutes.homePage);
        });
        return;
      }
    }

    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRoutes.authPage);
    });
  }

  @override
  void initState() {
    super.initState();
    _check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 20),
            Text(
              Const.appTitle,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                fontFamily: 'Silkscreen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
