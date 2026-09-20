# Sterthday

One page for Stefano's 30th — Villa Can Bagués, Mataró, 8–11 October 2026.
Arrivals board, transfer groups, the villa, and the plan.

## Layout

```
index.html        the page — edit this one
photos/           villa photos
build.sh          wraps index.html into docs/ for GitHub Pages
docs/             generated — what Pages serves (do not edit by hand)
data/             the arrivals spreadsheet (git-ignored, stays local)
```

`index.html` is written as a body fragment with no `<head>`, so the same file
can be published as a Claude artifact. `build.sh` adds the doctype, the
viewport meta and the rest of the head to produce `docs/index.html`.

## Editing

Everything you change lives in one marked block near the bottom of
`index.html`, between the two banner comments:

| Constant  | What it holds |
|-----------|---------------|
| `EVENT`   | name, dates, the opening line |
| `GROUPS`  | transfer groups — `D1G1`, `D2G1`, `D2G2`, `SOLO` |
| `GUESTS`  | one row per person, from the Arrival sheet |
| `VENUE`   | address, coordinates, check-in / check-out, map + listing links |
| `NOTES`   | the four practical cards |
| `PHOTOS`  | gallery; the first entry is the big lead image |
| `PLAN`    | the four days — `tbc: true` prints a TBC tag |

The arrivals board, the day headers, the transfer cards, the counts in the
header and the name search all rebuild themselves from `GUESTS` and `GROUPS`.
You never touch the markup.

A `GUESTS` row:

```js
{ name:"Ilaria Coppola", from:"Fiumicino", cc:"IT", mode:"flight",
  op:"VY6111", at:"2026-10-08T23:45", point:"Airport", group:"D1G1" }
```

`mode` is `flight` or `train`; `op` is the flight number (leave empty and the
board prints "number to come"); `at` is local Barcelona time; `point` is
`Airport` or `Sants`; `group` is one of the `GROUPS` keys.

## Publishing

```bash
./build.sh
git add -A
git commit -m "Update the page"
git push
```

Then on GitHub: **Settings → Pages → Source: Deploy from a branch →
`main` / `docs`**.

## Before you make the repo public

The page lists fourteen real people by name with their flight numbers and
arrival times. On a public repo that is readable by anyone with the URL, and
so is the commit history.

Two things are already in place: `data/` is git-ignored so the spreadsheet
never leaves your machine, and the built page carries `noindex, nofollow`
plus a `robots.txt` that disallows crawlers, so it should stay out of search
results.

That keeps it out of Google. It does not make it private. If you want it
actually private, use a private repo — GitHub Pages from a private repo needs
a paid plan — or drop the surnames and flight numbers and keep those in the
group chat instead.
