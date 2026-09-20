#!/usr/bin/env bash
# Build the GitHub Pages site into docs/.
#
# index.html is authored as a body fragment so it can also be published as a
# Claude artifact (that host supplies its own <head>). A real web server does
# not, so this wraps it in a proper document — the viewport meta especially,
# without which phones render the page at 980px and zoom out.
#
# Usage:  ./build.sh     then commit docs/

set -euo pipefail
cd "$(dirname "$0")"

SRC=index.html
OUT=docs

[ -f "$SRC" ] || { echo "error: $SRC not found"; exit 1; }

rm -rf "$OUT"
mkdir -p "$OUT"

{
  echo '<!doctype html>'
  echo '<html lang="en">'
  echo '<head>'
  # charset, <title> and the font links come from the top of the source
  head -n 5 "$SRC"
  echo '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">'
  echo '<meta name="robots" content="noindex, nofollow">'
  echo '<meta name="description" content="Stefano turns thirty. Mataro, 8-11 October 2026: arrivals, transfer groups, the villa and the plan.">'
  echo '<meta name="theme-color" content="#e8e8e0" media="(prefers-color-scheme: light)">'
  echo '<meta name="theme-color" content="#111519" media="(prefers-color-scheme: dark)">'
  echo '</head>'
  echo '<body>'
  # everything from <style> onwards
  tail -n +6 "$SRC"
  echo '</body>'
  echo '</html>'
} > "$OUT/index.html"

cp -R photos "$OUT/photos"

# tell Pages not to run Jekyll over the output
touch "$OUT/.nojekyll"

# the page carries real people's names and flight numbers — keep crawlers off
printf 'User-agent: *\nDisallow: /\n' > "$OUT/robots.txt"

echo "built $OUT/index.html  ($(wc -c < "$OUT/index.html") bytes, $(ls "$OUT/photos" | wc -l) photos)"
