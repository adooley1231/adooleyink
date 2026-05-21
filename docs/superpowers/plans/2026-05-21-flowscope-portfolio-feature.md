# FlowScope on Portfolio + Résumé — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a FlowScope callout to the portfolio AI section and a Selected Projects block to the résumé, per the design spec at `docs/superpowers/specs/2026-05-21-flowscope-portfolio-feature-design.md`.

**Architecture:** Two static-HTML surfaces, edited directly. Portfolio is a single-file `index.html` deployed to GitHub Pages via the `adooley1231/adooleyink` repo. Résumé has a canonical at `/Users/annadooley/Job-Search/resume/anna-dooley-resume.html` that gets manually mirrored to `/Users/annadooley/Portfolio/live-site/resume/index.html` (the published copy). One new image asset (`assets/flowscope-canvas.png`) is added to the portfolio repo.

**Tech Stack:** Hand-written HTML/CSS. No build step on the portfolio. CSS uses custom properties already defined in the file (`--ink`, `--paper`, `--hi`, `--bw`, `--display`, `--pad`). No JavaScript needed for these changes.

**Verification approach:** This is static HTML/copy work — no unit tests. Each task includes a manual verification step (open in browser, check responsive breakpoint, check print preview). The skill's TDD pattern is adapted to "make the change → verify visually → commit."

**Note on canonical sources:**
- Portfolio: edit `/Users/annadooley/Portfolio/live-site/index.html` directly. The older `publish.sh` references a canonical at `~/Downloads/` that no longer exists; recent commits show direct edits to `live-site/index.html`. If a separate canonical at `~/Portfolio/explorations/anna-dooley-portfolio.html` is still in use, mirror the edits there too (out of scope for this plan unless Anna confirms).
- Résumé: edit `Job-Search/resume/anna-dooley-resume.html` first (canonical), then copy to `live-site/resume/index.html` (published). The two files differ only in a single comment string and should otherwise stay identical.

---

## File Structure

| File | Action | Purpose |
|---|---|---|
| `/Users/annadooley/Portfolio/live-site/assets/flowscope-canvas.png` | Create (move from `~/Desktop/`) | Canvas screenshot for the AI callout |
| `/Users/annadooley/Portfolio/live-site/index.html` | Modify (CSS block ~line 671, HTML markup ~line 1624, mobile rules ~line 1313) | Add `.ai .flowscope` callout block |
| `/Users/annadooley/Job-Search/resume/anna-dooley-resume.html` | Modify (rail section ~line 448, plain-text view ~line 595) | Add Selected Projects block (styled + plain-text) |
| `/Users/annadooley/Portfolio/live-site/resume/index.html` | Overwrite from canonical | Published résumé copy |

---

## Task 1: Move the FlowScope canvas screenshot into the portfolio repo

**Files:**
- Source: `/Users/annadooley/Desktop/Screenshot 2026-05-21 at 9.18.46 AM.png`
- Destination: `/Users/annadooley/Portfolio/live-site/assets/flowscope-canvas.png`

- [ ] **Step 1: Verify the source screenshot exists**

Run:
```bash
ls -la "/Users/annadooley/Desktop/Screenshot 2026-05-21 at 9.18.46 AM.png"
```
Expected: file listing with non-zero size. If missing, ask Anna to re-export from FlowScope at the canvas view shown in the spec §5.2 (6 screens visible, "Authenticated?" diamond, edge labels readable, sidebar visible, dark theme, top bar visible).

- [ ] **Step 2: Verify destination directory exists**

Run:
```bash
ls -d /Users/annadooley/Portfolio/live-site/assets/
```
Expected: directory listing. (It exists — the portfolio repo has an `assets/` folder with 49 existing files.)

- [ ] **Step 3: Copy the screenshot to the assets folder with a clean filename**

Run:
```bash
cp "/Users/annadooley/Desktop/Screenshot 2026-05-21 at 9.18.46 AM.png" /Users/annadooley/Portfolio/live-site/assets/flowscope-canvas.png
```

