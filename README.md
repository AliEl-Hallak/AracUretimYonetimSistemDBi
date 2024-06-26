# Araç Tanıtım Uygulaması Veritabanı

Bu doküman, Araç Tanıtım Uygulamasının veritabanı yapılandırması ve şemasını açıklar. Uygulama, araçların bilgilerini, üretildikleri fabrikaları ve ilgili tüm detayları yönetmek üzere tasarlanmıştır.

## Veritabanı Yapılandırması

Araç Tanıtım Uygulaması veritabanı, araçlar, fabrikalar, malzemeler, tedarikçiler ve coğrafi bilgileri içeren karmaşık ilişkisel bir yapıdır. Bu yapı, uygulamanın çeşitli fonksiyonlarını destekler: arama, ekleme, güncelleme ve silme işlemleri.
## İş Kuralları

- Bir tedarikçi hiçbir malzeme tedarik etmeyebileceği gibi bir veya daha fazla malzeme de tedarik edebilir.
- Bir malzeme yalnızca bir tedarikçisi olabilir.
- Bir araç çok sayıda malzemeden oluşur. En az bir adet malzemeden oluşmak zorundadır.
- Bir malzeme birden fazla araçta kullanılabilir. Ancak henüz hiçbir araçta kullanılmamış da olabilir.
- Bir araç yalnızca bir türe sahip olur.
- Bir türe ait hiçbir araç olmayabileceği gibi çok sayıda araç da olabilir.
- Bir araç yalnızca bir modele sahip olur.
- Bir modele ait hiçbir araç olmayabileceği gibi çok sayıda araç da olabilir.
- Bir araç yalnızca bir fabrikaya sahip olur.
- Bir fabrikanın yalnızca en az bir araç olabileceği gibi çok sayıda araç da olabilir.
- Bir fabrikanın yalnızca bir il sahip olur.
- Bir ile ait hiçbir fabrika olmayabileceği gibi çok sayıda fabrika da olabilir.
- Bir ilinin en çok çok sayıda ilçe bulunur. En az bir ilce bulunur.
- Bir ilçenin en çok bir ilde bulunur. En az bir ilde bulunur.
- Bir kişinin en çok çok sayıda iletişim bilgiler vardır. En az bir iletişim bilgiler vardır.
- Bir iletişim bilgiler en çok bir kişiye aittir. En az bir kişiye aittir.
- Bir ilçenin en çok çok sayıda iletişim bilgiler bulunur. En az sıfır iletişim bilgiler vardır.
- Bir iletişimin bilgiler en çok bir ilçede bulunur. En az sıfır ilçede bulunur.
- Bir yerleşmenin en çok bir ilçede bulunur. En az bir ilçede bulunur.
- Bir ilçenin en çok çok sayıda yerleşme bulunur. En az sıfır yerleşme bulunur.
- Bir binanın en çok bir yerleşmede bulunur. En az bir yerleşmede bulunur.
- Bir yerleşme en çok çok sayıda bina bulunur. En az sıfır binada bulunur.
- Kişi türünden iki varlık bulunur: mühendis, çalışan.

## İlişkisel Şema
- AracMalzeme(sasiid:int, malzemeid:int, miktar:int)
- İl(ilid:int,adi:varchar)
- İlçe(ilceid:int, ilid:int,adi:varchar)
- Malzeme(malzemeid:int, adi: varchar, stokMiktari:int, tedarikciid:int)
- iletisimBilgileri(iletisimid:int,adres:varchar,telefon:int, ilceid:int, kisiid:int)
- Tur(turid:int, ad: varchar)
- Arac(sasiid:int, fabrikaid:int, renk: varchar, modelid:int, turid:int, uretimTarihi: date)
- Çalışan(calısanid:int, fabrikaid:int)
- Model(modelid:int, ad: varchar, fiyat:real, agirlik: real, yolcuSayisi:int)
- Tedarikci(tedarikciid:int, ad: varchar, vergiDairesi: varchar, vergino:int)
- Bina(adres: varchar, binaid:int, binaAdı: varchar, yerlesmeid:int)
- Fabrika (adi: varchar, fabrikaid:int, ilceid:int, ilid:int)
- Kişi(ad:varchar, kisiid:int, kisiTuru:char, soyad:varchar tc:int)
- MuhendsArac(muhendsid:int, şasiid:int)
- Muhends (muhendsid:int)
- Yerlesme(ad:varchar, adres:varchar, ilçeid:int, yerlesmeid:int)
- gerelenÜdeger_date(sasiid:int, vakit:date)
- toplamarac(sayi:int)

  ## Varlık Bağıntı modeli

![Ekran görüntüsü 2024-04-11 171646](https://github.com/AliEl-Hallak/AracUretimYonetimSistemDBi/assets/83112600/1214ad8d-9f06-4f7a-b751-0ab9e9f101f4)
