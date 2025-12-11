import 'package:flutter/material.dart';
import 'package:growingapp/components/detail/detail_section.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: _buildBody(),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'Lo Showroom',
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset('assets/images/showroom.png'),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: DetailSection(
              title: 'Info',
              content: Text(
                "Immaginate di sentire il bisogno disperato di riconnettersi con la natura, i suoi odori sorprendenti, i colori confortanti e quel senso di calma che solo lei riesce a dare. con il nostro Showroom di magnifiche opere, create invece che con tempere e tele, con piante meravigliose e coloratissime. Sentite il rumore dell'acqua, e come essa scorre fra le rocce, la calma inizia a scorrere nel vostro corpo. Sedetevi con noi e osserviamo insieme la magia e la potenza di questo magnifico lavoro.",
                style: TextStyle(
                  color: Color(0xFF998F92),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: DetailSection(
              title: 'Contatti',
              content: Column(
                children: [
                  _getContact(
                    'location',
                    'Via dei Vanni 52, 50142 Firenze FI',
                    () {
                      MapsLauncher.launchQuery(
                          'Via dei Vanni, 52, 50142 Firenze FI, Italia');
                    },
                  ),
                  const Divider(
                    height: 2,
                    color: Color(0xFF998F92),
                  ),
                  _getContact(
                    'call',
                    '+39 334 714 4618',
                    () async {
                      final Uri url = Uri.parse('tel:+393347144618');
                      await launchUrl(url);
                    },
                  ),
                  const Divider(
                    height: 2,
                    color: Color(0xFF998F92),
                  ),
                  _getContact(
                    'email',
                    'info@growingartterrariums.com',
                    () async {
                      final Uri url =
                          Uri.parse('mailto:info@growingartterrariums.com');
                      await launchUrl(url);
                    },
                  ),
                  const Divider(
                    height: 2,
                    color: Color(0xFF998F92),
                  ),
                  _getContact(
                    'internet',
                    'growingartterrariums.com',
                    () async {
                      final Uri url =
                          Uri.parse('https://www.growingartterrariums.com/');
                      await launchUrl(url);
                    },
                  ),
                  const Divider(
                    height: 2,
                    color: Color(0xFF998F92),
                  ),
                  _getContact(
                    'instagram',
                    '@growingartterrariums',
                    () async {
                      final Uri url = Uri.parse(
                          'https://www.instagram.com/growingartterrariums/');
                      await launchUrl(url);
                    },
                  ),
                  const Divider(
                    height: 2,
                    color: Color(0xFF998F92),
                  ),
                  _getContact(
                    'facebook',
                    'Growing Art Terrariums',
                    () async {
                      final Uri url = Uri.parse(
                          'https://www.facebook.com/GrowingArtTerrariums/');
                      await launchUrl(url);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _getContact(String icon, String title, Function action) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SvgIcon(
              icon: icon,
              color: Theme.of(context).textTheme.headlineMedium!.color,
            ),
            const SizedBox(width: 15),
            Expanded(child: Text(title)),
            const SizedBox(width: 15),
            SvgIcon(
              icon: 'arrow-right',
              color: Theme.of(context).textTheme.headlineMedium!.color,
            ),
          ],
        ),
      ),
    );
  }
}