- [ ] **Step 4: Verify the file is in place and reasonably sized**

Run:
```bash
ls -la /Users/annadooley/Portfolio/live-site/assets/flowscope-canvas.png
```
Expected: file listing, size > 200KB (full-resolution PNG of a 1920px-wide canvas). If smaller than ~50KB, the screenshot may be corrupted or the wrong file — investigate.

- [ ] **Step 5: Commit the asset**

```bash
cd /Users/annadooley/Portfolio/live-site && \
git add assets/flowscope-canvas.png && \
git commit -m "Add FlowScope canvas screenshot for AI section callout"
```

---

## Task 2: Confirm FlowScope deploy URL

The live demo link in both surfaces must point to the deployed FlowScope POC. Confirm the URL before wiring it into the markup.

**Files:** none (verification only)

- [ ] **Step 1: Check the FlowScope vite config base path**

Run:
```bash
grep -E "base:" /Users/annadooley/Projects/flowscope-poc/vite.config.js
```
Expected: `base: '/flowscope-poc/',`

- [ ] **Step 2: Check that the GitHub Pages deploy workflow is set up**

Run:
```bash
ls /Users/annadooley/Projects/flowscope-poc/.github/workflows/
```
Expected: a deploy workflow file (e.g. `deploy.yml`).

- [ ] **Step 3: Verify the live URL is reachable**

Open in a browser: `https://adooley1231.github.io/flowscope-poc/`
Expected: the FlowScope canvas loads. If 404, check the repo's Settings → Pages tab in GitHub and confirm the deploy workflow has run successfully. If not yet deployed, push a commit on `main` to trigger the workflow.

**Lock these URLs for use in Tasks 4 and 6:**
- Live demo: `https://adooley1231.github.io/flowscope-poc/`
- GitHub: `https://github.com/adooley1231/flowscope-poc`

---

## Task 3: Add the AI callout CSS to the portfolio

**Files:**
- Modify: `/Users/annadooley/Portfolio/live-site/index.html` (CSS block at line 671, just after the `.ai .pull .red` rule)

The new CSS introduces a `.ai .flowscope` callout that lives inside the AI section. It uses the same paper-on-ink inversion, same border tokens (`var(--bw) solid var(--paper)`), and same typography family (`var(--display)`) as the surrounding `.ai .grid4` and `.ai .pull` blocks. Two-column layout on desktop (image left, text right), stacked on mobile.

- [ ] **Step 1: Open the file and locate the insertion point**

The new CSS goes immediately after this existing rule (around line 671):

```css
  .ai .pull .red { color: var(--hi); }
```

And before the next section comment:

```css
  /* ----- STRATEGY STACK ----- */
```

- [ ] **Step 2: Insert the callout CSS**

Use the Edit tool. The `old_string` should be:

```
  .ai .pull .red { color: var(--hi); }

  /* ----- STRATEGY STACK ----- */
```

The `new_string` should be:

