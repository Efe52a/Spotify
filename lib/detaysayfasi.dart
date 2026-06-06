import 'package:flutter/material.dart';


class DetaySayfasi extends StatefulWidget {
  // Dışarıdan gelecek olan sanatçı adı ve görsel linki değişkenleridir
  final String sanatciAdi;
  final String gorselUrl;

  DetaySayfasi(String ad, String resim)
      : sanatciAdi = ad,
        gorselUrl = resim;

  @override
  State<DetaySayfasi> createState() => _DetaySayfasiState();
}

class _DetaySayfasiState extends State<DetaySayfasi> {
  
  
  int begenildi = 0; // 0 ise beğenilmedi, 1 ise beğenildi anlamına geliyor
  int caliniyor = 0; // 0 ise çalmıyor, 1 ise çalıyor anlamına geliyor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Spotify temasına uygun arka plan rengidir
      backgroundColor: const Color(0xFF121212),
      
      // Üst bilgi çubuğu (AppBar)
      appBar: AppBar(
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        title: Text(
          widget.sanatciAdi, // Ana sayfadan gelen sanatçı adını başlık yaptım
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // Sayfanın dikeyde kaydırılabilir olması için ListView kullandım
      body: ListView(
        children: [
          // En üstte yer alan büyük albüm/sanatçı görselidir
          Container(
            height: 250,
            width: double.infinity,
            child: Image.network(widget.gorselUrl), // Ana sayfadan gelen görsel urlsini yükledim
          ),

          const SizedBox(height: 20),

          // Sanatçı detay bilgileri ve etkileşim butonlarıdır
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Büyük sanatçı ismidir
                Text(
                  widget.sanatciAdi,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Spotify Editör yazısı ve ikon yan yana dursun diye Row kullandım
                Row(
                  children: const [
                    Icon(Icons.favorite, color: Colors.green, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Spotify Editörü & 45.291 Beğeni",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Çalma beğenme ve indirme butonlarının yan yana durduğu satırdır
                Row(
                  children: [
                    // Karışık çal butonu
                    ElevatedButton(
                      onPressed: () {
                        // Tıklanınca çalma durumunu 0 ve 1 arasında değiştirdim
                        setState(() {
                          if (caliniyor == 0) {
                            caliniyor = 1;
                          } else {
                            caliniyor = 0;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, 
                      ),
                      child: Text(
                        caliniyor == 1 ? "DURAKLAT" : "KARIŞIK ÇAL",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    
                    // Beğenme (Kalp) butonudur
                    IconButton(
                      icon: Icon(
                        begenildi == 1 ? Icons.favorite : Icons.favorite_border,
                        color: begenildi == 1 ? Colors.green : Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        // Kalbe tıklanınca beğeni durumunu güncelliyorum
                        setState(() {
                          if (begenildi == 0) {
                            begenildi = 1;
                          } else {
                            begenildi = 0;
                          }
                        });
                      },
                    ),
                    
                    // İndirme butonu
                    IconButton(
                      icon: const Icon(Icons.download_for_offline, color: Colors.white, size: 28),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.grey), // Şarkı listesinden önce ince bir çizgi çektim

          // Şarkı Listesi Alanıdır
          _sarkiSatiri("1", "Dilsiz Sırdaşım", "3:42"),
          _sarkiSatiri("2", "Bodrum", "4:15"),
          _sarkiSatiri("3", "Kazılı Kuyum", "3:50"),
          _sarkiSatiri("4", "Boş Gemiler", "3:18"),
          _sarkiSatiri("5", "Son Seslenişim", "4:02"),
          _sarkiSatiri("6", "Sandık", "3:11"),

          const SizedBox(height: 50), // Sayfanın en altında boşluk kalması için ekledim
        ],
      ),
    );
  }

  
  // Row Column Text ve Icon kullanarak sıfırdan oluşturduğum temiz şarkı kodudur
  Widget _sarkiSatiri(String sira, String baslik, String sure) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // En sol ve en sağdaki elemanları uçlara yaslar
        children: [
          // Şarkı numarası ve şarkı bilgilerini içeren sol taraftır
          Row(
            children: [
              Text(
                sira,
                style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              // Şarkı adı ve sanatçı adını alt alta yazmak için Column kullandım
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    baslik,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Yüzyüzeyken Konuşuruz",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Şarkı süresi ve üç nokta butonunu içeren sağ taraftır
          Row(
            children: [
              Text(
                sure,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 15),
              const Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}