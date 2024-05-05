import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/utils.dart';
import '../../core/widgets/action/logo_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future _check() async {
    await tokenValid().then((valid) {
      Future.delayed(const Duration(seconds: 2), () {
        if (valid) {
          context.go('/home');
        } else {
          context.go('/auth');
        }
      });
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