```
  .ai .pull .red { color: var(--hi); }

  /* ----- AI: FLOWSCOPE CALLOUT ----- */
  .ai .flowscope {
    margin-top: 48px;
    border: var(--bw) solid var(--paper);
    display: grid;
    grid-template-columns: 1.2fr 1fr;
    gap: 0;
  }
  .ai .flowscope .shot {
    border-right: var(--bw) solid var(--paper);
    background: var(--paper);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
  }
  .ai .flowscope .shot img {
    width: 100%;
    height: auto;
    display: block;
  }
  .ai .flowscope .copy {
    padding: 32px;
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  .ai .flowscope .eyebrow {
    font-family: var(--mono, monospace);
    font-size: 11px;
    text-transform: uppercase;
    letter-spacing: .14em;
    color: var(--hi);
  }
  .ai .flowscope h3 {
    font-family: var(--display);
    font-size: clamp(22px, 2vw, 32px);
    line-height: 1.05;
    letter-spacing: -.01em;
    text-transform: uppercase;
    margin: 0;
  }
  .ai .flowscope .tagline {
    font-size: 15px;
    line-height: 1.55;
  }
  .ai .flowscope .trio {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin: 4px 0;
  }
  .ai .flowscope .trio .row {
    display: grid;
    grid-template-columns: 140px 1fr;
    gap: 12px;
    font-size: 13px;
    line-height: 1.5;
  }
  .ai .flowscope .trio .row b {
    font-family: var(--display);
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: .01em;
    color: var(--hi);
  }
  .ai .flowscope .closer {
    font-family: var(--display);
    font-size: clamp(16px, 1.6vw, 22px);
    line-height: 1.15;
    letter-spacing: -.01em;
    text-transform: uppercase;
    padding-top: 16px;
    border-top: 1px solid var(--paper);
  }
  .ai .flowscope .links {
    display: flex;
    gap: 16px;
    font-family: var(--mono, monospace);
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: .12em;
  }
  .ai .flowscope .links a {
    color: var(--paper);
    text-decoration: none;
    border-bottom: 1px solid var(--paper);
    padding-bottom: 2px;
    transition: color .15s ease, border-color .15s ease;
  }
  .ai .flowscope .links a:hover {
    color: var(--hi);
    border-bottom-color: var(--hi);
  }

  /* ----- STRATEGY STACK ----- */
```

- [ ] **Step 3: Verify the CSS was inserted correctly**

Run:
```bash
grep -n "AI: FLOWSCOPE CALLOUT\|\.ai \.flowscope" /Users/annadooley/Portfolio/live-site/index.html | head
```
Expected: at least one line showing the new section comment and several `.ai .flowscope` rule selectors.

---

## Task 4: Add the AI callout mobile CSS

**Files:**
- Modify: `/Users/annadooley/Portfolio/live-site/index.html` (mobile media query block at line ~1312)

The existing mobile rule collapses `.ai .grid4` from 4-column to 2-column. The callout needs to collapse from 2-column to stacked (image on top, copy below).

- [ ] **Step 1: Locate the existing mobile rules for the AI section**

Find this existing line in the mobile `@media` block (around line 1312):

```css
    .ai .grid4 { grid-template-columns: 1fr 1fr; }
    .ai .body { padding: 36px var(--pad); }
```

- [ ] **Step 2: Insert callout mobile rules immediately after**

Use the Edit tool. The `old_string`:

```
    .ai .grid4 { grid-template-columns: 1fr 1fr; }
    .ai .body { padding: 36px var(--pad); }
```

The `new_string`:

```
    .ai .grid4 { grid-template-columns: 1fr 1fr; }
    .ai .body { padding: 36px var(--pad); }

    .ai .flowscope { grid-template-columns: 1fr; }
    .ai .flowscope .shot {
      border-right: 0;
      border-bottom: var(--bw) solid var(--paper);
    }
    .ai .flowscope .copy { padding: 24px; gap: 16px; }
    .ai .flowscope .trio .row { grid-template-columns: 1fr; gap: 2px; }
    .ai .flowscope .trio .row b { font-size: 14px; }
```

- [ ] **Step 3: Verify the mobile rules were inserted**

Run:
```bash
grep -n "\.ai \.flowscope {" /Users/annadooley/Portfolio/live-site/index.html
```
Expected: two matches (one in the main CSS block, one in the mobile media query).

---

## Task 5: Add the AI callout HTML markup

**Files:**
- Modify: `/Users/annadooley/Portfolio/live-site/index.html` (AI section, between `.grid4` close and `.pull` open, around line 1624)

The callout sits inside the existing `<section class="ai">` block, **below** the four-item grid and **above** the existing pull quote.

- [ ] **Step 1: Locate the insertion point**

Find this existing markup (around lines 1623-1625):

```html
    </div>

    <div class="pull">→ AI doesn't replace the design call. It just makes the <span class="red">cheapest</span> version of "let's see it" actually possible.</div>
```

