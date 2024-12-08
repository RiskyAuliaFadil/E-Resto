import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final Map<int, int> selectedItems; // Item yang dipilih oleh user
  final List<Map<String, String>> menuItems; // Daftar menu

  const PaymentScreen({
    Key? key,
    required this.selectedItems,
    required this.menuItems,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMethod; // Menyimpan metode pembayaran yang dipilih

  // Menghitung total harga
  int _calculateTotal() {
    int total = 0;
    widget.selectedItems.forEach((index, quantity) {
      final price = int.parse(
          widget.menuItems[index]['price']!.replaceAll(RegExp(r'[Rp\.]'), ''));
      total += price * quantity;
    });
    return total;
  }

  // Menampilkan pesan validasi
  void _showValidationMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pilih metode pembayaran terlebih dahulu!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Pembayaran'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png', // Ganti dengan path gambar Anda
              fit: BoxFit.cover,
            ),
          ),

          // Content Layer
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Daftar pesanan
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: widget.selectedItems.length,
                  itemBuilder: (context, index) {
                    final itemIndex =
                        widget.selectedItems.keys.elementAt(index);
                    final item = widget.menuItems[itemIndex];
                    final quantity = widget.selectedItems[itemIndex]!;

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

              // Pilihan Metode Pembayaran dan Total
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey[300]!, width: 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Pilih Metode Pembayaran:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        RadioListTile<String>(
                          value: 'Cash',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                          title: const Text('Cash'),
                          activeColor: const Color.fromARGB(255, 2, 106, 5),
                        ),
                        RadioListTile<String>(
                          value: 'QRIS',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                          title: const Text('QRIS'),
                          activeColor: const Color.fromARGB(255, 2, 106, 5),
                        ),
                        RadioListTile<String>(
                          value: 'ShopeePay',
                          groupValue: _selectedPaymentMethod,
                          onChanged: (value) {
                            setState(() {
                              _selectedPaymentMethod = value;
                            });
                          },
                          title: const Text('ShopeePay'),
                          activeColor: const Color.fromARGB(255, 2, 106, 5),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Total Pembayaran dengan InkWell
                    InkWell(
                      onTap: () {
                        if (_selectedPaymentMethod == null) {
                          _showValidationMessage();
                        } else {
                          // Logika jika metode pembayaran telah dipilih
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Detail Total Pembayaran'),
                                content: Text(
                                  'Metode pembayaran: $_selectedPaymentMethod\nTotal: Rp ${_calculateTotal()}',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Tutup'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 2, 106, 5), // Warna hijau
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Teks putih
                              ),
                            ),
                            Text(
                              'Rp ${_calculateTotal()}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Teks putih
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
