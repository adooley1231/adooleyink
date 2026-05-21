# FlowScope on the Portfolio & Résumé — Design Spec

**Date:** 2026-05-21
**Status:** Approved copy, awaiting implementation plan
**Author:** Anna Dooley (with Claude)
**Scope:** Add FlowScope to two surfaces — the portfolio AI section (callout) and the résumé (new Selected Projects block).

---

## 1. Goal

Position FlowScope as evidence that Anna sees and is actively *building* against the workflow gap that AI-augmented design has opened — without overstating maturity.

The artifact should communicate three things on first read:

1. Anna sees workflow problems other designers haven't named yet.
2. Anna can build a solution, not just spec one.
3. Anna is operating ahead of the field on AI-augmented design tooling.

## 2. Non-goals

- **Not a 7th case study (yet).** The other six case studies follow problem → process → outcome. FlowScope has no outcome data (no user interviews, no validation metric). Slotting an unfinished story next to six finished ones drags the average down and creates interview-defense burden for claims that aren't yet true. The long-form case study will live on FlowScope's own site once there's an outcome arc to tell.
- **Not a deep technical post.** This is positioning, not documentation.
- **Not a claim about features that aren't built.** See §7 for the explicit exclusion list.

## 3. Strategic framing

FlowScope's value to a job application isn't the product itself (early POC). It's the *evidence* that Anna is the kind of designer who reads the system, names the gap, and builds toward it.

**The one-sentence positioning** (stolen verbatim from the FlowScope feature plan §6 — the strongest line in the entire doc):

> **The bridge between building in code and presenting like a designer.**

This line closes both surfaces.

## 4. Two surfaces, asymmetric weight

| Surface | Role | Depth |
|---|---|---|
| **Portfolio AI section** | Visual proof of the workflow Anna already practices | Tagline + 3 supporting items + canvas screenshot + live demo link |
| **Résumé** | Recruiter signal: "this person ships" | One bullet under a new Selected Projects header |

The portfolio carries the depth. The résumé carries the signal. FlowScope's own site (future) carries the case study.

## 5. Portfolio AI section — callout design

### 5.1 Placement

A horizontal callout block **below** the existing four-item AI grid (`#ai .grid4`) and **above** the existing pull quote (`#ai .pull`). It sits inside the same `<section class="ai">` so it inherits the inverted dark-on-paper styling that already brands the AI section.

Reasoning: making it a 5th grid item would force it into a 13/3-column row (visually awkward) and would equalize its weight with the four conceptual beats above it. A separate, wider callout below the grid signals "and here's the example."

### 5.2 Content (locked)

**Headline tagline (~3 sentences):**

> *Designers are now building in code. Once you have 8 screens of it, there's no way to see the system. FlowScope is the zoom-out — assemble the flow, surface every state across viewports, present end-to-end, and hand off to dev with comments lifted back to Claude Code as code references.*

**Supporting trio (3 short items):**

1. **Zoom out.** Assemble your vibe-coded prototypes into one system view. Walk the flow end-to-end the way a user would.
2. **See every state.** Error, loading, empty, success — across desktop and mobile, in context of the flow. Spot gaps before dev does.
3. **Comment & hand off.** Comments lift code references — file, component, line — and route back to Claude Code or Cursor to implement. The canvas becomes the handoff artifact.

**Visual:** One full-bleed canvas screenshot of FlowScope showing 6 screens connected by trigger edges, one decision diamond ("Authenticated?"), edge labels, sidebar with FLOWS/CHANGES/NOTES + path filters + tag filters, top bar with Save Version + Desktop/Mobile toggle + Comments chip, bottom hint text, minimap. Dark theme. This image proves ~60% of the copy on its own.

Asset source: `/Users/annadooley/Desktop/Screenshot 2026-05-21 at 9.18.46 AM.png` (to be moved into `assets/` during implementation).

**Closer line (bold, large, paper-on-ink):**

> **The bridge between building in code and presenting like a designer.**

**Links:** `Live demo →` and `GitHub →` as inline text links beneath the closer (or beside it). Both open in a new tab.

### 5.3 Visual treatment notes

- Match the existing AI section's inversion: ink background, paper text, `--hi` (orange) accents on the closer.
- The canvas screenshot should sit inside a thin paper-stroke frame to echo the rest of the site's image framing.
- Keep typography consistent with `.ai .lede` for the headline tagline and `.ai .grid4 .item p` for the supporting items.

## 6. Résumé — Selected Projects block

### 6.1 Placement

A new `<section class="block">` in the left rail (`.rail`), inserted between **Tools** and **Education**. The left rail already contains: Summary → Skills → Tools → Education. Adding it at this position groups it with the "what Anna brings" content rather than the chronological experience column.

