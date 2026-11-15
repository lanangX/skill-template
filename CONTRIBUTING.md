# Kontribusi

Terima kasih sudah mau membantu. Aturannya ringkas.

## Sebelum mulai

- Cek [issue](https://github.com/OWNER/skill-template/issues) yang sudah ada.
- Untuk perubahan besar pada perilaku skill, buka issue dulu supaya kita sepakat arahnya.
- Ikuti [Code of Conduct](CODE_OF_CONDUCT.md).

## Alur perubahan

1. Fork dan buat cabang: `git checkout -b feat/nama-singkat`.
2. Edit sumber kebenaran: `skills/<skill>/SKILL.md`.
3. Sesuaikan `adapters/<skill>.md` supaya format keluaran dan aturannya tetap sama.
4. Tambah atau perbarui kasus uji di [`evals/`](evals/README.md) kalau perilaku berubah, lalu jalankan kasusnya dan catat hasilnya di PR.
5. Perbarui [`CHANGELOG.md`](CHANGELOG.md) di bagian `[Unreleased]`.
6. Jalankan `./scripts/build.sh` sampai lolos.
7. Buka pull request memakai template yang tersedia.

## Versi dan rilis

Versi mengikuti SemVer dan harus sama di `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`, dan `CITATION.cff`:

- **Patch** (0.1.1): perbaikan kata, typo, contoh.
- **Minor** (0.2.0): kemampuan baru yang tidak mengubah format keluaran yang ada.
- **Major** (1.0.0): perubahan format keluaran.

Pemelihara merilis dengan membuat tag `vX.Y.Z`. Workflow rilis membangun zip dan melampirkannya ke GitHub Release.

## Gaya commit

Gunakan awalan singkat: `feat:`, `fix:`, `docs:`, `chore:`, `ci:`.