The first `</div>` closes the `<div class="grid4">`. The `<div class="pull">` is the existing pull quote. The new callout goes between them.

- [ ] **Step 2: Insert the callout HTML**

Use the Edit tool. The `old_string`:

```
    </div>

    <div class="pull">→ AI doesn't replace the design call. It just makes the <span class="red">cheapest</span> version of "let's see it" actually possible.</div>
```

The `new_string`:

```
    </div>

    <div class="flowscope">
      <div class="shot">
        <img src="assets/flowscope-canvas.png" alt="FlowScope canvas — six screens connected by trigger edges with an Authenticated? decision diamond, sidebar showing path filters and tag filters for error/loading/empty states, dark theme." loading="lazy" />
      </div>
      <div class="copy">
        <div class="eyebrow">Building this</div>
        <h3>FlowScope</h3>
        <p class="tagline">Designers are now building in code. Once you have 8 screens of it, there's no way to see the system. FlowScope is the zoom-out &mdash; assemble the flow, surface every state across viewports, present end-to-end, and hand off to dev with comments lifted back to Claude Code as code references.</p>
        <div class="trio">
          <div class="row"><b>Zoom out</b><span>Assemble your vibe-coded prototypes into one system view. Walk the flow end-to-end the way a user would.</span></div>
          <div class="row"><b>See every state</b><span>Error, loading, empty, success &mdash; across desktop and mobile, in context of the flow. Spot gaps before dev does.</span></div>
          <div class="row"><b>Comment &amp; hand off</b><span>Comments lift code references &mdash; file, component, line &mdash; and route back to Claude Code or Cursor to implement. The canvas becomes the handoff artifact.</span></div>
        </div>
        <div class="closer">The bridge between building in code and presenting like a designer.</div>
        <div class="links">
          <a href="https://adooley1231.github.io/flowscope-poc/" target="_blank" rel="noopener">Live demo &rarr;</a>
          <a href="https://github.com/adooley1231/flowscope-poc" target="_blank" rel="noopener">GitHub &rarr;</a>
        </div>
      </div>
    </div>

    <div class="pull">→ AI doesn't replace the design call. It just makes the <span class="red">cheapest</span> version of "let's see it" actually possible.</div>
```

- [ ] **Step 3: Verify the markup is in place**

Run:
```bash
grep -n "class=\"flowscope\"\|flowscope-canvas.png" /Users/annadooley/Portfolio/live-site/index.html
```
Expected: at least two matches — the wrapping `<div class="flowscope">` and the `<img src="assets/flowscope-canvas.png">`.

---

## Task 6: Verify the portfolio callout renders correctly

**Files:** none (verification only)

- [ ] **Step 1: Open the portfolio in a browser**

Open `file:///Users/annadooley/Portfolio/live-site/index.html` in a browser (or start a local server: `cd /Users/annadooley/Portfolio/live-site && python3 -m http.server 8000` then visit `http://localhost:8000`).

- [ ] **Step 2: Scroll to the AI section ("AI in the work") and verify desktop layout**

Expected at desktop width (≥1100px):
- Four existing grid items render unchanged
- Below them, a new bordered block with the FlowScope screenshot on the left and copy on the right
- Image fills the left column without distortion
- Headline "FLOWSCOPE" in display font, eyebrow "Building this" in orange/hi color
- Three labeled rows ("Zoom out", "See every state", "Comment & hand off")
- Closer line in caps at the bottom, separated from the trio by a thin line
- Two text links "Live demo →" and "GitHub →" at the very bottom
- Original pull quote ("AI doesn't replace the design call…") renders below the callout, unchanged

- [ ] **Step 3: Resize the browser to mobile width (≤720px) and verify**

Expected:
- The callout collapses to single column
- Image sits on top of the copy with a horizontal border between them
- All text remains readable, no horizontal scroll
- Links remain tappable

