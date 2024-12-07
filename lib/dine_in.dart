import 'package:e_resto/dine_in-makanan.dart';
import 'package:flutter/material.dart';

class DineIn extends StatefulWidget {
  const DineIn({super.key});

  @override
  State<DineIn> createState() => _DineInState();
}

class _DineInState extends State<DineIn> {
  int _selectedIndex = 0;
  int? _selectedTable; // Variabel untuk menyimpan meja yang dipilih

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTableSelected(int tableNumber) {
    setState(() {
      _selectedTable = tableNumber;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Meja $_selectedTable dipilih')),
    );
  }

  void _onPilihButtonPressed() {
    if (_selectedTable == null) {
      // Jika tidak ada meja yang dipilih, tampilkan peringatan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap pilih meja terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      // Navigasi ke halaman berikutnya jika meja telah dipilih
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DineInMakanan()), //selectedTable: _selectedTable!
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dine In"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'), // Path gambar
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Pilih Meja",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => _onTableSelected(index + 1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedTable == index + 1
                            ? const Color.fromARGB(255, 95, 109, 120)
                            : const Color.fromARGB(255, 2, 106, 5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ElevatedButton(
                onPressed: _onPilihButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 2, 106, 5),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "PILIH",
                  style: TextStyle(fontSize: 18, color: Colors.white),
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

// Halaman berikutnya
// class NextPage extends StatelessWidget {
//   final int selectedTable;

//   const NextPage({required this.selectedTable});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Meja yang Dipilih"),
//       ),
//       body: Center(
//         child: Text(
//           'Anda memilih Meja $selectedTable',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
