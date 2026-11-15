# AGENTS.md

Repo `skill-template`: kerangka repo skill agent (format `SKILL.md`) yang siap dipakai untuk Claude Code, claude.ai, Codex, dan platform lain.

## Urutan baca

1. `README.md` untuk tujuan dan cara pasang.
2. `skills/<skill>/SKILL.md` untuk isi skill (sumber kebenaran).
3. `adapters/<skill>.md` untuk versi ringkas bagi platform tanpa dukungan skill.
4. `evals/` untuk kasus uji dan prinsip yang dijaga.
5. `CONTRIBUTING.md` untuk alur perubahan dan aturan versi.

## Struktur

- `skills/<skill>/`: `SKILL.md` wajib, `references/` untuk bahan yang dibaca saat perlu, `scripts/` untuk skrip yang dipanggil skill.
- `.claude-plugin/`: `marketplace.json`, `plugin.json`, `icon.png`.
- `.codex-plugin/plugin.json` dan `.agents/plugins/marketplace.json`: manifest Codex.
- `adapters/`: teks siap tempel untuk Gem, Custom GPT, dan Space.
- `assets/`: hero 3D, diagram SVG, dan sumbernya di `assets/src/`.
- `evals/`: kasus uji manual dan `<skill>.markers`.
- `scripts/build.sh`: validasi dan bangun zip ke `dist/`.
- `.github/`: CI, rilis, Dependabot, CODEOWNERS, template issue dan PR.
- `dist/`: hasil build, tidak di-commit.

## Aturan

- `SKILL.md` adalah satu-satunya sumber. `adapters/<skill>.md` dan zip di `dist/` adalah turunannya. Setelah mengubah `SKILL.md`, sesuaikan adapter dan jalankan `./scripts/build.sh`.
- Penanda format keluaran ada di `evals/<skill>.markers` dan diperiksa `build.sh` di `SKILL.md` dan adapter.
- Versi harus sama di `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`, dan `CITATION.cff`, serta punya bagian di `CHANGELOG.md`.
- Nama plugin harus sama di kedua `marketplace.json` dan kedua `plugin.json`. Nama tidak boleh memuat `claude` atau `anthropic`.
- Klaim cara pasang di platform lain harus bisa ditelusuri ke dokumentasi resmi. Yang belum diuji ditulis "belum diuji".
- Deskripsi skill menjawab kapan skill dipakai, bukan hanya apa isinya. Batasnya 1024 karakter.