- [ ] **Step 4: Click both links and confirm they open in a new tab**

Expected:
- "Live demo →" opens `https://adooley1231.github.io/flowscope-poc/` in a new tab and the FlowScope canvas loads
- "GitHub →" opens `https://github.com/adooley1231/flowscope-poc` in a new tab

- [ ] **Step 5: Check the existing AI section pull quote still reads correctly**

Expected: the pull quote ("AI doesn't replace the design call…") sits below the callout and visually closes the section.

- [ ] **Step 6: Commit the portfolio changes**

```bash
cd /Users/annadooley/Portfolio/live-site && \
git add index.html && \
git commit -m "Add FlowScope callout to AI section"
```

---

## Task 7: Add Selected Projects block to the canonical résumé

**Files:**
- Modify: `/Users/annadooley/Job-Search/resume/anna-dooley-resume.html` (rail section ~line 448 and plain-text view ~line 595)

The block is added to the **left rail** (between Tools and Education) AND to the **plain-text view** at the bottom of the file (so recruiters and ATS can copy the FlowScope blurb the same way they can copy the existing experience blurbs).

- [ ] **Step 1: Add the Selected Projects block to the styled rail**

Find this existing markup in the rail section (around lines 442-449):

```html
      <section class="block">
        <h3 class="k">Tools</h3>
        <div class="skill-group">
          <p>Figma · ProtoPie · Claude Code · Cursor · VS Code</p>
        </div>
      </section>

      <section class="block">
        <h3 class="k">Education</h3>
```

Use the Edit tool. The `old_string`:

```
      <section class="block">
        <h3 class="k">Tools</h3>
        <div class="skill-group">
          <p>Figma · ProtoPie · Claude Code · Cursor · VS Code</p>
        </div>
      </section>

      <section class="block">
        <h3 class="k">Education</h3>
```

The `new_string`:

```
      <section class="block">
        <h3 class="k">Tools</h3>
        <div class="skill-group">
          <p>Figma · ProtoPie · Claude Code · Cursor · VS Code</p>
        </div>
      </section>

      <section class="block">
        <h3 class="k">Selected Projects</h3>
        <div class="skill-group">
          <h4>FlowScope &mdash; Self-initiated POC</h4>
          <p style="font-family: var(--body); font-size: 11px; line-height: 1.55; color: var(--ink); margin-top: 6px;">The bridge between building in code and presenting like a designer &mdash; assembles vibe-coded prototypes into a system view, surfaces every state across viewports, and hands off to dev with comments lifted back to Claude Code as code references.</p>
          <p style="margin-top: 6px;"><a href="https://adooley1231.github.io/flowscope-poc/" target="_blank" rel="noopener">Live demo</a> &middot; <a href="https://github.com/adooley1231/flowscope-poc" target="_blank" rel="noopener">GitHub</a></p>
        </div>
      </section>

      <section class="block">
        <h3 class="k">Education</h3>
```

- [ ] **Step 2: Add the plain-text mirror in the plain-text view**

Find this existing markup in the plain-text view (around line 592-595):

```html
  <h2>Ideas Collide · Digital Marketing Specialist · Jul 2017 → Jun 2019</h2>
  <pre>• Marketing automation production, segmentation, and SEO implementation for client campaigns.<button class="copy" onclick="copyBlock(this)">Copy</button></pre>

</div>
```

Use the Edit tool. The `old_string`:

```
  <h2>Ideas Collide · Digital Marketing Specialist · Jul 2017 → Jun 2019</h2>
  <pre>• Marketing automation production, segmentation, and SEO implementation for client campaigns.<button class="copy" onclick="copyBlock(this)">Copy</button></pre>

</div>
```

The `new_string`:

