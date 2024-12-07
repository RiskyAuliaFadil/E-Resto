import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final Map<int, int> selectedItems; // Item yang dipilih oleh user
  final List<Map<String, String>> menuItems; // Daftar menu

  const PaymentScreen({
    Key? key,
    required this.selectedItems,
    required this.menuItems,
  }) : super(key: key);

  // Menghitung total harga
  int _calculateTotal() {
    int total = 0;
    selectedItems.forEach((index, quantity) {
      final price = int.parse(
          menuItems[index]['price']!.replaceAll(RegExp(r'[Rp\.]'), ''));
      total += price * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Pembayaran'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Daftar pesanan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final itemIndex = selectedItems.keys.elementAt(index);
                final item = menuItems[itemIndex];
                final quantity = selectedItems[itemIndex]!;

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  elevation: 2,
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['images']!,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${quantity}x Rp ${item['price']}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          ),

          // Container Total Pembayaran
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Total: Rp ${_calculateTotal()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Tombol pembayaran
                Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Tambahkan logika untuk pembayaran cash
                      },
                      icon: const Icon(Icons.attach_money),
                      label: const Text('Cash',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 106, 5),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Tambahkan logika untuk pembayaran QRIS
                      },
                      icon: const Icon(Icons.qr_code),
                      label: const Text('QRIS',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 106, 5),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Tambahkan logika untuk pembayaran e-wallet (GoPay/ShopPay)
                      },
                      icon: const Icon(Icons.wallet),
                      label: const Text('GoPay/ShopPay',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 106, 5),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
