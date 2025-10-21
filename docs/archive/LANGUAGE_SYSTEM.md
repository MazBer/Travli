# Dil Sistemi - Language System 🌍

## ✅ Özellikler / Features

### Çok Dilli Destek / Multi-Language Support
- ✅ **5 Dil Desteği:** English, Türkçe, Deutsch, Español, Français
- ✅ **Şehir İsimleri Çevirisi:** München → Münih, Vienna → Viyana
- ✅ **Ülke İsimleri Çevirisi:** Deutschland → Almanya, Spain → İspanya
- ✅ **Ayarlar Menüsü:** Dil seçimi için kolay arayüz
- ✅ **Kalıcı Kayıt:** Seçilen dil uygulama kapanınca bile hatırlanır

## 🌍 Desteklenen Diller / Supported Languages

1. **English (en)** - İngilizce
2. **Türkçe (tr)** - Turkish
3. **Deutsch (de)** - German
4. **Español (es)** - Spanish
5. **Français (fr)** - French

## 🏙️ Şehir Çevirileri / City Translations

### Örnekler / Examples:

| Orijinal | English | Türkçe | Deutsch | Español | Français |
|----------|---------|--------|---------|---------|----------|
| München | Munich | Münih | München | Múnich | Munich |
| Wien | Vienna | Viyana | Wien | Viena | Vienne |
| Praha | Prague | Prag | Prag | Praga | Prague |
| Αθήνα | Athens | Atina | Athen | Atenas | Athènes |
| Firenze | Florence | Floransa | Florenz | Florencia | Florence |
| Venezia | Venice | Venedik | Venedig | Venecia | Venise |
| Roma | Rome | Roma | Rom | Roma | Rome |
| Lisboa | Lisbon | Lizbon | Lissabon | Lisboa | Lisbonne |
| Warszawa | Warsaw | Varşova | Warschau | Varsovia | Varsovie |
| København | Copenhagen | Kopenhag | Kopenhagen | Copenhague | Copenhague |

## 🌍 Ülke Çevirileri / Country Translations

### Örnekler / Examples:

| Orijinal | English | Türkçe | Deutsch | Español | Français |
|----------|---------|--------|---------|---------|----------|
| Deutschland | Germany | Almanya | Deutschland | Alemania | Allemagne |
| España | Spain | İspanya | Spanien | España | Espagne |
| Italia | Italy | İtalya | Italien | Italia | Italie |
| Österreich | Austria | Avusturya | Österreich | Austria | Autriche |
| Schweiz | Switzerland | İsviçre | Schweiz | Suiza | Suisse |
| Ελλάδα | Greece | Yunanistan | Griechenland | Grecia | Grèce |
| Polska | Poland | Polonya | Polen | Polonia | Pologne |
| Magyarország | Hungary | Macaristan | Ungarn | Hungría | Hongrie |
| Nederland | Netherlands | Hollanda | Niederlande | Países Bajos | Pays-Bas |
| België | Belgium | Belçika | Belgien | Bélgica | Belgique |

## 📱 Nasıl Kullanılır / How to Use

### Dil Değiştirme / Change Language:

1. **Settings** (Ayarlar) sekmesine git
2. **Language** (Dil) seçeneğini bul
3. Sağdaki oka tıkla
4. İstediğin dili seç:
   - 🇬🇧 English
   - 🇹🇷 Türkçe
   - 🇩🇪 Deutsch
   - 🇪🇸 Español
   - 🇫🇷 Français

### Sonuç / Result:
- ✅ Tüm şehir isimleri seçilen dilde görünür
- ✅ Tüm ülke isimleri seçilen dilde görünür
- ✅ Arama sonuçları anlaşılır hale gelir

## 🎯 Örnek Senaryolar / Example Scenarios

### Senaryo 1: Türkçe Kullanıcı
**Ayar:** Dil → Türkçe

**Arama:** "münih"
```
Sonuç:
📍 Münih, Almanya
📍 Münih Havalimanı, Almanya
```

**Fayda:** Kullanıcı "München" yerine "Münih" görür ✅

### Senaryo 2: English User
**Setting:** Language → English

**Search:** "munich"
```
Result:
📍 Munich, Germany
📍 Munich Airport, Germany
```

