#!/usr/bin/env bash
# Validasi repo dan bangun paket siap unggah ke dist/.
# Jalankan dari mana saja: ./scripts/build.sh
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$ROOT/dist"

fail() { echo "GAGAL: $*" >&2; exit 1; }

echo "==> JSON valid"
for f in \
  "$ROOT/.claude-plugin/marketplace.json" \
  "$ROOT/.claude-plugin/plugin.json" \
  "$ROOT/.codex-plugin/plugin.json" \
  "$ROOT/.agents/plugins/marketplace.json"; do
  python3 -c 'import json,sys; json.load(open(sys.argv[1]))' "$f" || fail "JSON tidak valid: $f"
  echo "ok  ${f#"$ROOT"/}"
done

echo "==> Konsistensi versi, nama, dan CHANGELOG"
python3 - "$ROOT" <<'PY' || fail "konsistensi versi atau nama"
import json, re, sys, pathlib
root = pathlib.Path(sys.argv[1])
claude = json.load(open(root / ".claude-plugin/plugin.json"))
codex = json.load(open(root / ".codex-plugin/plugin.json"))
mk_c = json.load(open(root / ".claude-plugin/marketplace.json"))
mk_x = json.load(open(root / ".agents/plugins/marketplace.json"))
errs = []
if claude["name"] != codex["name"]:
    errs.append("nama plugin beda antara manifest Claude dan Codex")
if claude["version"] != codex["version"]:
    errs.append(f"versi beda: claude={claude['version']} codex={codex['version']}")
if mk_c["name"] != mk_x["name"]:
    errs.append(f"nama marketplace beda: claude={mk_c['name']} codex={mk_x['name']}")
for label, mk in (("claude", mk_c), ("codex", mk_x)):
    if claude["name"] not in [p["name"] for p in mk["plugins"]]:
        errs.append(f"marketplace {label} tidak memuat plugin {claude['name']}")
if not re.search(rf"^## \[{re.escape(claude['version'])}\]", (root / "CHANGELOG.md").read_text(), re.M):
    errs.append(f"CHANGELOG.md tidak punya bagian untuk versi {claude['version']}")
cff = (root / "CITATION.cff").read_text()
m = re.search(r"^version:\s*(\S+)", cff, re.M)
if not m or m.group(1).strip('"') != claude["version"]:
    errs.append("versi di CITATION.cff beda dengan plugin.json")
if errs:
    print("\n".join(errs)); sys.exit(1)
print(f"ok  plugin {claude['name']} versi {claude['version']}")
PY

test -f "$ROOT/.claude-plugin/icon.png" || fail "icon.png tidak ada"

SKILLS=()
for d in "$ROOT"/skills/*/; do
  [ -f "$d/SKILL.md" ] && SKILLS+=("$(basename "$d")")
done
[ "${#SKILLS[@]}" -gt 0 ] || fail "tidak ada skill di skills/"

for S in "${SKILLS[@]}"; do
  SRC="$ROOT/skills/$S/SKILL.md"
  ADAPTER="$ROOT/adapters/$S.md"
  MARKERS="$ROOT/evals/$S.markers"
  echo
  echo "##### $S"
  [[ "$S" =~ ^[a-z][a-z0-9]*(-[a-z0-9]+)*$ ]] || fail "$S: nama folder harus huruf kecil dan tanda hubung"
  head -1 "$SRC" | grep -q '^---$' || fail "$S: frontmatter YAML tidak ditemukan"
  grep -q "^name: $S$" "$SRC" || fail "$S: name di frontmatter harus '$S'"
  DESC="$(grep -m1 '^description: ' "$SRC" | sed 's/^description: //')"
  [ -n "$DESC" ] || fail "$S: description kosong"
  [ "${#DESC}" -le 1024 ] || fail "$S: description ${#DESC} karakter, batasnya 1024"
  echo "ok  frontmatter (description ${#DESC} karakter)"

  test -f "$ADAPTER" || fail "adapter tidak ada: adapters/$S.md"
  if [ -f "$MARKERS" ]; then
    while IFS= read -r marker; do
      [ -z "$marker" ] && continue
      grep -qF -- "$marker" "$SRC" || fail "$S: SKILL.md tidak memuat penanda '$marker'"
      grep -qF -- "$marker" "$ADAPTER" || fail "$S: adapter tidak memuat penanda '$marker'"
    done < "$MARKERS"
    echo "ok  penanda format sama di SKILL.md dan adapter"
  fi
done

echo
echo "==> Aset"
for svg in "$ROOT"/assets/*.svg; do
  python3 -c 'import sys, xml.dom.minidom as m; m.parse(sys.argv[1])' "$svg" || fail "SVG tidak well-formed: $svg"
  echo "ok  ${svg#"$ROOT"/}"
done

if command -v claude >/dev/null 2>&1; then
  echo "==> claude plugin validate"
  claude plugin validate "$ROOT"
else
  echo "==> CLI 'claude' tidak ada, lewati claude plugin validate"
fi

echo "==> Bangun zip"
rm -rf "$DIST"
mkdir -p "$DIST"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

for S in "${SKILLS[@]}"; do
  mkdir -p "$TMP/claude/$S"
  cp -R "$ROOT/skills/$S/." "$TMP/claude/$S/"
  (cd "$TMP/claude" && zip -qr "$DIST/$S-claude-ai.zip" "$S")
  mkdir -p "$TMP/perplexity/$S"
  cp -R "$ROOT/skills/$S/." "$TMP/perplexity/$S/"
  (cd "$TMP/perplexity/$S" && zip -qr "$DIST/$S-perplexity.zip" .)
done

ls -la "$DIST"
echo "Selesai."
