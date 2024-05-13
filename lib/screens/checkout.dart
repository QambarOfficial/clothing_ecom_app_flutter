import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:Fashan/screens/thankyou.dart';
import 'package:Fashan/widget/reuseable_button.dart';
import 'package:Fashan/utils/constants.dart';
import 'package:Fashan/model/base_model.dart';
import '../data/app_data.dart';

class Checkout extends StatefulWidget {
  final Map<String, dynamic>? selectedAddress;

  const Checkout({super.key, this.selectedAddress});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  double calculateTotal() {
    double total = 0.0;
    for (BaseModel item in itemsOnCart) {
      total += item.price * item.value;
    }
    return total;
  }

  String _selectedPaymentMethod = 'COD';
  Map<String, IconData> paymentOptions = {
    'Card Payment': LineIcons.creditCard,
    'PayPal': LineIcons.paypal,
    'UPI': LineIcons.mobilePhone,
    'COD': Icons.currency_rupee_outlined,
  };

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _upiController = TextEditingController();
  final TextEditingController _paypalEmailController = TextEditingController();

  InputDecoration _buildInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      hintText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildPayPalInputForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _paypalEmailController,
        decoration: _buildInputDecoration('PayPal Email', LineIcons.paypal),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _buildCODInputForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 66,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LineIcons.check, color: Color(0xFF43D19E)),
            SizedBox(
              width: 5,
            ),
            Text(
              'Cash On Delivery: Available',
              style: TextStyle(
                color: Color(0xFF43D19E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardInputForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _cardNumberController,
            decoration:
                _buildInputDecoration('Card Number', LineIcons.creditCard),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _expiryDateController,
            decoration:
                _buildInputDecoration('Expiry Date', LineIcons.calendar),
            keyboardType: TextInputType.datetime,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _cvvController,
            decoration: _buildInputDecoration('CVV', LineIcons.lock),
            keyboardType: TextInputType.number,
            obscureText: true,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text("Select Payment Method",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        ...paymentOptions.entries.map((entry) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              title: Text(entry.key),
              leading: Radio<String>(
                value: entry.key,
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  }
                },
              ),
              trailing: Icon(entry.value, color: primaryColor),
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Checkout",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.selectedAddress != null) const SizedBox(height: 10),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: itemsOnCart.length,
              itemBuilder: (context, index) {
                BaseModel item = itemsOnCart[index];
                return ListTile(
                  leading: Image.asset(item.imageUrl, width: 50, height: 50),
                  title: Text(
                    item.name,
                    overflow: TextOverflow.fade,
                  ),
                  subtitle:
                      Text("₹${item.price.toStringAsFixed(2)} x ${item.value}"),
                  trailing:
                      Text("₹${(item.price * item.value).toStringAsFixed(2)}"),
                );
              },
            ),
            _buildPaymentOptions(),
            if (_selectedPaymentMethod == 'Card Payment') _buildCardInputForm(),
            if (_selectedPaymentMethod == 'COD') _buildCODInputForm(),
            if (_selectedPaymentMethod == 'UPI')
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _upiController,
                  decoration:
                      _buildInputDecoration('UPI ID', LineIcons.mobilePhone),
                  keyboardType: TextInputType.text,
                ),
              ),
            if (_selectedPaymentMethod == 'PayPal') _buildPayPalInputForm(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Total: ₹${calculateTotal().toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.titleLarge),
                  //address
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: primaryColor,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        'Shipping to:\n${widget.selectedAddress!['street']}, ${widget.selectedAddress!['city']}, ${widget.selectedAddress!['state']}, ${widget.selectedAddress!['zip']}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ReuseableButton(
                    text: 'Proceed to Payment',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThankYouPage(
                            title: 'Thank You',
                            selectedAddress: widget.selectedAddress,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
