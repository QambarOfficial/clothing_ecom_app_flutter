import 'package:flutter/material.dart';
import 'package:Fashan/utils/constants.dart';
import 'package:Fashan/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/qambar.png'),
                ),
                const Text(
                  'Qambar Abbas',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Android Developer'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'SourceSansPro',
                    color: Colors.teal.shade100,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
              ],
            ),
          ),
          const CardTile(
            icon: Icons.phone_outlined,
            title: '+91 8510842558',
            onTapUrl: 'tel:+91 8510842558',
          ),
          const CardTile(
            icon: Icons.account_circle_outlined,
            title: 'LinkedIn Qambar Abbas',
            onTapUrl: 'https://www.linkedin.com/in/qambar-abbas-500438307',
          ),
          const CardTile(
            icon: Icons.email_outlined,
            title: 'qambarofficial313@gmail.com',
            onTapUrl:
                'mailto:qambarofficial313@gmail.com?subject=Need Flutter developer&body=Please contact me',
          ),
        ],
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String onTapUrl;

  const CardTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTapUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _launchURL(onTapUrl),
      leading: Icon(icon, color: Colors.teal),
      title: Text(
        title,
        style: TextStyle(color: Colors.teal.shade900),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
