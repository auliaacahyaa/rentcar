import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class LihatData extends StatefulWidget {
  const LihatData({Key? key}) : super(key: key);

  @override
  State<LihatData> createState() => _LihatDataState();
}

class _LihatDataState extends State<LihatData> {
  final notifHapus = SnackBar(
    content: Text(
      "Data Berhasil Dihapus.",
      style: TextStyle(color: Colors.black),
    ),
    duration: Duration(seconds: 3),
    padding: EdgeInsets.all(10),
    backgroundColor: Color.fromARGB(255, 183, 152, 152),
  );

  late CollectionReference pesananCollection;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    pesananCollection = firestore.collection("pesanan");
  }

  Future<dynamic> hapusData(BuildContext context, String id) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference InputPesanan = firestore.collection("pesanan");

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Hapus Data"),
          content: Text("Anda yakin ingin menghapus data ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                InputPesanan.doc(id).delete();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(notifHapus);
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  ListTile DataPemesanan(String namaMobil, String namaPembeli, String alamatPembeli,
      String jenisJasa, Timestamp tanggalPemesanan, Timestamp tanggalBerakhir, int totalHarga, String id) {
    // Format the timestamps into strings
    String formattedTanggalPemesanan = DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggalPemesanan.toDate());
    String formattedTanggalBerakhir = DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggalBerakhir.toDate());

    return ListTile(
      title: Text("Mobil : " + namaMobil),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Text("Nama Pemesan : " + namaPembeli),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Alamat: " + alamatPembeli),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Jenis Jasa : " + jenisJasa),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Tanggal Pemesanan : " + formattedTanggalPemesanan),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Tanggal Berakhir : " + formattedTanggalBerakhir),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Total Harga : Rp." + totalHarga.toString()),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      leading: IconButton(
        onPressed: () {
          hapusData(context, id);
        },
        icon: Icon(Icons.delete),
      ),
    );
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    CollectionReference InputPesanan = firestore.collection("pesanan");

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Halaman Tampil Data"),
          backgroundColor: Color.fromARGB(70, 0, 255, 238),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: buildBottomNavBar(1, size, themeData),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
              stream: InputPesanan.snapshots(),
              builder: (_, snapshot) {
                return (snapshot.hasData)
                    ? ListView(
                        children: snapshot.data!.docs.map(
                          (e) {
                            final data = e.data() as Map<String, dynamic>;

                            return DataPemesanan(
                              data['namaMobil'] ?? '',
                              data['namaPembeli'] ?? '',
                              data['alamatPembeli'] ?? '',
                              data['jenisJasa'] ?? '',
                              data['tanggalPemesanan'] ?? Timestamp.now(),
                              data['tanggalBerakhir'] ?? Timestamp.now(),
                              data['totalHarga'] ?? '',
                              e.id,
                            );
                          },
                        ).toList(),
                      )
                    : Text('Loading...');
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavBar(int selectedIndex, Size size, ThemeData themeData) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/history');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'history',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
