# Analytics setup

## What's wired up

**Microsoft Clarity** — installed in:
- `index.html`
- `resume/index.html`
- `../../Job-Search/resume/anna-dooley-resume.html` (canonical résumé source)

Project ID: `wu6ni1zrcu`

## Dashboard

https://clarity.microsoft.com → your `annadooleyink` project

First data appears within ~2 hours of the first visit (Clarity batches; not real-time like Cloudflare was).

## What you get

**Traffic basics:**
- Sessions, pages per session, scroll depth, time spent
- Top pages — `/` and `/resume/` show as separate rows
- Referrers — LinkedIn, Google, direct, email
- Countries, browsers, devices, OS

**Behavior (the part you wanted):**
- **Session recordings** — watch anonymized playback of real visitors moving through your site
- **Click heatmaps** — see exactly which case study cards / CTAs get clicked
- **Scroll heatmaps** — see where people stop scrolling
- **Dead clicks** — flags spots where users click but nothing happens (good UX signal)
- **Rage clicks** — repeated clicks indicating frustration
- **JS errors** captured automatically

## Privacy notes

- Clarity uses 1st-party cookies (Cloudflare didn't). For US-based traffic this is standard and uncontroversial.
- All text content in recordings is masked by default. Forms, inputs, anything `<input>` is redacted.
- If you ever get serious EU traffic and want strict GDPR compliance, you'd want a cookie consent banner. Not needed for now.
- Microsoft uses aggregated, non-PII data to improve their AI/ads products. This is the cost of free.

## Adding it to new pages

Just paste the snippet from any existing file into the `<head>` of the new page. The project ID stays the same — all data lands in one dashboard.

## If you ever want to switch later

Just delete the `<script>` block from each file. No other cleanup needed.
