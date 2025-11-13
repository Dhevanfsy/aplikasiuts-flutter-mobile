import 'package:flutter/material.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  final List<Map<String, String>> beritaList = const [
    {
      "judul": "Motor Listrik Jadi Tren di Tahun 2025",
      "deskripsi":
          "Motor listrik semakin diminati karena ramah lingkungan dan biaya operasionalnya yang rendah dibandingkan motor bensin.",
      "gambar": "assets/images/motor_listrik.jpg",
      "tanggal": "12 November 2025",
    },
    {
      "judul": "Tips Merawat Mesin Motor Agar Tetap Awet",
      "deskripsi":
          "Rajin mengganti oli dan membersihkan filter udara adalah kunci menjaga performa mesin motor agar tetap optimal.",
      "gambar": "assets/images/perawatan_motor.jpeg",
      "tanggal": "10 November 2025",
    },
    {
      "judul": "Yamaha R15 Facelift Resmi Meluncur di Indonesia",
      "deskripsi":
          "Yamaha meluncurkan R15 versi terbaru dengan desain lebih agresif, fitur quick shifter, dan panel digital modern.",
      "gambar": "assets/images/yamaha_r15.jpg",
      "tanggal": "8 November 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFF),
      appBar: AppBar(
        title: const Text(
          "Berita Terbaru",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: beritaList.length,
        itemBuilder: (context, index) {
          final berita = beritaList[index];
          return _BeritaCard(
            judul: berita["judul"]!,
            deskripsi: berita["deskripsi"]!,
            gambar: berita["gambar"]!,
            tanggal: berita["tanggal"]!,
          );
        },
      ),
    );
  }
}

class _BeritaCard extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final String gambar;
  final String tanggal;

  const _BeritaCard({
    required this.judul,
    required this.deskripsi,
    required this.gambar,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gambar nya
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Image.asset(
              gambar,
              height: 110,
              width: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Info berita nya
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    deskripsi,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tanggal,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue.shade50,
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Baca",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
