# Memulai dari template

Panduan ini hanya ada di template dan dihapus oleh `init.sh`.

## 1. Buat repo dari template

Di halaman template klik **Use this template**, pilih **Public** atau **Private**, lalu clone hasilnya. Dengan GitHub CLI:

```bash
gh repo create owner-anda/nama-skill-anda --template OWNER/skill-template --public --clone
```

Ganti `--public` dengan `--private` untuk repo privat.

## 2. Jalankan init

```bash
cd nama-skill-anda
./scripts/init.sh nama-skill-anda owner-anda "Nama Anda"
```

Untuk repo privat, tambahkan `--private` di akhir. Skrip akan:

- mengganti `my-skill`, `OWNER`, `AUTHOR`, dan nama marketplace di semua file;
- mengganti nama folder `skills/my-skill`, adapter, dan berkas evals;
- menurunkan versi ke `0.1.0` dan membuat ulang `CHANGELOG.md`;
- membuang blok template dari README, dan badge yang butuh repo publik bila `--private`;
- menghapus panduan ini dan dirinya sendiri.

Nama skill harus huruf kecil dengan tanda hubung, maksimal 64 karakter, dan tidak boleh memuat `claude` atau `anthropic`. Nama repo sebaiknya sama dengan nama skill.

## 3. Tulis skill Anda

1. Ganti isi `skills/<nama>/SKILL.md`. Deskripsi harus menjawab kapan skill dipakai, maksimal 1024 karakter.
2. Taruh bahan panjang di `skills/<nama>/references/` dan tautkan dari `SKILL.md`.
3. Sesuaikan `adapters/<nama>.md` supaya sama isinya dengan `SKILL.md`.
4. Perbarui `evals/<nama>.markers` (satu penanda format per baris, atau hapus berkasnya) dan kasus uji di `evals/<nama>-cases.md`.
5. Ubah `description` di kedua `plugin.json`, `marketplace.json`, dan README.
6. Jalankan `./scripts/build.sh`.

## 4. Repo privat

- Badge CI, rilis, lisensi, dan bintang dari shields.io tidak tampil untuk repo privat, jadi `--private` membuangnya.
- Pemasangan dari repo privat membutuhkan akses git ke repo itu di komputer pengguna (misalnya sudah login lewat `gh auth login`). Jalur ini belum diuji.
- Private vulnerability reporting dan Dependabot tersedia untuk repo privat tergantung paket GitHub Anda.

## 5. Publikasi

```bash
git add .
git commit -m "feat: rilis awal"
git push -u origin main
```

Untuk rilis, naikkan versi di kedua `plugin.json` dan `CITATION.cff`, tulis `CHANGELOG.md`, lalu buat tag:

```bash
git tag v0.1.0
git push origin v0.1.0
```

Workflow rilis membangun zip dan melampirkannya ke GitHub Release.

## 6. Hero 3D

Hero di README tidak memuat teks, jadi tidak perlu diganti. Untuk mengubah adegan atau warnanya, lihat [assets/src/hero3d/README.md](../assets/src/hero3d/README.md).
