import 'package:flutter/material.dart';

import '../data/database.dart';
import '../widget/reuseable_button.dart';
import 'checkout.dart';
import 'newaddress.dart'; // Ensure this import path is correct

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  late Future<List<Map<String, dynamic>>> _addressesFuture;
  int? _selectedAddressId;
  Map<String, dynamic>? _selectedAddress;
  final AddressStorage _addressStorage = AddressStorage();

  @override
  void initState() {
    super.initState();
    _addressesFuture = _addressStorage.getAllAddresses();
  }

  void _refreshAddresses() {
    setState(() {
      _addressesFuture = _addressStorage.getAllAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: _refreshAddresses,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _addressesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final addresses = snapshot.data!;
                  if (addresses.isEmpty) {
                    return const Center(child: Text('No addresses found'));
                  }
                  return ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      final int id = address['id'];
                      final bool isSelected = _selectedAddressId == id;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: isSelected ? Colors.blue[100] : null,
                          child: ListTile(
                            title: Text('${address['street']}, ${address['city']}'),
                            subtitle: Text('${address['state']}, ${address['zip']}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                await _addressStorage.deleteAddress(id);
                                if (_selectedAddressId == id) {
                                  _selectedAddressId = null;
                                }
                                _refreshAddresses();
                              },
                            ),
                            onTap: () {
                              setState(() {
                                _selectedAddressId = id;
                                _selectedAddress = address;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReuseableButton(
              text: "Add New Address",
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewAddress()),
                );
                _refreshAddresses(); // Refresh after return
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReuseableButton(
              text: "CheckOut",
              onTap: _selectedAddressId != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(selectedAddress: _selectedAddress),
                  ),
                );
              }
                  : null,
              enabled: _selectedAddressId != null,
              buttonColor: _selectedAddressId != null ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// import '../data/database.dart';
// import '../widget/reuseable_button.dart';
// import 'checkout.dart';
// import 'newaddress.dart'; // Ensure this import path is correct
//
// class AddressListScreen extends StatefulWidget {
//   const AddressListScreen({super.key});
//
//   @override
//   _AddressListScreenState createState() => _AddressListScreenState();
// }
//
// class _AddressListScreenState extends State<AddressListScreen> {
//   late Future<List<Map<String, dynamic>>> _addressesFuture;
//   int? _selectedAddressId;
//   Map<String, dynamic>? _selectedAddress;
//
//   @override
//   void initState() {
//     super.initState();
//     _addressesFuture = DatabaseHelper.instance.getAllAddresses();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Address List'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.refresh_outlined),
//             onPressed: () {
//               setState(() {
//                 _addressesFuture = DatabaseHelper.instance.getAllAddresses();
//               });
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: FutureBuilder<List<Map<String, dynamic>>>(
//               future: _addressesFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else if (snapshot.hasData) {
//                   final addresses = snapshot.data!;
//                   if (addresses.isEmpty) {
//                     return const Center(child: Text('No addresses found'));
//                   }
//                   return ListView.builder(
//                     itemCount: addresses.length,
//                     itemBuilder: (context, index) {
//                       final address = addresses[index];
//                       bool isSelected = _selectedAddressId == address['id'];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Card(
//                           color: isSelected
//                               ? Colors.blue[100]
//                               : null, // Highlight if selected
//                           child: ListTile(
//                             title: Text(
//                                 '${address['street']}, ${address['city']}'),
//                             subtitle:
//                                 Text('${address['state']}, ${address['zip']}'),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () {
//                                 DatabaseHelper.instance
//                                     .deleteAddress(address['id'] as int);
//                                 setState(() {
//                                   _addressesFuture =
//                                       DatabaseHelper.instance.getAllAddresses();
//                                   if (_selectedAddressId == address['id']) {
//                                     _selectedAddressId =
//                                         null; // Deselect if currently selected address is deleted
//                                   }
//                                 });
//                               },
//                             ),
//                             // In the AddressListScreen
//                             onTap: () {
//                               setState(() {
//                                 _selectedAddressId = address['id'];
//                                 _selectedAddress =
//                                     address; // Store the entire address map
//                               });
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(child: Text('No data'));
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ReuseableButton(
//               text: "Add New Address",
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const NewAddress()),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ReuseableButton(
//               text: "CheckOut",
//               onTap: _selectedAddressId != null
//                   ? () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               Checkout(selectedAddress: _selectedAddress),
//                         ),
//                       );
//                     }
//                   : null,
//               enabled: _selectedAddressId != null,
//               buttonColor:
//                   _selectedAddressId != null ? Colors.black : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
