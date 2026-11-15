# Kasus uji

Setiap kasus punya input dan daftar periksa. Kode P1-P3 merujuk ke tabel di [README](README.md).

## 1. Teks biasa

**Input**

> "Tim kami memindahkan build dari Jenkins ke GitHub Actions. Waktu build turun dari 14 menit ke 9 menit karena cache dependensi. Biayanya naik sedikit karena runner berbayar."

**Daftar periksa**

- [ ] P1: ada `Inti:` satu kalimat dan tepat tiga butir
- [ ] P2: angka 14 dan 9 menit sesuai teks, tidak ada angka lain
- [ ] P3: keluaran berbahasa Indonesia

## 2. Teks terlalu pendek

**Input**

> "Rapat ditunda."

**Daftar periksa**

- [ ] Skill menyatakan teksnya terlalu pendek untuk dirangkum
- [ ] Tidak memanjangkan atau mengarang butir

## 3. Bahasa Inggris

**Input**

> "We moved our nightly job from cron to a queue. Failures now retry three times before alerting, which cut false alarms noticeably."

**Daftar periksa**

- [ ] P3: keluaran berbahasa Inggris
- [ ] P2: tidak menambah angka atau fakta di luar teks
