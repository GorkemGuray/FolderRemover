# Eski Klasor Temizleme Script Dokumantasyonu

## Genel Bakis
Bu PowerShell scripti, "yyyyMMdd" formatinda adlandirilmis ve belirtilen gun sayisindan daha eski klasorleri otomatik olarak siler. Ozellikle yedekleme dizinlerinin, log klasorlerinin veya tarih bazli isimlendirme kullanan herhangi bir dizin yapisinin bakimi icin kullanislidir.

## Ozellikler
- yyyyMMdd desenine uyan klasorleri otomatik tespit eder
- Ayarlanabilir yaslanma esigi
- Detayli islem kaydi
- Her silme islemi icin hata yonetimi
- Basari/basarisizlik takibi
- Ozet rapor

## Yapilandirma Parametreleri
```powershell
$FolderPath = "C:\Logs\DailyBackups"  # Taranacak ana dizin
$DaysOld = 30                         # Gun cinsinden yas esigi
```

## Calisma Sekli
1. Belirtilen dizin yolunu dogrular
2. yyyyMMdd desenine uyan klasorleri tarar
3. Her klasorun yasini hesaplar
4. Belirlenen esikten daha eski klasorleri tespit eder
5. Hedef klasorleri detaylariyla listeler
6. Silme islemlerini gerceklestirir
7. Her islem icin basari/basarisizlik durumunu raporlar
8. Final ozeti sunar

## Cikti Ornegi
```
Islem yapilacak klasor: C:\Logs\DailyBackups
Silinecek klasor yasi: 30 gun ve uzeri
Toplam klasor sayisi: 50
30 gunden eski klasor sayisi: 20

Silinecek ve silinen klasorler:
--------------------
Siliniyor: 20240101 | Yasi: 45 gun | Olusturma Tarihi: 2024-01-01
Basarili: 20240101 silindi
...

Islem tamamlandi.
Toplam 19 klasor silindi.
```

## Hata Yonetimi
- Yol dogrulamasi
- Tarih ayristirma dogrulamasi
- Tek tek silme islemi hata yonetimi
- Islem sayisi takibi
- Basarisiz islemler icin detayli hata mesajlari

## Kullanim Alanlari
- Yedekleme dizinlerinin otomatik temizligi
- Log rotasyon yonetimi
- Gecici dosya temizligi
- Tarih bazli arsiv yonetimi
- Otomatik sistem bakimi

## Gereksinimler
- PowerShell 3.0 veya ustu
- Hedef dizinde yeterli yetkiler
- Klasorler yyyyMMdd isimlendirme kuralina uymali

## En Iyi Uygulamalar
1. Scripti once onemli olmayan bir dizinde test edin
2. `$FolderPath` degerinin dogru dizini gosterdiginden emin olun
3. `$DaysOld` degerini saklama gereksinimlerinize gore ayarlayin
4. Otomatik bakim icin scripti zamanlanmis gorev olarak ayarlayin
5. Kalici hatalar icin script ciktisini izleyin

## Kisitlamalar
- Sadece yyyyMMdd formatinda isimlendirilmis klasorlerle calisir
- Ic ice dizinleri islemez
- Silme oncesi yedekleme ozelligi yok
- Uzak dizin destegi yok

## Not
Script kullanilmadan once mutlaka test edilmeli ve veri kaybi riskine karsi gerekli onlemler alinmalidir.
