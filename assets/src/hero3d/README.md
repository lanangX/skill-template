# Sumber hero 3D

Hero di README dirender dari adegan Three.js (`hero3d.html`) menjadi animasi WebP dengan loop mulus. Dua versi dibuat, untuk tema terang dan gelap, dan dipilih README lewat `<picture>`. Hero tidak memuat teks, jadi tidak perlu dirender ulang saat Anda mengganti nama skill. Render ulang hanya kalau Anda ingin mengubah adegan atau warnanya.

## Render ulang

Kebutuhan: Node.js, Python 3, `pip install playwright pillow`, dan Chromium untuk Playwright (`playwright install chromium`).

```bash
cd assets/src/hero3d
npm install
python3 render.py dark 1100 340 48 16 ../../hero-dark.webp
python3 render.py light 1100 340 48 16 ../../hero-light.webp
```

Argumen `render.py`: tema (`dark` atau `light`), lebar, tinggi, jumlah frame, frame per detik, dan berkas keluaran. Kualitas diatur lewat variabel `Q` (bawaan 60, makin kecil makin ringan). Dengan kualitas 55 dan 48 frame, tiap berkas sekitar 1,5 MB. Render memakai WebGL lewat SwiftShader, jadi tidak butuh GPU, tapi membutuhkan beberapa menit.

Warna ada di objek `THEMES` di `hero3d.html`. Tampilan teks pada pelat (`SKILL.md`, `name: my-skill`) bisa diganti di fungsi `paperTexture`.