```
  <h2>Ideas Collide · Digital Marketing Specialist · Jul 2017 → Jun 2019</h2>
  <pre>• Marketing automation production, segmentation, and SEO implementation for client campaigns.<button class="copy" onclick="copyBlock(this)">Copy</button></pre>

  <h2>Selected Projects</h2>
  <pre>FlowScope — Self-initiated POC
The bridge between building in code and presenting like a designer — assembles vibe-coded prototypes into a system view, surfaces every state across viewports, and hands off to dev with comments lifted back to Claude Code as code references.

Live demo: https://adooley1231.github.io/flowscope-poc/
GitHub: https://github.com/adooley1231/flowscope-poc<button class="copy" onclick="copyBlock(this)">Copy</button></pre>

</div>
```

- [ ] **Step 3: Verify both insertions**

Run:
```bash
grep -n "Selected Projects\|flowscope-poc" /Users/annadooley/Job-Search/resume/anna-dooley-resume.html
```
Expected: at least four matches — two `Selected Projects` (rail h3 + plain-text h2) and two `flowscope-poc` URLs (live demo + GitHub) in each of the two blocks.

---

## Task 8: Verify the résumé in browser and print preview

**Files:** none (verification only)

- [ ] **Step 1: Open the canonical résumé in a browser**

Open `file:///Users/annadooley/Job-Search/resume/anna-dooley-resume.html`.

- [ ] **Step 2: Verify on-screen layout (left rail)**

Expected:
- "Selected Projects" appears between Tools and Education in the left rail
- "// SELECTED PROJECTS" eyebrow renders in mono font with the `//` prefix in orange (matches other `.k` labels)
- "FlowScope — Self-initiated POC" renders as bold title (matches `.skill-group h4` pattern)
- Description paragraph reads cleanly, doesn't overflow the rail width
- "Live demo · GitHub" renders as two distinct links separated by a middle dot

- [ ] **Step 3: Verify the plain-text view**

Click the "Plain text" toolbar toggle (or scroll to the plain-text section). Expected:
- A new "Selected Projects" section appears after Ideas Collide
- The blurb is copy-paste friendly
- The "Copy" button works (clicking copies the FlowScope text minus the trailing "Copy" label)

- [ ] **Step 4: Open print preview and check page breaks**

In the browser, open Print Preview (Cmd+P on macOS). Expected:
- The résumé fits on 2 pages (same as before — the rail is short text)
- Page break between Strategy and Design (existing behavior, sensitive to vertical reflow) is preserved
- The Selected Projects block does NOT split across pages — `page-break-inside: avoid` from `.block` should prevent this; if it splits, add `page-break-inside: avoid` to the new `<section class="block">` explicitly
- Links render as readable text in print (they may show URLs in parentheses depending on browser settings — acceptable)

- [ ] **Step 5: Fix print issues if any**

If the Selected Projects block splits across pages:

Use the Edit tool to add `style="page-break-inside: avoid;"` to the opening tag of the new Selected Projects `<section class="block">` in the rail (around the insertion site from Task 7 Step 1). Re-check print preview.

If the existing K&C Strategy/Design page break has shifted: try slightly reducing the description text length or moving the Selected Projects block above Tools (rather than below) to rebalance the rail height. Document the choice if you make a change.

---

## Task 9: Sync the canonical résumé to the published copy

**Files:**
- Source: `/Users/annadooley/Job-Search/resume/anna-dooley-resume.html`
- Destination: `/Users/annadooley/Portfolio/live-site/resume/index.html`

The two files were identical except for a single comment line. After the edits in Task 7, the canonical now has the Selected Projects block; the published copy doesn't. Sync them, preserving the published file's comment difference (the one-line `<!-- Microsoft Clarity — same project as parent site -->` instead of `<!-- Microsoft Clarity — same project as portfolio -->`).

- [ ] **Step 1: Copy the canonical over the published copy**

Run:
```bash
cp /Users/annadooley/Job-Search/resume/anna-dooley-resume.html /Users/annadooley/Portfolio/live-site/resume/index.html
```

- [ ] **Step 2: Restore the published copy's comment line**

The Clarity comment in the published copy reads `same project as parent site`, while the canonical reads `same project as portfolio`. Restore the parent-site wording.

