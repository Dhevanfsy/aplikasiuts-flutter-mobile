import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'biodata_page.dart';
import 'kontak_page.dart';
import 'kalkulator.dart';
import 'cuaca.dart';
import 'berita_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => isDarkMode = !isDarkMode);
    prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Mobile',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(toggleTheme: _toggleTheme, isDarkMode: isDarkMode),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;
  const SplashScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => DashboardPage(
                toggleTheme: widget.toggleTheme,
                isDarkMode: widget.isDarkMode,
              ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isDarkMode ? Colors.grey.shade900 : Colors.blue.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_android,
              size: 100,
              color: widget.isDarkMode ? Colors.white70 : Colors.white,
            ),
            const SizedBox(height: 30),
            Text(
              '152021030',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? Colors.white : Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Dhevan Fasya Revangga',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: widget.isDarkMode ? Colors.white70 : Colors.white70,
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('Loading...', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;
  const DashboardPage({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedMenu = 0;
  String nama = 'Dhevan Fasya Revangga';
  String nim = '152021030';

  final List<String> pages = ['Beranda', 'Profil', 'Pengaturan'];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nama = prefs.getString('nama') ?? nama;
      nim = prefs.getString('nim') ?? nim;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pages[_selectedMenu],
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.blue,
        centerTitle: true,
        elevation: 4,
        actions: [
          Row(
            children: [
              Text(
                isDarkMode ? 'Mode Gelap' : 'Mode Terang',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
              const SizedBox(width: 6),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder:
                    (child, anim) => ScaleTransition(scale: anim, child: child),
                child: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  key: ValueKey(isDarkMode),
                  color: Colors.white,
                ),
              ),
              Switch(
                value: isDarkMode,
                onChanged: (value) => widget.toggleTheme(),
                activeColor: Colors.yellow,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800 : Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: isDarkMode ? Colors.white24 : Colors.white,
                    child: Icon(
                      Icons.person,
                      color: isDarkMode ? Colors.white : Colors.blue,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(nim, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: isDarkMode ? Colors.white : null,
              ),
              title: Text(
                'Beranda',
                style: TextStyle(color: isDarkMode ? Colors.white70 : null),
              ),
              onTap: () {
                setState(() => _selectedMenu = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: isDarkMode ? Colors.white : null,
              ),
              title: Text(
                'Profil',
                style: TextStyle(color: isDarkMode ? Colors.white70 : null),
              ),
              onTap: () {
                setState(() => _selectedMenu = 1);
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.contact_page,
                color: isDarkMode ? Colors.white : null,
              ),
              title: Text(
                'Biodata',
                style: TextStyle(color: isDarkMode ? Colors.white70 : null),
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BiodataPage()),
                );
                _loadUserData();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: isDarkMode ? Colors.white : null,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: isDarkMode ? Colors.white70 : null),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => SplashScreen(
                          toggleTheme: widget.toggleTheme,
                          isDarkMode: widget.isDarkMode,
                        ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body:
          _selectedMenu == 0
              ? const MenuGridPage()
              : _selectedMenu == 1
              ? const Center(child: Text('Ini Halaman Profil'))
              : const Center(child: Text('Ini Halaman Pengaturan')),
    );
  }
}

class MenuGridPage extends StatefulWidget {
  const MenuGridPage({super.key});

  @override
  State<MenuGridPage> createState() => _MenuGridPageState();
}

class _MenuGridPageState extends State<MenuGridPage> {
  int? _pressedIndex;

  final List<Map<String, dynamic>> menus = const [
    {'icon': Icons.contact_phone, 'label': 'Kontak'},
    {'icon': Icons.calculate, 'label': 'Kalkulator'},
    {'icon': Icons.wb_sunny, 'label': 'Cuaca'},
    {'icon': Icons.article, 'label': 'Berita'},
  ];

  void _openPage(BuildContext context, String label) {
    if (label == 'Kontak') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const KontakPage()),
      );
    } else if (label == 'Kalkulator') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const KalkulatorPage()),
      );
    } else if (label == 'Cuaca') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CuacaPage()),
      );
    } else if (label == 'Berita') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BeritaPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFE3F2FD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: menus.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 25,
            crossAxisSpacing: 25,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final menu = menus[index];
            final isPressed = _pressedIndex == index;

            return GestureDetector(
              onTapDown: (_) => setState(() => _pressedIndex = index),
              onTapUp: (_) {
                Future.delayed(
                  const Duration(milliseconds: 120),
                  () => setState(() => _pressedIndex = null),
                );
                _openPage(context, menu['label']);
              },
              onTapCancel: () => setState(() => _pressedIndex = null),
              child: AnimatedScale(
                scale: isPressed ? 0.92 : 1.0,
                duration: const Duration(milliseconds: 120),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                            isPressed
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.blue.withOpacity(0.25),
                        blurRadius: isPressed ? 4 : 10,
                        spreadRadius: 1,
                        offset:
                            isPressed ? const Offset(1, 2) : const Offset(3, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(menu['icon'], size: 55, color: Colors.blue.shade600),
                      const SizedBox(height: 12),
                      Text(
                        menu['label'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
