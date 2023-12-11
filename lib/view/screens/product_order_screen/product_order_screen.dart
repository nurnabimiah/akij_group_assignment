




import 'package:flutter/material.dart';



class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: shopNameController,
                decoration: InputDecoration(labelText: 'Shop Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the shop name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              Text('Items:'),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(items[index].itemName),
                      subtitle: Text('Quantity: ${items[index].quantity}'),
                    );
                  },
                ),
              ),
              if (items.length < 10)
                ElevatedButton(
                  onPressed: () => _addItem(context),
                  child: Text('Add Item'),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitOrder(context),
                child: Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _addItem(BuildContext context) async {
    if (items.length < 1) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddItemScreen()),
      );

      if (result != null && result is Item) {
        setState(() {
          items.add(result);
        });
      }
    } else {
      // Show a message or dialog indicating that only 10 items are allowed.
      // You can use Flutter's built-in dialog or a Snackbar for this purpose.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You can only add up to 10 items in a single order.'),
        ),
      );
    }
  }


  // void _addItem(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => AddItemScreen()),
  //   );
  //
  //   if (result != null && result is Item) {
  //     setState(() {
  //       items.add(result);
  //     });
  //   }
  // }

  void _submitOrder(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Build and show the raw JSON data in another screen
      Map<String, dynamic> orderData = {
        'shopName': shopNameController.text,
        'phoneNumber': phoneNumberController.text,
        'items': items.map((item) => item.toJson()).toList(),
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummaryScreen(orderData),
        ),
      );
    }
  }
}

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(labelText: 'Item Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _addItem(context),
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }




void _addItem(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Item(
          itemName: itemNameController.text,
          quantity: int.parse(quantityController.text),
        ),
      );
    }
  }
}


class Item {
  final String itemName;
  final int quantity;

  Item({
    required this.itemName,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'quantity': quantity,
    };
  }
}

class OrderSummaryScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  OrderSummaryScreen(this.orderData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Shop Name: ${orderData['shopName']}'),
            Text('Phone Number: ${orderData['phoneNumber']}'),
            Text('Items:'),
            Expanded(
              child: ListView.builder(
                itemCount: orderData['items'].length,
                itemBuilder: (context, index) {
                  var item = orderData['items'][index];
                  return ListTile(
                    title: Text(item['itemName']),
                    subtitle: Text('Quantity: ${item['quantity']}'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Form'),
            ),
          ],
        ),
      ),
    );
  }
}
