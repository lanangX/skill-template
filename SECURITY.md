# Kebijakan keamanan

## Cakupan

Repo ini berisi teks instruksi (skill), manifest JSON, dan skrip shell untuk validasi dan build. Tidak ada layanan yang berjalan dan tidak ada kredensial yang dibutuhkan.

Hal yang dianggap masalah keamanan:

- Instruksi di skill yang bisa membuat model membocorkan data pengguna, mengarahkan ke tautan berbahaya, atau menyarankan membagikan token, kunci API, atau password.
- Celah prompt injection yang membuat skill melanggar aturannya saat memproses masukan yang berisi teks berbahaya.
- Skrip di `scripts/` atau workflow di `.github/` yang bisa dieksploitasi (misalnya injeksi perintah lewat nama cabang atau input).

## Melapor

Jangan buka issue publik untuk kerentanan. Gunakan **Private vulnerability reporting** di tab Security repo ini (Security > Report a vulnerability). Sertakan langkah reproduksi, versi, dan dampaknya.

Laporan ditargetkan dibalas dalam 7 hari. Perbaikan yang terkonfirmasi dicatat di [CHANGELOG](CHANGELOG.md).

## Versi yang didukung

Hanya rilis terbaru yang menerima perbaikan keamanan.
