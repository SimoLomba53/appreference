import 'package:flutter/material.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/features/onboarding/presentation/widgets/onboarding_step.dart';
import 'package:growingapp/pages/home/main_view_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int step = 0;

  List<Widget> onboardingSteps = const [
    OnboardingStep(
      img: '1',
      title: 'Cura il tuo Terrario',
      description:
          'Non ti preoccupare siamo qui per assisterti nella cura del tuo terrario. Segui le nostre guide e i nostri consigli.',
    ),
    OnboardingStep(
      img: '2',
      title: 'Pollice Nero?',
      description:
          'Non preoccuparti, i nostri terrari sono a prova di pollice nero. Inoltre con questa applicazione ricerai tutto il supporto necessario.',
    ),
    OnboardingStep(
      img: '3',
      title: 'Migliora il benessere',
      description:
          'Scopri il benessere che solamente un terrario riesce a dare, direttamente in casa tua.',
    ),
    OnboardingStep(
      img: '4',
      title: 'Rimani aggiornato',
      description:
          'Nell’app è presente una sezione per le news e una con i nostri contatti. In modo da tenerti sempre aggiornato.',
    ),
  ];

  _stepToNext() async {
    if (step + 1 < onboardingSteps.length) {
      setState(() {
        step++;
      });
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first-open', false);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainViewPage()),
      (route) => false,
    );
  }

  _getPercentage() {
    return (step + 1) / onboardingSteps.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getCurrentStep(),
          _stepper(),
        ],
      ),
    );
  }

  _getCurrentStep() {
    return onboardingSteps[step] ?? const SizedBox();
  }

  _stepper() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: GestureDetector(
            onTap: () {
              _stepToNext();
            },
            child: CircularPercentIndicator(
              radius: 32,
              lineWidth: 2.0,
              percent: _getPercentage(),
              center: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(120, 29, 22, 23),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2B874B),
                      Color(0xff0EAE56),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgIcon(
                    icon: "arrow-right",
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              linearGradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                    const Color(0xff2B874B),
                    const Color(0xff0EAE56),
                    if (_getPercentage() >= 0.8) const Color(0xff2B874B)
                  ]),
              rotateLinearGradient: true,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),
        ),
      ),
    );
  }
}
