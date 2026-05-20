# Analytics setup

## What's wired up

**Cloudflare Web Analytics** — beacon installed in:
- `index.html`
- `resume/index.html`
- `../../Job-Search/resume/anna-dooley-resume.html` (canonical résumé source)

Token already pasted in all three: `2192e83ca3274e7c9d0aa249ee9de474`.

## What you get

Cloudflare Web Analytics dashboard (https://dash.cloudflare.com → Analytics & Logs → Web Analytics → annadooleyink.com):

- **Total pageviews + unique visitors** by day/hour
- **Top pages** — `/` and `/resume/` show as separate rows (so you'll know how many resume views vs portfolio views)
- **Referrers** — LinkedIn, Google, direct, email (this is the most useful signal: where did this visitor come from?)
- **Countries, browsers, devices**
- **Time on page, bounce rate**

No cookies, no GDPR banner, ~5KB script, deferred load.

## What you DON'T get (and how to add it)

Cloudflare Web Analytics doesn't have a custom-events API, so you can't see "this visitor clicked the Healthfirst case study" or "this visitor clicked the LinkedIn link" out of the box.

For that, two free options:

### Option A: Microsoft Clarity (recommended for portfolios)
- Free, no caps
- **Session recordings** — literally watch anonymized recordings of visitors moving through your site
- **Heatmaps** — see exactly which case study cards get clicked, which sections people scroll past
- Privacy-friendly (masks all text by default)
- Setup: https://clarity.microsoft.com → create project → paste one `<script>` snippet alongside the CF beacon

This is actually closer to what you asked for ("idea of who is clicking what") — you'll literally see clicks and scroll behavior on a real human's session, not just aggregate counts.

### Option B: Plausible (paid, $9/mo)
- Clean custom event API
- Better for "give me a count of how many people clicked X" funnel-style data
- Less useful for "show me what happens" — that's Clarity's strength

If you want either added, just say the word.

## Viewing your data

1. Visit annadooleyink.com (in an incognito window if you're testing your own traffic — your normal browsing might be filtered out)
2. Go to https://dash.cloudflare.com → Analytics & Logs → Web Analytics → annadooleyink.com
3. First data within ~5 min; full breakdowns within ~30 min

## Notes

- The CF beacon won't fire on `localhost` — it filters out non-public hostnames. Only live-site data shows up.
- Cloudflare's free tier has no pageview cap.
- If you ever change the domain (e.g., switch from annadooleyink.com), update the property in CF dashboard.
