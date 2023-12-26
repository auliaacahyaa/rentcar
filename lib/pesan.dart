import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentcar/home_page.dart';

class InputPesanan extends StatefulWidget {
  const InputPesanan({Key? key}) : super(key: key);

  @override
  _InputPesananState createState() => _InputPesananState();
}

class _InputPesananState extends State<InputPesanan> {
  String? jenisJasa;
  DateTime? tanggalPemesanan;
  DateTime? tanggalBerakhir;
  String? namaMobil;
  String? jenisHarga;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tanggalPemesananController =
      TextEditingController();
  final TextEditingController _tanggalBerakhirController =
      TextEditingController();
  final TextEditingController _ktpImageController = TextEditingController();
  final TextEditingController _kkImageController = TextEditingController();

  _PickedImage? ktpImageFile;
  _PickedImage? kkImageFile;

  final ImagePicker _imagePicker = ImagePicker();
  final CollectionReference pesananCollection =
      FirebaseFirestore.instance.collection('pesanan');

  Future<void> _pickImage(bool isKtp) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage != null) {
        setState(() {
          if (isKtp) {
            ktpImageFile = _PickedImage(pickedImage.path);
            _ktpImageController.text = ktpImageFile!.path;
          } else {
            kkImageFile = _PickedImage(pickedImage.path);
            _kkImageController.text = kkImageFile!.path;
          }
        });
      } else {
        print('Tidak ada gambar yang dipilih.');
      }
    } catch (e) {
      print('Kesalahan memilih gambar: $e');
    }
  }

  Future<void> showSuccessDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Data berhasil disimpan ke Firebase.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showInvalidCredentialsDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveDataToFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    String namaPembeli = _namaController.text.trim();
    String noHpPembeli = _noHpController.text.trim();
    String alamatPembeli = _alamatController.text.trim();
    String tanggalPemesanan = _tanggalPemesananController.text.trim();
    String tanggalBerakhir = _tanggalBerakhirController.text.trim();
    String ktpImage = _ktpImageController.text.trim();
    String kkImage = _kkImageController.text.trim();

    if (namaPembeli.isEmpty ||
        noHpPembeli.isEmpty ||
        alamatPembeli.isEmpty ||
        tanggalPemesanan.isEmpty ||
        tanggalBerakhir.isEmpty ||
        ktpImage.isEmpty ||
        kkImage.isEmpty ||
        jenisJasa == null ||
        namaMobil == null ||
        jenisHarga == null) {
      print('Harap isi semua field.');
      String errorMessage = 'Lengkapi Pesanan';
      await showInvalidCredentialsDialog(errorMessage);
      return;
  
    }

    try {
      DateTime parsedTanggalPemesanan = DateTime.parse(tanggalPemesanan!);
      DateTime parsedTanggalBerakhir = DateTime.parse(tanggalBerakhir!);

      int harga = jenisHarga == 'Rp. 350.000' ? 350000 : 500000;

      int selisihHari =
          parsedTanggalBerakhir.difference(parsedTanggalPemesanan).inDays;
      int totalHarga = harga * selisihHari;

      await pesananCollection.doc(user!.uid).set({
        'namaPembeli': namaPembeli,
        'noHpPembeli': noHpPembeli,
        'alamatPembeli': alamatPembeli,
        'jenisJasa': jenisJasa,
        'namaMobil': namaMobil,
        'tanggalPemesanan': Timestamp.fromDate(parsedTanggalPemesanan),
        'tanggalBerakhir': Timestamp.fromDate(parsedTanggalBerakhir),
        'ktpImage': ktpImage,
        'kkImage': kkImage,
        'jenisHarga': jenisHarga,
        'totalHarga': totalHarga,
      });
      print('Data berhasil disimpan ke Firebase.');

      _clearFormFields();
      await showSuccessDialog();
    } catch (e) {
      print('Error: $e');
      String errorMessage = 'Error saving data to Firebase.';
      await showInvalidCredentialsDialog(errorMessage);
    }
  }

  void _clearFormFields() {
    _namaController.clear();
    _noHpController.clear();
    _alamatController.clear();
    _tanggalPemesananController.clear();
    _tanggalBerakhirController.clear();
    _ktpImageController.clear();
    _kkImageController.clear();
    jenisJasa = null;
    namaMobil = null;
    jenisHarga = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memesan'),
        backgroundColor: Color.fromARGB(70, 0, 255, 238),
        actions: <Widget>[],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Nama Pemesan',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nama Pemesan',
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'No HP Pemesan:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _noHpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'No HP Pemesan',
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Alamat Pemesan:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _alamatController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Alamat Pemesan',
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Jenis Sewa:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('Self Drive'),
                      value: 'Self Drive',
                      groupValue: jenisJasa,
                      onChanged: (value) {
                        setState(() {
                          jenisJasa = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: Text('With Driver'),
                      value: 'With Driver',
                      groupValue: jenisJasa,
                      onChanged: (value) {
                        setState(() {
                          jenisJasa = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Nama Mobil:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton<String>(
                  value: namaMobil,
                  items: ['Avanza', 'Xenia', 'Xpander', 'Innova']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      namaMobil = value;
                    });
                  },
                  hint: Text('Pilih Nama Mobil'),
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Harga Sewa:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton<String>(
                  value: jenisHarga,
                  items: ['Rp. 350,000', 'Rp. 500,000','Rp.550.000']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      jenisHarga = value;
                    });
                  },
                  hint: Text('Pilih Harga'),
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Tanggal Pemesanan:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _tanggalPemesananController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != tanggalPemesanan) {
                      pickedDate = DateTime(
                          pickedDate.year, pickedDate.month, pickedDate.day);
                      setState(() {
                        tanggalPemesanan = pickedDate;
                        _tanggalPemesananController.text =
                            "${pickedDate?.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tanggal Pemesanan',
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Tanggal Berakhir:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: _tanggalBerakhirController,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != tanggalBerakhir) {
                      pickedDate = DateTime(
                          pickedDate.year, pickedDate.month, pickedDate.day);
                      setState(() {
                        tanggalBerakhir = pickedDate;
                        _tanggalBerakhirController.text =
                            "${pickedDate?.toLocal()}".split(' ')[0];
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tanggal Berakhir',
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Upload Foto KTP:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ktpImageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Link/Filename Foto KTP',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () => _pickImage(true),
                      child: Text('Pilih Foto'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Upload Foto KK:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _kkImageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Link/Filename Foto KK',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () => _pickImage(false),
                      child: Text('Pilih Foto'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _saveDataToFirebase();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePage()),
                    // );
                  },
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PickedImage {
  final String path;

  _PickedImage(this.path);
}