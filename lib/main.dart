import 'package:flutter/material.dart';

void main() {
  runApp(TechHelperApp());
}

class TechHelperApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ITsquad Assist',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Color(0xFFF1F5F9),
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Roboto'),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Colors.teal,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class Service {
  final String name;
  final double price;
  final IconData icon;
  final String imageUrl;

  Service({required this.name, required this.price, required this.icon, required this.imageUrl});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Service> availableServices = [
    Service(name: 'Computer Setup', price: 50, icon: Icons.computer, imageUrl: 'assets/images/computer.jpg'),
    Service(name: 'TV Setup', price: 40, icon: Icons.tv, imageUrl: 'assets/images/tv.jpg'),
    Service(name: 'Home Network Setup', price: 60, icon: Icons.wifi, imageUrl: 'assets/images/network.jpg'),
    Service(name: 'Antivirus Installation', price: 30, icon: Icons.verified_user, imageUrl: 'assets/images/antivirus.jpg'),
    Service(name: 'Complete Technical Support', price: 100, icon: Icons.support_agent, imageUrl: 'assets/images/support.jpg'),
    Service(name: 'Smartphone Setup', price: 25, icon: Icons.phone_android, imageUrl: 'assets/images/phone.jpg'),
    Service(name: 'Printer Setup', price: 35, icon: Icons.print, imageUrl: 'assets/images/printer.jpg'),
    Service(name: 'Software Installation', price: 45, icon: Icons.system_update, imageUrl: 'assets/images/software.jpg'),
    Service(name: 'Operating System Reinstallation', price: 70, icon: Icons.refresh, imageUrl: 'assets/images/OS.jpg'),
    Service(name: 'Data Backup & Recovery', price: 80, icon: Icons.backup, imageUrl: 'assets/images/backup.jpg'),
    Service(name: 'Router Configuration', price: 55, icon: Icons.router, imageUrl: 'assets/images/router.jpg'),
    Service(name: 'Email Setup', price: 20, icon: Icons.email, imageUrl: 'assets/images/email.jpg'),
    Service(name: 'Custom Technical Request', price: 120, icon: Icons.build_circle, imageUrl: 'assets/images/custom.jpg'),
  ];

  final List<Service> cart = [];
  final List<Service> wishlist = [];
  String address = '';

  void addToCart(Service service) {
    setState(() {
      cart.add(service);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${service.name} added to cart')),
    );
  }

  void removeFromCart(Service service) {
    setState(() {
      cart.remove(service);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${service.name} removed from cart')),
    );
  }

  void toggleWishlist(Service service) {
    setState(() {
      if (wishlist.contains(service)) {
        wishlist.remove(service);
      } else {
        wishlist.add(service);
      }
    });
  }

  void showWishlist() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.all(16),
        height: 400,
        child: wishlist.isEmpty
            ? Center(child: Text('Your wishlist is empty'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Wishlist',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: wishlist.length,
                itemBuilder: (context, index) {
                  final item = wishlist[index];
                  return ListTile(
                    leading: Icon(item.icon, color: Colors.teal),
                    title: Text(item.name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          wishlist.remove(item);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showReportDialog() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Report an Issue'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(hintText: 'Describe your issue...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Issue reported. Thank you!')),
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartScreen(cart: cart, address: address, removeFromCart: removeFromCart),
      ),
    );
  }

  void enterAddress() {
    TextEditingController addressController = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Enter Your Address'),
        content: TextField(
          controller: addressController,
          decoration: InputDecoration(hintText: '123 Tech Street...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                address = addressController.text;
              });
              Navigator.pop(context);
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget buildBadge({required Widget icon, required int count}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        icon,
        if (count > 0)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$count',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ITsquad Assist'),
        actions: [
          IconButton(
            icon: buildBadge(icon: Icon(Icons.favorite), count: wishlist.length),
            onPressed: showWishlist,
          ),
          IconButton(icon: Icon(Icons.report_problem), onPressed: showReportDialog),
          IconButton(icon: Icon(Icons.home), onPressed: enterAddress),
          IconButton(
            icon: buildBadge(icon: Icon(Icons.shopping_bag), count: cart.length),
            onPressed: goToCart,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            padding: EdgeInsets.all(12),
            itemCount: availableServices.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 600 ? 3 : 1,
              childAspectRatio: 1.3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return buildServiceCard(availableServices[index]);
            },
          );
        },
      ),
    );
  }

  Widget buildServiceCard(Service service) {
    final isWishlisted = wishlist.contains(service);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              service.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListTile(
            leading: Icon(service.icon, size: 30, color: Colors.teal),
            title: Text(service.name, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('\$${service.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: isWishlisted ? Colors.red : null,
                  ),
                  onPressed: () => toggleWishlist(service),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart),
                  onPressed: () => addToCart(service),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Service> cart;
  final String address;
  final Function removeFromCart;

  CartScreen({required this.cart, required this.address, required this.removeFromCart});

  double get total => cart.fold(0, (sum, item) => sum + item.price);

  void showPaymentDialog(BuildContext context) {
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Enter Card Details'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Card Number'),
              ),
              TextField(
                controller: expiryController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Expiry Date (MM/YY)'),
              ),
              TextField(
                controller: cvvController,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'CVV'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (cardNumberController.text.isEmpty ||
                  expiryController.text.isEmpty ||
                  cvvController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill all card details')),
                );
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment successful!')),
                );
              }
            },
            child: Text('Pay \$${total.toStringAsFixed(2)}'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children: [
          if (address.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.teal),
                  SizedBox(width: 8),
                  Expanded(child: Text('Delivery Address: $address')),
                ],
              ),
            ),
          Expanded(
            child: cart.isEmpty
                ? Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return Dismissible(
                  key: Key(item.name),
                  onDismissed: (direction) {
                    removeFromCart(item);
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    leading: Icon(item.icon, color: Colors.teal),
                    title: Text(item.name),
                    trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                ElevatedButton(
                  onPressed: cart.isEmpty ? null : () => showPaymentDialog(context),
                  child: Text('Pay Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
