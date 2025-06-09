import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../data/database.dart';
import '../utils/constants.dart';
import '../widget/reuseable_button.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({super.key});

  @override
  _NewAddressState createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  final AddressStorage _addressStorage = AddressStorage();

  @override
  void dispose() {
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    super.dispose();
  }

  void _addAddress() async {
    if (streetController.text.isEmpty ||
        cityController.text.isEmpty ||
        stateController.text.isEmpty ||
        zipController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    await _addressStorage.addAddress(
      street: streetController.text,
      city: cityController.text,
      state: stateController.text,
      zip: zipController.text,
    );


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Address added successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // Clear fields after saving
    streetController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();

    // Navigate back after saving (optional)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Your Address',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Please fill in your address details below:",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: primaryColor),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  TextField(
                    controller: streetController,
                    decoration: const InputDecoration(
                      labelText: 'Street Address',
                      prefixIcon: Icon(LineIcons.road),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      prefixIcon: Icon(LineIcons.city),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: stateController,
                    decoration: const InputDecoration(
                      labelText: 'State',
                      prefixIcon: Icon(LineIcons.alternateMapMarked),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: zipController,
                    decoration: const InputDecoration(
                      labelText: 'ZIP Code',
                      prefixIcon: Icon(LineIcons.mailBulk),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReuseableButton(
              text: 'Add Address',
              onTap: _addAddress,
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
//
// import '../data/database.dart';
// import '../utils/constants.dart';
// import '../widget/reuseable_button.dart';
//
// class NewAddress extends StatefulWidget {
//   const NewAddress({super.key});
//
//   @override
//   _NewAddressState createState() => _NewAddressState();
// }
//
// class _NewAddressState extends State<NewAddress> {
//   final TextEditingController streetController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController zipController = TextEditingController();
//
//   @override
//   void dispose() {
//     streetController.dispose();
//     cityController.dispose();
//     stateController.dispose();
//     zipController.dispose();
//     super.dispose();
//   }
//
//   void _addAddress() async {
//     if (streetController.text.isEmpty ||
//         cityController.text.isEmpty ||
//         stateController.text.isEmpty ||
//         zipController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Please fill in all fields"),
//             backgroundColor: Colors.red),
//       );
//       return;
//     }
//
//     await DatabaseHelper.instance.addAddress(
//       streetController.text,
//       cityController.text,
//       stateController.text,
//       zipController.text,
//     );
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//           content: Text("Address added successfully!"),
//           backgroundColor: Colors.green),
//     );
//
//     // Clear the text fields after adding the address
//     streetController.clear();
//     cityController.clear();
//     stateController.clear();
//     zipController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter Your Address',
//             style: Theme.of(context).textTheme.titleLarge),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               "Please fill in your address details below:",
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineLarge
//                   ?.copyWith(color: primaryColor),
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextField(
//                       controller: streetController,
//                       decoration: const InputDecoration(
//                         labelText: 'Street Address',
//                         prefixIcon: Icon(LineIcons.road),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextField(
//                       controller: cityController,
//                       decoration: const InputDecoration(
//                         labelText: 'City',
//                         prefixIcon: Icon(LineIcons.city),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextField(
//                       controller: stateController,
//                       decoration: const InputDecoration(
//                         labelText: 'State',
//                         prefixIcon: Icon(LineIcons.alternateMapMarked),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     TextField(
//                       controller: zipController,
//                       decoration: const InputDecoration(
//                         labelText: 'ZIP Code',
//                         prefixIcon: Icon(LineIcons.mailBulk),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ReuseableButton(
//               text: 'Add Address',
//               onTap: _addAddress,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
