import 'package:e_resto/beranda.dart';
import 'package:e_resto/pembayaran.dart';
import 'package:e_resto/profile.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, String>> menuItems; // Data menu
  final Map<int, int> selectedItems; // Index item dan jumlahnya

  CheckoutScreen({
    Key? key,
    required this.menuItems,
    required this.selectedItems,
  }) 
  ;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _calculateTotal() {
    int total = 0;
    widget.selectedItems.forEach((index, quantity) {
      final price = int.parse(
          widget.menuItems[index]['price']!.replaceAll(RegExp(r'[Rp\.]'), ''));
      total += price * quantity;
    });
    return total;
  }

  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      // Navigasi berdasarkan index
      switch (index) {
        case 0:
          // Stay di halaman HomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
          break;
        case 1:
          // Pindah ke halaman CheckoutScreen
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => CheckoutScreen(
          //             selectedItems: widget.selectedItem,
          //             menuItems: menuItems,
          //           )),
          // );
          break;
        case 2:
          // Pindah ke halaman ProfilePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Anda'),
        centerTitle: true,
      ),
      body: Container(
        // Background Decoration
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Path ke gambar background
            fit: BoxFit.cover, // Agar gambar memenuhi seluruh layar
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedItems.length,
                itemBuilder: (context, index) {
                  final itemIndex = widget.selectedItems.keys.elementAt(index);
                  final item = widget.menuItems[itemIndex];
                  final quantity = widget.selectedItems[itemIndex]!;

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 2, 106,
                          5), // Transparansi untuk menampilkan background
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // Kiri: Nama, Harga, Edit, Hapus
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Rp ${item['price']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Tambahkan aksi untuk edit catatan
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.selectedItems.remove(itemIndex);
                                      });
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Kanan: Gambar, Increment & Decrement
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item['images']!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) {
                                        widget.selectedItems[itemIndex] =
                                            quantity - 1;
                                      } else {
                                        widget.selectedItems.remove(itemIndex);
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white),
                                ),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.selectedItems[itemIndex] =
                                          quantity + 1;
                                    });
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Total Harga
            Container(
              color: const Color.fromARGB(255, 209, 204, 204),
              padding: const EdgeInsets.all(4), // Padding all 4
              child: InkWell(
                onTap: () {
                  if (widget.selectedItems.isEmpty) {
                    // Tampilkan pesan peringatan jika pesanan kosong
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Pesanan Kosong'),
                          content: const Text(
                              'Silakan pilih item sebelum melanjutkan ke pembayaran.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Jika pesanan tidak kosong, navigasi ke PaymentScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          selectedItems: widget.selectedItems,
                          menuItems: widget.menuItems,
                        ),
                      ),
                    );
                  }
                },
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Pilih Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        'Total Rp ${_calculateTotal()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
