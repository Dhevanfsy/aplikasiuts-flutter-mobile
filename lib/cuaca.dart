import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  String tanggal = '';

  @override
  void initState() {
    super.initState();
    _loadDate();
  }

  Future<void> _loadDate() async {
    await initializeDateFormatting('id_ID', null);
    final now = DateTime.now();
    final formatted = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(now);
    if (mounted) {
      setState(() => tanggal = formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Cuaca Hari Ini",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body:
          tanggal.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // buat si lokasi ama tanggal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Bandung, Indonesia",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tanggal,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6BB9FF), Color(0xFF89E0FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/sunny.gif',
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Berawan Sebagian",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "33°C",
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "Terasa seperti 36°C",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // 💨 Info Cuaca Ringkas
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _WeatherInfo(
                          icon: Icons.water_drop,
                          label: "Kelembapan",
                          value: "66%",
                        ),
                        _WeatherInfo(
                          icon: Icons.air,
                          label: "Angin",
                          value: "14 km/h",
                        ),
                        _WeatherInfo(
                          icon: Icons.speed,
                          label: "Tekanan",
                          value: "1012 hPa",
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                    const Text(
                      "Prakiraan 3 Hari ke Depan",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 📅 Prakiraan Hari
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _ForecastCard(
                          day: "Kamis",
                          temp: "31°C",
                          gif: "assets/images/global.png",
                        ),
                        _ForecastCard(
                          day: "Jumat",
                          temp: "29°C",
                          gif: "assets/images/awan1.png",
                        ),
                        _ForecastCard(
                          day: "Sabtu",
                          temp: "27°C",
                          gif: "assets/images/hujan.png",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}

class _WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 26),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _ForecastCard extends StatelessWidget {
  final String day;
  final String temp;
  final String gif;

  const _ForecastCard({
    required this.day,
    required this.temp,
    required this.gif,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(gif, height: 45, fit: BoxFit.cover),
          const SizedBox(height: 8),
          Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          Text(
            temp,
            style: const TextStyle(color: Colors.blueAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
