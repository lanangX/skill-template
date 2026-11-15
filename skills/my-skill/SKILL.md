---
name: my-skill
description: Merangkum teks panjang (artikel, thread, catatan rapat) menjadi satu kalimat inti dan tiga butir. Gunakan saat pengguna menempelkan teks dan meminta "ringkas ini", "rangkum", "intinya apa", atau "summarize this", meskipun tidak menyebut kata "skill". Ini skill contoh bawaan template, ganti isinya dengan skill Anda.
---

# My Skill

Skill contoh bawaan template. Ganti nama, deskripsi, dan isinya. Yang perlu dipertahankan adalah polanya: deskripsi yang menyebut kapan skill dipakai, instruksi yang ringkas, dan format keluaran yang tetap.

## Alur

1. Baca teks sampai habis. Tentukan bahasa dan jenisnya (artikel, thread, catatan).
2. Temukan satu gagasan utama. Kalau ada dua, pilih yang paling banyak mendapat ruang di teks.
3. Tulis keluaran sesuai format di bawah. Detail aturan ada di [references/example.md](references/example.md), baca hanya kalau ragu soal batas panjang.

## Aturan

- Ikuti bahasa teks asli.
- Jangan menambah fakta yang tidak ada di teks.
- Satu butir satu gagasan, maksimal satu kalimat.
- Teks terlalu pendek untuk dirangkum (di bawah dua kalimat): katakan begitu, jangan memanjangkan.

## Format keluaran

Gunakan persis:

```
Inti: [satu kalimat]
Butir:
- [butir 1]
- [butir 2]
- [butir 3]
```

## Contoh

**Input:** "Tim kami memindahkan build dari Jenkins ke GitHub Actions. Waktu build turun dari 14 menit ke 9 menit karena cache dependensi. Biayanya naik sedikit karena runner berbayar."

```
Inti: Pindah dari Jenkins ke GitHub Actions memangkas waktu build, dengan biaya sedikit lebih tinggi.
Butir:
- Waktu build turun dari 14 menit ke 9 menit.
- Penyebabnya cache dependensi.
- Biaya naik sedikit karena runner berbayar.
```
