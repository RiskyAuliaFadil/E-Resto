import 'package:e_resto/pesanan_anda.dart';
import 'package:flutter/material.dart';

class DineInMakanan extends StatefulWidget {
  final List<Map<String, String>> menuItems = [
    {
      'images': 'assets/images/nasigoreng.png',
      'name': 'Nasi Goreng',
      'price': 'Rp 14.000',
      'oldPrice': 'Rp 18.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/nasiomlet.png',
      'name': 'Nasi Omlet',
      'price': 'Rp 10.000',
      'oldPrice': 'Rp 12.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/telurdadar.png',
      'name': 'Telur Dadar',
      'price': 'Rp 5.000',
      'oldPrice': 'Rp 7.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/ayamgoreng.png',
      'name': 'Ayam Goreng',
      'price': 'Rp 9.000',
      'oldPrice': 'Rp 10.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/ayampecel.png',
      'name': 'Pecel Ayam',
      'price': 'Rp 15.000',
      'oldPrice': 'Rp 10.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/miegorengtelur.png',
      'name': 'Mie Goreng Telur',
      'price': 'Rp 12.000',
      'oldPrice': 'Rp 10.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/nasiputih.png',
      'name': 'Ayam Goreng',
      'price': 'Rp 5.000',
      'oldPrice': 'Rp 10.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/rendang.png',
      'name': 'Ayam Goreng',
      'price': 'Rp 10.000',
      'oldPrice': 'Rp 10.000',
      'type': 'food',
    },
    {
      'images': 'assets/images/esteh.png',
      'name': 'Lemon Tea',
      'price': 'Rp 5.000',
      'oldPrice': '',
      'type': 'drink',
    },
    {
      'images': 'assets/images/airmineral.png',
      'name': 'Air Mineral',
      'price': 'Rp 4.000',
      'oldPrice': '',
      'type': 'drink',
    },
    {
      'images': 'assets/images/kopi.png',
      'name': 'Es Capucinno',
      'price': 'Rp 5.000',
      'oldPrice': '',
      'type': 'drink',
    },
    {
      'images': 'assets/images/teamanis.png',
      'name': 'Es Teh',
      'price': 'Rp 5.000',
      'oldPrice': '',
      'type': 'drink',
    },
    {
      'images': 'assets/images/nutrisarimangga.png',
      'name': 'Nutri Sari Mangga',
      'price': 'Rp 7.000',
      'oldPrice': '',
      'type': 'drink',
    },
    {
      'images': 'assets/images/cocacola.png',
      'name': 'Coca Cola',
      'price': 'Rp 6.000',
      'oldPrice': '',
      'type': 'drink',
    },
    {
      'images': 'assets/images/nutrisarijeruk.png',
      'name': 'Nutri Sari Jeruk',
      'price': 'Rp 7.000',
      'oldPrice': '',
      'type': 'drink',
    },
    {
      'images': 'assets/images/nutrisarianggur.png',
      'name': 'Nutri Sari Anggur',
      'price': 'Rp 7.000',
      'oldPrice': '',
      'type': 'drink',
    },
  ];

  @override
  State<DineInMakanan> createState() => _DineInMakananState();
}

class _DineInMakananState extends State<DineInMakanan> {
  int _selectedIndex = 0;
  Map<int, int> selectedItems = {}; // Key: Index item, Value: Quantity
  bool showFood =
      true; // Menentukan apakah makanan atau minuman yang akan ditampilkan

  // Fungsi untuk menghitung total pembelian
  double _calculateTotal() {
    double total = 0.0;
    selectedItems.forEach((index, quantity) {
      final priceString = widget.menuItems[index]['price']!
          .replaceAll('Rp ', '')
          .replaceAll('.', '');
      final price = double.tryParse(priceString) ?? 0.0;
      total += price * quantity;
    });
    return total;
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter item berdasarkan jenis
    final filteredItems = widget.menuItems
        .asMap()
        .entries
        .where((entry) =>
            (showFood && entry.value['type'] == 'food') ||
            (!showFood && entry.value['type'] == 'drink'))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        // Background Decoration
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Path ke gambar background
            fit: BoxFit.cover, // Gambar akan memenuhi seluruh layar
          ),
        ),
        child: Stack(
          children: [
            // FilterChip untuk makanan dan minuman
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilterChip(
                    label: const Text('Makanan'),
                    selected: showFood,
                    onSelected: (isSelected) {
                      setState(() {
                        showFood = true; // Menampilkan makanan
                      });
                    },
                    selectedColor: const Color.fromARGB(255, 2, 106, 5),
                    backgroundColor: Colors.grey[300],
                    labelStyle: TextStyle(
                      color: showFood ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilterChip(
                    label: const Text('Minuman'),
                    selected: !showFood,
                    onSelected: (isSelected) {
                      setState(() {
                        showFood = false; // Menampilkan minuman
                      });
                    },
                    selectedColor: const Color.fromARGB(255, 2, 106, 5),
                    backgroundColor: Colors.grey[300],
                    labelStyle: TextStyle(
                      color: !showFood ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // GridView Menu
            Padding(
              padding: const EdgeInsets.only(
                  top: 60, bottom: 80), // Space for total container
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final entry = filteredItems[index];
                  final item = entry.value;
                  final originalIndex = entry.key;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(item['images']!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                item['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                item['price']!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedItems[originalIndex] =
                                        (selectedItems[originalIndex] ?? 0) + 1;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 2, 106, 5),
                                  minimumSize: const Size(double.infinity, 30),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Container Total Pembelian (Tetap di Bawah)
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  // Aksi ketika InkWell ditekan (contoh: navigasi ke halaman checkout)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                              selectedItems: selectedItems,
                              menuItems: widget.menuItems,
                            )),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 2, 106, 5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Keranjang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total: Rp ${_calculateTotal().toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
