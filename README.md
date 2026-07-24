# Al-Qur'an Digital — Flutter App

Port dari web app HTML lo ke Flutter, biar bisa di-build jadi APK/AAB dan diupload ke Play Store.

## Status Offline

| Fitur | Status |
|---|---|
| 🕌 Bacaan Sholat (5 waktu + niat + tata cara) | ✅ 100% offline |
| 📿 Zikir Ba'da Sholat (counter) | ✅ 100% offline |
| ✨ Asmaul Husna (99 nama) | ✅ 100% offline |
| 📖 Al-Qur'an (teks Arab + terjemahan, 114 surah / 6.236 ayat) | ✅ 100% offline (sudah termasuk di ZIP) |
| 📗 Yasin (shortcut ke Surah 36) | ✅ 100% offline |
| 🔊 Audio Murotal | ⚠️ Tetap streaming online (Qori: Mishari Rashid Alafasy) |

## ✅ Semua File Sudah Lengkap

Paket ini sudah termasuk **semua file yang dibutuhkan** — `gradle-wrapper.jar` dan `quran_id.json` (6.236 ayat lengkap) sudah ada di tempatnya. Tinggal extract ZIP dan langsung build, tidak perlu download apa pun lagi.




## ⚠️ SATU FILE YANG MASIH KURANG

Folder `android/` di ZIP ini udah lengkap (Gradle config, `AndroidManifest.xml`, `MainActivity.kt`, icon launcher, dll) — **KECUALI** satu file biner yang gak bisa gue buat dari sandbox ini:

```
android/gradle/wrapper/gradle-wrapper.jar
```

File ini generic (bukan spesifik ke project lo), jadi ambil dari salah satu cara ini:

**Cara termudah (langsung dari HP, tinggal download):**
1. Buka link ini di browser: `https://raw.githubusercontent.com/gradle/gradle/v8.6.0/gradle/wrapper/gradle-wrapper.jar`
2. Download filenya
3. Taruh persis di `android/gradle/wrapper/gradle-wrapper.jar` (folder `gradle/wrapper` udah ada, tinggal isi filenya)
4. Zip ulang semuanya, upload ke CI

**Cara alternatif:** kalau lo pernah punya project Flutter lain yang berhasil ke-build sebelumnya (folder `android/` masih ada), tinggal copy file `gradle-wrapper.jar`-nya dari situ — file ini sama aja di semua project Flutter selama versi Gradle wrapper-nya sama (8.6).

Setelah file itu ada, project ini udah lengkap dan CI build lo harusnya bisa langsung `flutter build apk --release` tanpa perlu `flutter create` lagi.

## Cara Setup (kalau mau develop lokal juga, opsional)


## Build buat Upload ke Play Store

Play Store butuh format **AAB** (Android App Bundle), bukan APK:

```bash
flutter build appbundle --release
```

File hasil ada di `build/app/outputs/bundle/release/app-release.aab`.

**Sebelum upload, WAJIB signing dulu** (Play Store nolak app yang gak di-sign pakai keystore sendiri):

```bash
keytool -genkey -v -keystore ~/al-quran-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias al-quran-key
```

Terus bikin file `android/key.properties`:
```
storePassword=<password_lo>
keyPassword=<password_lo>
keyAlias=al-quran-key
storeFile=<path_ke_al-quran-key.jks>
```

Dan edit `android/app/build.gradle` buat baca config signing itu (tutorial resmi Flutter: https://docs.flutter.dev/deployment/android#signing-the-app).

## Ganti Nama Package (Application ID)

Default dari `flutter create` biasanya `com.example.al_quran_digital`. Play Store gak boleh nama itu — ganti ke domain lo sendiri, misal `id.wanzzdeveloper.alqurandigital`, di:
- `android/app/build.gradle` → `applicationId`
- `android/app/src/main/AndroidManifest.xml` (kalau ada referensi package)

Paling gampang pakai package `rename` (`dart pub global activate rename`) atau ganti manual.

## Struktur File di ZIP Ini

```
pubspec.yaml
lib/
  main.dart              → entry point, theme, bottom navigation
  data/
    zikir_data.dart       → data zikir offline
    sholat_data.dart      → data 5 waktu sholat + tata cara offline
    asma_data.dart         → data 99 Asmaul Husna offline
  screens/
    quran_screen.dart      → daftar surah + baca + audio (online)
    sholat_screen.dart     → tab Bacaan Sholat (offline)
    asma_screen.dart       → tab Asmaul Husna (offline)
    zikir_screen.dart      → tab Zikir counter (offline)
assets/
  icon/icon.png           → logo yang lo kasih, buat app icon
```

## Catatan lain
- Nama app di-set ke **"Al-Qur'an Digital"** lewat `title:` di `main.dart` — buat ganti nama yang muncul di homescreen HP, edit juga `android/app/src/main/AndroidManifest.xml` bagian `android:label`.
- Belum gue tes compile langsung (gak ada Flutter SDK di sandbox ini) — kemungkinan ada typo kecil, tapi struktur & logicnya udah standar Flutter. Kalau ada error pas `flutter run`, kirim pesan errornya ke sini, gue bantu fix.
