import 'package:clothing_ecom_app_flutter/main_wrapper.dart';
import 'package:clothing_ecom_app_flutter/widget/reuseable_button.dart';
import 'package:flutter/material.dart';

class ThankYouPage extends StatefulWidget {
  final String title;
  final Map<String, dynamic>? selectedAddress; // Line to accept the address

  const ThankYouPage({super.key, required this.title, this.selectedAddress});

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                padding: const EdgeInsets.all(35),
                decoration: const BoxDecoration(
                  color: Color(0xFF43D19E),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/images/card.png",
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                "Thank You!",
                style: TextStyle(
                  color: Color(0xFF43D19E),
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              const Text(
                "Payment done Successfully",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              if (widget.selectedAddress != null)
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Your order will be delivered to this Address:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF43D19E),
                    width: 2,
                  ),
                ),
                child: Text(
                  '${widget.selectedAddress!['street']}, ${widget.selectedAddress!['city']}, ${widget.selectedAddress!['state']}, ${widget.selectedAddress!['zip']}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF43D19E),
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ReuseableButton(
                  text: 'Take me to Home',
                  onTap: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const MainWrapper(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