### 6.2 Content (locked)

```
SELECTED PROJECTS

FlowScope — Self-initiated POC

The bridge between building in code and presenting like a designer — assembles
vibe-coded prototypes into a system view, surfaces every state across viewports,
and hands off to dev with comments lifted back to Claude Code as code references.

[Live demo]  ·  [GitHub]
```

"Live demo" and "GitHub" are two distinct text links separated by a thin bullet, matching the contact-link pattern already in the résumé header. Both open in a new tab.

### 6.3 Print/PDF behavior

The block must respect the existing print rules: no page breaks inside the bullet (`page-break-inside: avoid`), and links should render as readable text (URLs allowed in print since the résumé is a portable artifact).

## 7. What we are NOT claiming

Auditing against the FlowScope feature plan, the following are present in the spec or roadmap but **must not** appear in the copy on either surface:

| Plan item | Reason for exclusion |
|---|---|
| URL scraping (FUTURE_FEATURES §3) | Future-future; not designed, not built |
| Git repository live sync (FUTURE_FEATURES §3, V2) | Not built |
| Project Dashboard depth | Design spec only, no implementation yet |
| Multiplayer / real-time collaboration | Explicitly out of POC scope |
| Authentication, persistence, backend | Out of POC scope |
| Automated missing-viewport detection (orange "no mobile variant" badge) | Designed in FUTURE_FEATURES §4 but not built. The simplified copy ("surface every state across viewports", "spot gaps before dev does") puts the cognitive detection on the designer using the tool, not on the tool itself — which is true today. |

The screenshot includes three avatar chips (A·J·M) in the top bar. This is acceptable as product chrome — most viewers will read it as comment/version authorship, not multiplayer. If audited, the chips are visual scaffolding for a feature that exists conceptually (multi-author comments + version saves) even though real-time sync is not built.

## 8. What's shipped vs designed (for honest defense in interviews)

**Shipped in the POC (May 2026):**
- Canvas with screen nodes, decision diamonds, trigger edges
- Double-click zoom transition canvas → focused view
- Screen State System (Phase 1) — multiple states per screen
- Notes handoff (Phase 1) — directive change orders that lift code references
- Comments consolidation — spatial comment bubbles on screens
- Responsive viewport toggle — Desktop / Mobile
- Versioning — save / list / restore / preview

**Designed but not yet implemented:**
- Project Dashboard (design spec only)
- Missing-viewport badges (responsive toggle ships, the "no mobile variant" badge is a design extension)
- Annotation Export PDF (designed in FUTURE_FEATURES §2, not built)

The copy is written to be defensible against the shipped list with no charitable-reading required. After simplifying the viewport language to *"surface every state across viewports"* and *"spot gaps before dev does"*, the tool is responsible for surfacing/rendering (which it does today via the screen state system + responsive viewport toggle), and the designer is responsible for spotting gaps. No automated detection is claimed.

## 9. Why this approach is "cleanest"

| Dimension | This approach | Alternative: full case study |
|---|---|---|
| Honesty bar | "Exploratory POC filling a workflow gap" — provable today | Implies process → outcome with no outcome data yet |
| Risk if it stalls | Small callout aging is fine | Stale case study next to six finished ones drags average |
| Interview defense | "Here's a problem I see, here's me building toward it" — clean story | Have to invent outcome claims to match case-study scaffolding |
| Recruiter signal | "Projects" header on résumé = builder, scannable in 1 second | Buried in portfolio only — misses résumé scanners |

## 10. Open questions for implementation phase

- **Closer line treatment:** Should "The bridge between building in code and presenting like a designer" be styled like the existing AI section pull quote, or distinct? Recommend distinct — it's a positioning statement, not a pithy aside.
- **Screenshot interactivity:** Static image for v1. Future upgrade is a short looping video/GIF of the zoom interaction (the magic is in motion). Not blocking ship.
- **Live demo URL:** Confirm the GitHub Pages deploy URL for the FlowScope POC before wiring the link.
- **Résumé PDF re-export:** After the Selected Projects block is added, re-export the résumé PDF and re-test the page-break behavior (the Kin & Carta Strategy/Design split is sensitive to vertical reflow).

## 11. Acceptance criteria

The implementation is complete when:

1. The portfolio AI section renders the callout below the four-item grid, with the canvas screenshot, locked tagline copy, supporting trio, closer line, and live demo + GitHub links.
2. The résumé renders the new Selected Projects block in the left rail between Tools and Education with the locked compressed copy.
3. Both surfaces survive print/PDF export without layout breaks.
4. The screenshot asset is moved from `~/Desktop/` into the portfolio repo's `assets/` directory.
5. Live demo and GitHub URLs are live and open in new tabs.
