import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();

  String? _selectedGender;
  String? _selectedProdi;
  DateTime? _selectedDate;

  final List<String> _prodiList = [
    'Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Teknik Elektro',
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('nama') ?? '';
      _nimController.text = prefs.getString('nim') ?? '';
      _selectedGender = prefs.getString('gender');
      _selectedProdi = prefs.getString('prodi');
      final tanggal = prefs.getString('tanggalLahir');
      if (tanggal != null) {
        _selectedDate = DateTime.tryParse(tanggal);
      }
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', _nameController.text);
    await prefs.setString('nim', _nimController.text);
    if (_selectedGender != null)
      await prefs.setString('gender', _selectedGender!);
    if (_selectedProdi != null) await prefs.setString('prodi', _selectedProdi!);
    if (_selectedDate != null)
      await prefs.setString('tanggalLahir', _selectedDate!.toIso8601String());
  }

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002, 1, 1),
      firstDate: DateTime(1990),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Biodata'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _nimController,
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Icon(Icons.badge),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedProdi,
              decoration: InputDecoration(
                labelText: 'Program Studi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Icon(Icons.school),
              ),
              items:
                  _prodiList
                      .map(
                        (prodi) =>
                            DropdownMenuItem(value: prodi, child: Text(prodi)),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProdi = value;
                });
              },
            ),
            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Jenis Kelamin:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Laki-laki'),
                    value: 'Laki-laki',
                    groupValue: _selectedGender,
                    onChanged:
                        (value) => setState(() => _selectedGender = value),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Perempuan'),
                    value: 'Perempuan',
                    groupValue: _selectedGender,
                    onChanged:
                        (value) => setState(() => _selectedGender = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'Pilih tanggal'
                      : '${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
                ),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () async {
                await _saveData();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data biodata berhasil disimpan!'),
                  ),
                );
              },
              icon: const Icon(Icons.save_alt),
              label: const Text('Simpan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
