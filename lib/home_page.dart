import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rentcar/avanza.dart';
import 'package:rentcar/innova.dart';
import 'package:rentcar/xenia.dart';
import 'package:rentcar/xpander.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: themeData.backgroundColor,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: size.width * 0.25,
          title: Image.asset(
            'assets/b790c867a12855ea7bcac8517c230283.jpg',
            height: size.height * 0.10,
            width: size.width * 0.50,
          ),
          centerTitle: true,
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: buildBottomNavBar(0, size, themeData),
      backgroundColor: themeData.backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: themeData.cardColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.04,
                      ),
                      child: Align(
                        child: Text(
                          'With Corporate Difference',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: const Color.fromARGB(255, 0, 0, 0), 
                            fontSize: size.width * 0.06,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01,
                      ),
                      child: Align(
                        child: Text(
                          'Enjoy the fun driving in Enterprise',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: const Color.fromARGB(255, 0, 0, 0), // Set the text color to the primary color
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildMostRented(size, themeData),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide(
        color: Colors.black.withOpacity(0.5),
        width: 1.0,
      ),
    );
  }

  Widget buildMostRented(Size size, ThemeData themeData) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Most Rented',
            style: TextStyle(
              // color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: size.width * 0.06,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          Container(
            height: size.height * 0.7,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildCarCard('Avanza', 'assets/avanza.jpg', themeData),
                buildCarCard('Xenia', 'assets/xenia.jpg', themeData),
                buildCarCard('Xpander', 'assets/xpander.jpg', themeData),
                buildCarCard('Innova', 'assets/innova.jpg', themeData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBrandCard(
      String brandName, String imagePath, ThemeData themeData) {
    return Container(
      width: 120.0,
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            brandName,
            style: TextStyle(
              // color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCarCard(String carName, String imagePath, ThemeData themeData) {
    return GestureDetector(
        onTap: () {
          // Navigate to the specific car page when the card is tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              // Ganti dengan halaman detail mobil yang sesuai dengan mobil yang dipilih
              if (carName == 'Avanza') {
                return Avanza();
              } else if (carName == 'Xenia') {
                return Xenia();
              } else if (carName == 'Xpander') {
                return xpander();
              } else if (carName == 'Innova') {
                return Innova();
              } else {
                // Halaman detail mobil default, ganti sesuai kebutuhan
                return HomePage();
              }
            }),
          );
        },
        child: Container(
          width: 360.0,
          margin: EdgeInsets.only(right: 16.0),
          child: Column(
            children: [
              Container(
                height: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                carName,
                style: TextStyle(
                  // color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
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
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
