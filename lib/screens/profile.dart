import 'package:flutter/material.dart';
import 'package:clothing_ecom_app_flutter/utils/constants.dart';
import 'package:clothing_ecom_app_flutter/utils/app_theme.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Custom DrawerHeader with zero padding/margin
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(color: primaryColor),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                    AssetImage('assets/images/qambar.png'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Qambar Abbas',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'ANDROID DEVELOPER',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SourceSansPro',
                      color: Colors.tealAccent,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Your list tiles...
          CardTile(
            icon: Icons.phone_outlined,
            title: '+91 8510842558',
            onTap: () =>
                _showCopyDialog(context, 'Phone Number', '+91 8510842558'),
          ),
          CardTile(
            icon: Icons.account_circle_outlined,
            title: 'LinkedIn Qambar Abbas',
            onTap: () => _launchWeb(
                context, 'https://www.linkedin.com/in/qambar-abbas-500438307'),
          ),
          CardTile(
            icon: Icons.email_outlined,
            title: 'qambarofficial313@gmail.com',
            onTap: () => _showCopyDialog(
              context,
              'Email',
              'qambarofficial313@gmail.com\n\nSubject: Need Flutter developer\nBody: Please contact me',
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchWeb(BuildContext context, String urlStr) async {
    final uri = Uri.parse(urlStr);
    final theme = Theme.of(context);
    try {
      await launchUrl(
        uri,
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: theme.primaryColor,
          ),
          shareState: CustomTabsShareState.on,
          urlBarHidingEnabled: true,
          showTitle: true,
          closeButton: CustomTabsCloseButton(
            icon: CustomTabsCloseButtonIcons.back,
          ),
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: theme.primaryColor,
          preferredControlTintColor: theme.colorScheme.onPrimary,
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (_) {
      _showCopyDialog(context, 'Error', 'Could not open the link.');
    }
  }

  void _showCopyDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: SelectableText(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CardTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.teal),
      title: Text(title, style: TextStyle(color: Colors.teal.shade900)),
    );
  }
}
