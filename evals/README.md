# Evals

Kasus uji manual untuk menjaga perilaku inti skill saat `SKILL.md` diubah. Skill menghasilkan teks bebas, jadi penilaiannya memakai daftar periksa, bukan pencocokan string.

## Cara menjalankan

1. Pasang skill versi yang sedang diuji (lihat README akar).
2. Untuk tiap kasus di `<skill>-cases.md`, tempel bagian **Input** ke sesi baru.
3. Nilai keluaran dengan daftar periksa kasus itu. Satu butir gagal berarti kasus gagal.
4. Catat hasilnya di pull request: nama kasus, lolos atau gagal, catatan singkat.

## Penanda format

File `<skill>.markers` (satu penanda per baris) dipakai `scripts/build.sh`. Setiap penanda harus muncul di `SKILL.md` dan di `adapters/<skill>.md`, supaya format keluaran keduanya tidak melenceng. Hapus file itu kalau skill Anda tidak punya format tetap.

## Prinsip yang dijaga

| Kode | Prinsip |
|---|---|
| P1 | Format keluaran persis seperti di `SKILL.md` |
| P2 | Tidak menambah fakta yang tidak ada di input |
| P3 | Bahasa mengikuti input |

Ganti tabel ini dengan prinsip skill Anda.

## Kapan menambah kasus

Tambahkan kasus baru setiap kali Anda memperbaiki perilaku yang salah di dunia nyata, supaya kesalahan yang sama tidak kembali.
