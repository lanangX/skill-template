#!/usr/bin/env bash
# Ubah template ini jadi repo skill Anda.
# Pakai: ./scripts/init.sh <nama-skill> <owner-github> "<nama penulis>" [--private]
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

usage() {
  echo 'Pakai: ./scripts/init.sh <nama-skill> <owner-github> "<nama penulis>" [--private]' >&2
  exit 1
}

[ "$#" -ge 3 ] || usage
NAME="$1"; OWNER="$2"; AUTHOR="$3"; PRIVATE="${4:-}"
[ -z "$PRIVATE" ] || [ "$PRIVATE" = "--private" ] || usage

[[ "$NAME" =~ ^[a-z][a-z0-9]*(-[a-z0-9]+)*$ ]] || { echo "Nama skill harus huruf kecil, angka, dan tanda hubung (contoh: code-reviewer)." >&2; exit 1; }
[ "${#NAME}" -le 64 ] || { echo "Nama skill maksimal 64 karakter." >&2; exit 1; }
case "$NAME" in *claude*|*anthropic*) echo "Nama skill tidak boleh memuat 'claude' atau 'anthropic'." >&2; exit 1;; esac
[ "$NAME" != "my-skill" ] || { echo "Pilih nama selain my-skill." >&2; exit 1; }
[[ "$OWNER" =~ ^[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?$ ]] || { echo "Owner GitHub tidak valid." >&2; exit 1; }
[ -d "skills/my-skill" ] || { echo "Template sudah pernah diinisialisasi (skills/my-skill tidak ada)." >&2; exit 1; }

python3 - "$NAME" "$OWNER" "$AUTHOR" "$PRIVATE" <<'PY'
import datetime, json, pathlib, re, sys

name, owner, author, private = sys.argv[1:5]
root = pathlib.Path(".")
title = " ".join(w.capitalize() for w in name.split("-"))
today = datetime.date.today().isoformat()
skip_dirs = {".git", "dist", "node_modules"}
text_ext = {".md", ".json", ".yml", ".yaml", ".sh", ".cff", ".txt", ".markers", ".svg", ".html", ".py", ""}

def files():
    for p in root.rglob("*"):
        if p.is_file() and not (set(p.parts) & skip_dirs) and p.suffix in text_ext and p.name != "init.sh":
            yield p

for p in files():
    t = p.read_text(encoding="utf-8")
    o = t
    t = t.replace("OWNER/skill-template", f"{owner}/{name}")
    t = t.replace("my-skill", name).replace("My Skill", title).replace("skill-template", name)
    t = t.replace("AUTHOR", author)
    t = re.sub(r"@OWNER\b", f"@{owner}", t)
    t = re.sub(r"\bOWNER\b", owner, t)
    t = re.sub(r"@starter\b", f"@{name}", t)
    if p.name == "marketplace.json":
        t = t.replace('"name": "starter"', f'"name": "{name}"').replace('"displayName": "Starter"', f'"displayName": "{title}"')
    if t != o:
        p.write_text(t, encoding="utf-8")

(root / "skills/my-skill").rename(root / f"skills/{name}")
(root / "adapters/my-skill.md").rename(root / f"adapters/{name}.md")
(root / "evals/my-skill-cases.md").rename(root / f"evals/{name}-cases.md")
(root / "evals/my-skill.markers").rename(root / f"evals/{name}.markers")

for f in (".claude-plugin/plugin.json", ".codex-plugin/plugin.json"):
    p = root / f
    d = json.loads(p.read_text())
    d["version"] = "0.1.0"
    p.write_text(json.dumps(d, indent=2, ensure_ascii=False) + "\n")

cff = root / "CITATION.cff"
c = cff.read_text()
c = re.sub(r"^version:.*$", "version: 0.1.0", c, flags=re.M)
c = re.sub(r"^date-released:.*$", f"date-released: {today}", c, flags=re.M)
cff.write_text(c)

cl = root / "CHANGELOG.md"
head = cl.read_text().split("## [Unreleased]")[0]
cl.write_text(
    head + "## [Unreleased]\n\n"
    f"## [0.1.0] - {today}\n\n### Added\n- Rilis awal dari template.\n\n"
    f"[Unreleased]: https://github.com/{owner}/{name}/compare/v0.1.0...HEAD\n"
    f"[0.1.0]: https://github.com/{owner}/{name}/releases/tag/v0.1.0\n"
)

readme = root / "README.md"
r = readme.read_text()
r = re.sub(r"<!-- template:start -->.*?<!-- template:end -->\n*", "", r, flags=re.S)
if private == "--private":
    r = "\n".join(l for l in r.split("\n") if "<!-- public-only -->" not in l)
else:
    r = r.replace(" <!-- public-only -->", "")
r = re.sub(r"\n{3,}", "\n\n", r)
readme.write_text(r)
PY

rm -f docs/GETTING-STARTED.md
echo
echo "Selesai. Berikutnya:"
echo "  1. Tulis skills/$NAME/SKILL.md dan adapters/$NAME.md, sesuaikan evals/"
echo "  2. Ubah description di SKILL.md, kedua plugin.json, marketplace.json, dan README"
echo "  3. ./scripts/build.sh"
echo "  4. git add . && git commit -m 'feat: rilis awal'"
rm -- "$0"
