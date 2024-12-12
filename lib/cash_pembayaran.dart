import 'package:e_resto/beranda.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  final String paymentMethod; // Example: "Cash"
  final List<Map<String, dynamic>>
      orderDetails; // Example: [{"name": "Ayam Goreng", "price": 9000, "quantity": 1}]

  PaymentSuccessPage({
    required this.paymentMethod,
    required this.orderDetails,
  });

  @override
  Widget build(BuildContext context) {
    int subtotal = orderDetails.fold(0, (sum, item) {
      final int price = item['price'] ?? 0;
      final int quantity = item['quantity'] ?? 0;
      return sum + (price * quantity);
    });

    return Scaffold(
      body: Stack(
        children: [
          // Layer pertama: Background hijau dengan gambar
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 2, 106, 5),
            child: Image.asset(
              "assets/images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          // Layer kedua: Konten utama
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circle dengan ikon centang
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),
                ),
                SizedBox(height: 20),
                // Teks "Pembayaran Berhasil"
                Text(
                  "Pembayaran Berhasil",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                // Tampilkan metode pembayaran
                Text(
                  "Metode: $paymentMethod",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                // Tabel ringkasan pesanan
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Ringkasan Pesanan",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ...orderDetails.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${item['quantity']}x ${item['name']}"),
                              Text("Rp ${item['price'] * item['quantity']}"),
                            ],
                          ),
                        );
                      }).toList(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Rp $subtotal"),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Tombol kembali
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), // Ganti HomePage dengan widget halaman beranda Anda
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 2, 106, 5),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "Kembali ke Halaman Utama",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
