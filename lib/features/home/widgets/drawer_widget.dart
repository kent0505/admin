import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/router.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/action/app_title.dart';
import '../../../core/widgets/action/logo_widget.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _DrawerHeader(),
          ListTile(
            onTap: () {
              context.push(AppRoutes.userPage);
            },
            leading: const Icon(Icons.person),
            title: const Text('User'),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTitle(
            title: Const.appTitle,
            white: true,
          ),
          const LogoWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.person,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: AppTitle(
                  title: username,
                  white: true,
                ),
              ),
              Tooltip(
                message: Const.tooltipLogout,
                child: IconButton(
                  onPressed: () {
                    showAlertDialog(
                      context,
                      Const.alertLogout,
                      () async {
                        await saveData('token', '').then((_) {
                          context.go(AppRoutes.authPage);
                        });
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
