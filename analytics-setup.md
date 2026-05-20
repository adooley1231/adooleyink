# Analytics setup

Cloudflare Web Analytics is wired into `index.html` and `resume/index.html`. You need to paste your account token in two places before it starts collecting data.

## 1. Create a Cloudflare account + property

1. Go to https://dash.cloudflare.com/sign-up — free account, no credit card.
2. Once in: left nav → **Analytics & Logs** → **Web Analytics**.
3. Click **Add a site**.
4. Choose **"Add manually" / "Without proxying through Cloudflare"** (since your DNS is on GitHub Pages, not Cloudflare).
5. Hostname: `annadooleyink.com`
6. Cloudflare gives you a snippet that looks like:

   ```html
   <script defer src='https://static.cloudflareinsights.com/beacon.min.js'
     data-cf-beacon='{"token": "abc123def456..."}'></script>
   ```

7. Copy the token value (the long string after `"token":`).

## 2. Paste the token

Replace `REPLACE_WITH_CLOUDFLARE_TOKEN` in these three files:

- `index.html` (top of file, in `<head>`)
- `resume/index.html` (in `<head>`)
- `../../Job-Search/resume/anna-dooley-resume.html` (canonical resume source — also in `<head>`)

Fastest way:

```bash
cd /Users/annadooley/Portfolio/live-site
sed -i '' 's/REPLACE_WITH_CLOUDFLARE_TOKEN/YOUR_TOKEN_HERE/g' index.html resume/index.html
sed -i '' 's/REPLACE_WITH_CLOUDFLARE_TOKEN/YOUR_TOKEN_HERE/g' /Users/annadooley/Job-Search/resume/anna-dooley-resume.html
```

## 3. Commit + push

```bash
cd /Users/annadooley/Portfolio/live-site
git add index.html resume/index.html analytics-setup.md
git commit -m "add Cloudflare Web Analytics + virtual pageview click tracking"
git push
```

(The canonical resume publishes separately via its own flow.)

## 4. View your data

Dashboard: https://dash.cloudflare.com → Analytics & Logs → Web Analytics → annadooleyink.com

Expect first data within ~5 minutes of first visit.

## What you'll see

**Standard:**
- Pageviews, unique visitors, time-on-site, bounce rate
- Top referrers (LinkedIn, Google, direct, etc.)
- Countries, browsers, devices
- Top pages — `/`, `/resume/` show up as their own rows

**Custom virtual pageviews** (added via the `window.track()` helper in `index.html`):
- `/case/destination-lottery`, `/case/healthfirst`, `/case/clubhouse`, `/case/mobile-strategy`, `/case/cx-blueprint`, `/case/us-foods` — fires when a case study card is opened
- `/click/email` — fires when any mailto link is clicked
- `/click/linkedin` — fires when LinkedIn link is clicked
- `/click/resume` — fires when résumé link is clicked from the home page
- `/click/outbound` — fires for any other external link

These all show up in the "Top pages" section of the Cloudflare dashboard alongside real pages. To see only click events, filter by path containing `/click/` or `/case/`.

## Adding new tracked events

In any click handler:

```js
window.track('/whatever-virtual-path');
```

That's it. It'll show up in Cloudflare within minutes.

## Notes

- No cookies, no GDPR banner needed (Cloudflare WA is privacy-friendly by design).
- ~5KB script, loaded with `defer` so it doesn't block render.
- The `track()` helper uses `history.pushState` + immediate `replaceState` to spoof a pageview without actually changing the visible URL or breaking the back button.
- If you ever want richer event analytics (funnels, custom dimensions, conversion goals), Plausible ($9/mo at plausible.io) is the easy upgrade — same script pattern, ~30 seconds to swap in.
