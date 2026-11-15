# Menulis skill yang baik

Catatan praktis untuk mengisi `skills/<skill>/SKILL.md`.

## Deskripsi

Deskripsi di frontmatter adalah satu-satunya bagian yang dibaca agent sebelum memutuskan memakai skill. Tulis kapan skill dipakai, bukan hanya apa isinya, dan sebut kata yang biasa diucapkan pengguna ("ringkas ini", "review PR ini", "summarize this"). Batasnya 1024 karakter, dan `build.sh` memeriksanya.

## Isi

- Mulai dari alur singkat, lalu aturan, lalu format keluaran, lalu satu atau dua contoh.
- Jelaskan alasannya kalau aturan tidak jelas dengan sendirinya. Aturan yang punya alasan lebih mudah diikuti dengan tepat.
- Pindahkan bahan panjang atau jarang dipakai ke `references/` dan tautkan dari `SKILL.md` dengan kapan harus dibaca. `SKILL.md` yang ringkas lebih cepat dimuat dan lebih sulit disalahpahami.
- Taruh skrip yang dipanggil skill di `scripts/` dalam folder skill. Jangan taruh rahasia di dalamnya.

## Format keluaran

Kalau skill punya format tetap, tulis penandanya di `evals/<skill>.markers`. `build.sh` memastikan penanda itu ada di `SKILL.md` dan di `adapters/<skill>.md`, jadi dua file itu tidak melenceng satu sama lain.

## Menguji

Tulis kasus uji di `evals/<skill>-cases.md` sebelum mengubah perilaku, jalankan di sesi baru, dan catat hasilnya. Tambahkan kasus setiap kali Anda memperbaiki kesalahan yang terjadi di dunia nyata. Satu kali jalan per kasus hanya bukti awal, ulangi untuk perilaku yang penting.

## Adapter

Platform tanpa dukungan skill (Gem, Custom GPT, Space) butuh teks yang bisa ditempel sebagai instruksi. Ringkas `SKILL.md` ke satu halaman di `adapters/<skill>.md`, dengan format keluaran dan aturan yang sama.
