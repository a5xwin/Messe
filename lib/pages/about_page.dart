import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Lottie.asset(
                  'assets/about.json',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Created with ❤️ by ash!',
                style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              _buildInfoCard(
                context,
                icon: Icons.code,
                text: 'Liked it? Drop a ☆ on GitHub :)',
                url: 'https://github.com/a5xwin/Messe',
              ),
              _buildInfoCard(
                context,
                icon: Icons.email,
                text: 'Got thoughts? I’m all ears.',
                isEmail: true,
              ),
              _buildInfoCard(
                context,
                icon: Icons.public,
                text: 'Check out the rest of my stuff.',
                url: 'https://ashwinsajeev.onrender.com/',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String text,
    String? url,
    bool isEmail = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          text,
          style: TextStyle(
            fontFamily: 'Nothing',
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        onTap: url != null
            ? () => _launchURL(url)
            : isEmail
                ? () => _launchURL('mailto:$text')
                : null,
      ),
    );
  }
}