Use the Edit tool on `/Users/annadooley/Portfolio/live-site/resume/index.html`. The `old_string`:

```
<!-- Microsoft Clarity — same project as portfolio -->
```

The `new_string`:

```
<!-- Microsoft Clarity — same project as parent site -->
```

- [ ] **Step 3: Verify the files now differ only in that comment**

Run:
```bash
diff /Users/annadooley/Job-Search/resume/anna-dooley-resume.html /Users/annadooley/Portfolio/live-site/resume/index.html
```
Expected: a one-line difference matching the Clarity comment swap (exactly the same diff that existed before this work).

- [ ] **Step 4: Verify the published copy still has the Selected Projects block**

Run:
```bash
grep -c "Selected Projects" /Users/annadooley/Portfolio/live-site/resume/index.html
```
Expected: `2` (rail h3 + plain-text h2).

---

## Task 10: Commit and push the résumé changes

**Files:**
- `/Users/annadooley/Portfolio/live-site/resume/index.html` (the only file in this repo that changed; the canonical at `Job-Search/` is not under git)

- [ ] **Step 1: Stage and commit the published résumé**

```bash
cd /Users/annadooley/Portfolio/live-site && \
git add resume/index.html && \
git commit -m "Add FlowScope to résumé Selected Projects block"
```

- [ ] **Step 2: Push portfolio changes to origin**

```bash
cd /Users/annadooley/Portfolio/live-site && \
git push
```

Expected: push succeeds. The portfolio is deployed via GitHub Pages from `https://github.com/adooley1231/adooleyink`; the published résumé lives at `https://annadooleyink.com/resume/`.

- [ ] **Step 3: Verify deployment (wait ~60 seconds for GH Pages)**

Open:
- `https://annadooleyink.com/` — scroll to the AI section, confirm the FlowScope callout renders with the screenshot
- `https://annadooleyink.com/resume/` — confirm "Selected Projects" block is in the left rail

If either is unchanged after 90 seconds, check GH Pages deploy status at `https://github.com/adooley1231/adooleyink/actions`.

---

## Self-Review Checklist

**Spec coverage:**
- §3 positioning ("The bridge between building in code and presenting like a designer") → appears in Task 5 (portfolio closer line) and Task 7 (résumé first sentence). ✓
- §4 two surfaces with asymmetric weight → Tasks 1–6 do the portfolio depth, Tasks 7–10 do the résumé signal. ✓
- §5.1 placement (below grid, above pull quote, inside `.ai` section) → Task 5 inserts exactly there. ✓
- §5.2 tagline, trio, screenshot, closer, links → Task 5 markup includes all five. ✓
- §5.3 visual treatment (paper-on-ink, display font, `--hi` accents, paper-stroke image frame) → Task 3 CSS implements. ✓
- §6.1 placement (between Tools and Education in left rail) → Task 7 inserts exactly there. ✓
- §6.2 résumé copy → Task 7 markup includes the exact compressed sentence. ✓
- §6.3 print/PDF behavior → Task 8 verifies and includes a fix path. ✓
- §7 exclusions → no claims about URL scraping, git sync, dashboard depth, multiplayer, auth, or automated missing-viewport detection appear in any markup. ✓
- §10 open question on live demo URL → resolved in Task 2. ✓
- §11 acceptance criteria → all 5 covered across Tasks 1–10. ✓

**Placeholder scan:** No TBDs, no "implement later", no vague "add appropriate handling", no skipped code blocks. All file paths absolute. All Edit tool old/new strings shown in full. ✓

**Type consistency:** CSS class name `.ai .flowscope` is used consistently in Tasks 3, 4, and 5. The image file is named `flowscope-canvas.png` consistently in Tasks 1 and 5. URLs `https://adooley1231.github.io/flowscope-poc/` and `https://github.com/adooley1231/flowscope-poc` are identical across Tasks 2, 5, and 7. ✓
