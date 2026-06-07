import 'package:flutter/material.dart';


class DetaySayfasi extends StatefulWidget {
  final String sanatciAdi;
  final String gorselUrl;

  
  DetaySayfasi(String ad, String resim)
      : sanatciAdi = ad,
        gorselUrl = resim;

  @override
  State<DetaySayfasi> createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  // Durum kontrol değişkenleri (0: Pasif  1: Aktif) kodudur
  int begenildi = 0; 
  int caliniyor = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        // Ok tuşunu belirginleştirmek için sol tarafa özel bir leading ekledim
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Dışarıdan hafif boşluk verdim
          child: CircleAvatar(
            backgroundColor: const Color(0xFF282828), // Belirgin olması için arkasına koyu gri yuvarlak koydum
            child: IconButton(
              padding: const EdgeInsets.all(0), // İkonun tam ortalanması için paddingi sıfırladım
              icon: const Icon(
                Icons.arrow_back, 
                color: Colors.white, // Bembeyaz ve net durmasını sağladım
                size: 20,
              ),
              onPressed: () {
                // Bir önceki sayfaya güvenle dönmek için Navigator.pop kullandım
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
          widget.sanatciAdi, // Ana sayfadan gelen ismi buraya yazdırdım
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          // En üstteki albüm kapağı görselidir
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.gorselUrl),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Sanatçı metinleri ve butonlarıdır
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sanatciAdi,
                  style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.favorite, color: Colors.green, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Spotify Editörü & 45.291 Beğeni",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Butonların dizildiği kontrol satırıdır
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (caliniyor == 0) {
                            caliniyor = 1;
                          } else {
                            caliniyor = 0;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: Text(
                        caliniyor == 1 ? "DURAKLAT" : "KARIŞIK ÇAL",
                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      icon: Icon(
                        begenildi == 1 ? Icons.favorite : Icons.favorite_border,
                        color: begenildi == 1 ? Colors.green : Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        setState(() {
                          if (begenildi == 0) {
                            begenildi = 1;
                          } else {
                            begenildi = 0;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.grey),

          // Alt kısımdaki statik şarkı satırları listesi
          _sarkiSatiri("1", "Dilsiz Sırdaşım", "3:42"),
          _sarkiSatiri("2", "Bodrum", "4:15"),
          _sarkiSatiri("3", "Kazılı Kuyum", "3:50"),
          _sarkiSatiri("4", "Boş Gemiler", "3:18"),
          
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  
  Widget _sarkiSatiri(String sira, String baslik, String sure) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(sira, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(baslik, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text("Yüzyüzeyken Konuşuruz", style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(sure, style: const TextStyle(color: Colors.grey)),
              const SizedBox(width: 15),
              const Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}