**Benefit:** User sees "Munich" instead of "München" ✅

### Senaryo 3: Deutscher Benutzer
**Einstellung:** Sprache → Deutsch

**Suche:** "münchen"
```
Ergebnis:
📍 München, Deutschland
📍 München Flughafen, Deutschland
```

**Vorteil:** Benutzer sieht "München" und "Deutschland" ✅

## 🔧 Teknik Detaylar / Technical Details

### Dosya Yapısı / File Structure:
```
lib/
├── core/
│   ├── services/
│   │   └── translation_service.dart  // Çeviri servisi
│   └── providers/
│       └── language_provider.dart    // Dil state yönetimi
└── models/
    └── city.dart                     // Çeviri metodları eklendi
```

### Çeviri Servisi / Translation Service:
```dart
class TranslationService {
  // Şehir çevirisi
  String translateCity(String cityName, String targetLanguage) {
    // München → Münih (tr)
    // München → Munich (en)
  }
  
  // Ülke çevirisi
  String translateCountry(String countryName, String targetLanguage) {
    // Deutschland → Almanya (tr)
    // Deutschland → Germany (en)
  }
}
```

### State Yönetimi / State Management:
```dart
// Riverpod ile dil yönetimi
final languageProvider = StateNotifierProvider<LanguageNotifier, String>

// Kullanım
final currentLanguage = ref.watch(languageProvider);
```

### Kalıcılık / Persistence:
- **SharedPreferences** kullanılarak kaydedilir
- Uygulama kapansa bile hatırlanır
- Otomatik yüklenir

## 🎨 UI Entegrasyonu / UI Integration

### Settings Ekranı / Settings Screen:
```
┌─────────────────────────────┐
│ Language                    │
│ Türkçe                   ▶  │
└─────────────────────────────┘
```

Tıklandığında:
```
┌─────────────────────────────┐
│ ✓ Türkçe                    │
│   English                   │
│   Deutsch                   │
│   Español                   │
│   Français                  │
└─────────────────────────────┘
```

### Search Ekranı / Search Screen:
```
Dil: Türkçe
┌─────────────────────────────┐
│ 📍 Münih, Almanya           │
│ 📍 Viyana, Avusturya        │
│ 📍 Prag, Çekya              │
└─────────────────────────────┘

Dil: English
┌─────────────────────────────┐
│ 📍 Munich, Germany          │
│ 📍 Vienna, Austria          │
│ 📍 Prague, Czech Republic   │
└─────────────────────────────┘
```

## 🚀 Gelecek Geliştirmeler / Future Improvements

### Planlanan Özellikler / Planned Features:
- [ ] Daha fazla şehir çevirisi ekle
- [ ] Daha fazla ülke çevirisi ekle
- [ ] UI metinleri de çevir (başlıklar, butonlar)
- [ ] Otomatik dil algılama (sistem dilinden)
- [ ] Daha fazla dil desteği (İtalyanca, Portekizce, vb.)

### Şu An Çalışıyor / Currently Working:
- ✅ 5 dil desteği
- ✅ 10+ şehir çevirisi
- ✅ 15+ ülke çevirisi
- ✅ Ayarlar entegrasyonu
- ✅ Kalıcı kayıt
- ✅ Arama sonuçlarında çeviri

## 💡 Kullanım İpuçları / Usage Tips

### Türkçe Kullanıcılar İçin:
1. **Ayarlar** → **Dil** → **Türkçe** seçin
2. Artık "München" yerine "Münih" göreceksiniz
3. "Deutschland" yerine "Almanya" göreceksiniz
4. Daha kolay arama yapabilirsiniz!

### For English Users:
1. **Settings** → **Language** → **English**
2. Now you'll see "Munich" instead of "München"
3. You'll see "Germany" instead of "Deutschland"
4. Easier to search and recognize!

### Für deutsche Benutzer:
1. **Einstellungen** → **Sprache** → **Deutsch**
2. Sie sehen "München" und "Deutschland"
3. Alles in Ihrer Muttersprache!

---

**Dil sistemi aktif ve çalışıyor!** 🌍
**Language system is active and working!** 🌍
**Das Sprachsystem ist aktiv und funktioniert!** 🌍
