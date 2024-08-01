import 'package:flutter/material.dart';
import 'package:optica_app/src/screens/scan.dart';

class InfoScreen extends StatefulWidget {
  final VoidCallback onBack;

  InfoScreen({required this.onBack});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _pulsateController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulsateAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _pulsateController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _pulsateAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulsateController,
        curve: Curves.easeInOut,
      ),
    );

    _fadeController.forward();
    _pulsateController.forward().then((_) {
      _pulsateController.dispose();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    if(_pulsateController.isAnimating) {
      _pulsateController.dispose();
    }
    super.dispose();
  }

  final List<String> points = [
    'Point 1: Ensure the fundoscope and smartphone lens are clean and free '
        'of smudges or debris.',
    'Point 2: Gently pull down the lower eyelid and apply one to two drops of the dilating agent.',
    'Point 3: Allow 15-30 minutes for the pupils to fully dilate.',
    "Point 4: Securely attach the fundoscope to the smartphone's camera lens, ensuring ",
    "Point 5: Position the smartphone fundoscope close to the patient's eye, maintaining a steady hand.",
    'Point 6: Capture Images, review the images for clarity and completeness, Run diagnosis',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: widget.onBack,
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[900]!, Colors.deepPurple[700]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _pulsateAnimation,
                    child: Text(
                      'Guidelines',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: points.map((point) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.deepPurple[200],
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              point,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScanScreen(
                            onBack: widget.onBack,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple[600],
                      backgroundColor: Colors.white, // Button text color
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        // fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
