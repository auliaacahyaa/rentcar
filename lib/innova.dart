import 'package:flutter/material.dart';
import 'package:rentcar/pesan.dart';

class Innova extends StatefulWidget {
  const Innova({Key? key});

  @override
  _DetailButtonState createState() => _DetailButtonState();
}

class _DetailButtonState extends State<Innova> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mobil'),
        centerTitle: true, // Mengatur judul berada di tengah
  titleSpacing: NavigationToolbar.kMiddleSpacing,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side with an Image
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                   child: Image.asset(
                      'assets/innova.jpg',
                      width: 200.0, // Set your desired width
                      height: 150.0, // Set your desired height
                      fit: BoxFit.cover,
                  ),
                ),

                // Right side with additional details or text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Innova',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Harga Sewa : Rp. 550.000',
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Transmisi: Manual',
                        style: TextStyle(
                          fontSize: 13.0, // Set text color to white
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: 380.0, // Set your desired width
            height: 290.0, // Set your desired height
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              // color: Colors.white,
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius:
                  BorderRadius.circular(10.0), // Adjust the radius as needed
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center, // Align the title to the center
                  child: Text(
                    'Persyaratan Rental Mobil',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('1. KTP', style: TextStyle(color: Colors.black)),
                Text('2. SIM A', style: TextStyle(color: Colors.black)),
                Text('3. Kartu Keluarga',
                    style: TextStyle(color: Colors.black)),
                Text('4. Kartu Tanda Pegawai (Jika Bekerja)',
                    style: TextStyle(color: Colors.black)),
                Text('5. Kartu Tanda Mahasiswa',
                    style: TextStyle(color: Colors.black)),
                Text('6. Bersedia Membayar Lunas Saat Serah Terima Mobil',
                    style: TextStyle(color: Colors.black)),
                Text('7. Bersedia Difoto Bersama Mobil Yang Disewa',
                    style: TextStyle(color: Colors.black)),
                Text('8. Bersedia Mematuhi Ketentuan Yang Berlaku',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),

          Container(
            width: 100.0, // Takes full width of the screen
            height: 40.0, // Set your desired height
            margin: EdgeInsets.all(50.0),
            child: ElevatedButton(
              onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => InputPesanan()));
                    },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent, // Set the button color to green
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(0.0), // Mengatur radius menjadi 0
                ),
              ),
              child: Text(
                'Order',
                style: TextStyle(fontSize: 18.0, color: Colors.white,  fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Centered Button
        ],
      ),
    );
  }
}