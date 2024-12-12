import 'package:e_resto/dine_in-makanan.dart';
import 'package:e_resto/dine_in.dart';
import 'package:e_resto/pesanan_anda.dart';
import 'package:e_resto/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          //     builder: (context) => CheckoutScreen(
          //       selectedItems: selectedItems, // Pastikan variabel ini benar
          //       menuItems: menuItems,
          //     ),
          //   ),
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

  bool showPromo = true; // Untuk mengontrol tampilan Promo atau Best Seller
  final List<Map<String, String>> menuItems = [
    {
      "name": "Nasi Omlet",
      "price": "Rp 10.000",
      "image": "assets/images/nasiomlet.png",
      "type": "promo"
    },
    {
      "name": "Ayam Goreng",
      "price": "Rp 9.000",
      "image": "assets/images/ayamgoreng.png",
      "type": "promo"
    },
    {
      "name": "Soto Ayam",
      "price": "Rp 12.000",
      "image": "assets/images/airmineral.png",
      "type": "promo"
    },
    {
      "name": "Mie Goreng",
      "price": "Rp 8.000",
      "image": "assets/images/cocacola.png",
      "type": "promo"
    },
    {
      "name": "Telor Dadar",
      "price": "Rp 5.000",
      "image": "assets/images/telurdadar.png",
      "type": "best_seller"
    },
    {
      "name": "Nasi Goreng",
      "price": "Rp 14.000",
      "image": "assets/images/nasigoreng.png",
      "type": "best_seller"
    },
    {
      "name": "Bakso",
      "price": "Rp 13.000",
      "image": "assets/images/teamanis.png",
      "type": "best_seller"
    },
    {
      "name": "Sate Ayam",
      "price": "Rp 15.000",
      "image": "assets/images/esteh.png",
      "type": "best_seller"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredItems = menuItems
        .where((item) =>
            showPromo ? item['type'] == 'promo' : item['type'] == 'best_seller')
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // Layer Hijau dengan Background Image
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 2, 106, 5),
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/background.png"), // Ganti dengan file background Anda
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Image.asset(
                "assets/images/logo_warteg.png", // Ganti dengan file logo Anda
                height: 120, // Ukuran logo diperbesar
              ),
            ),
          ),

          // Layer Putih
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Pilihan Dine In dan Take Away
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            // Aksi untuk Dine In
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DineIn()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset("assets/images/Dinein.png",
                                    height: 50),
                                const SizedBox(height: 10),
                                const Text("Dine In"),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Aksi untuk Take Away
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DineInMakanan()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset("assets/images/take-away.png",
                                    height: 50),
                                const SizedBox(height: 10),
                                const Text("Take away"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // FilterChip
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilterChip(
                          label: const Text("Promo"),
                          selected: showPromo,
                          onSelected: (isSelected) {
                            setState(() {
                              showPromo = true;
                            });
                          },
                          selectedColor: const Color.fromARGB(255, 2, 106, 5),
                          backgroundColor: Colors.grey[300],
                          labelStyle: TextStyle(
                            color: showPromo ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 30),
                        FilterChip(
                          label: const Text("Best Seller"),
                          selected: !showPromo,
                          onSelected: (isSelected) {
                            setState(() {
                              showPromo = false;
                            });
                          },
                          selectedColor: const Color.fromARGB(255, 2, 106, 5),
                          backgroundColor: Colors.grey[300],
                          labelStyle: TextStyle(
                            color: !showPromo ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Grid Menu
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Tetap menampilkan 2 kolom
                          crossAxisSpacing: 10, // Jarak horizontal antar Card
                          mainAxisSpacing: 10, // Jarak vertikal antar Card
                          childAspectRatio:
                              0.9, // Rasio ukuran Card (ubah nilai ini untuk mengecilkan/membesarkan)
                        ),
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              // Tambahkan padding untuk mengecilkan isi Card
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.asset(
                                        item['image']!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['name']!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item['price']!,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
