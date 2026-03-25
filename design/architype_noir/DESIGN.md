# Design System: Minimalist Precision & Bold Editorial

## 1. Overview & Creative North Star: "The Architectural Monolith"
This design system is a tribute to structural integrity and the power of negative space. Inspired by the high-end editorial clarity of Hyundai Card, we move away from the "bubble-wrap" UI of the modern web toward a "Monolithic" aesthetic. 

**The Creative North Star: The Architectural Monolith.**
Our interface should feel like a premium printed journal or a slab of polished basalt. We reject the "default" look of the web—round buttons, soft shadows, and cluttered grids—in favor of razor-sharp 0px corners, extreme typographic contrast, and a strict, mathematical use of space. We don't just "show" information; we *curate* it through intentional asymmetry and a hierarchy that feels authoritative and permanent.

---

## 2. Colors: Tonal Depth & The High-Contrast Void
The palette is rooted in absolute blacks and layered off-whites. We use a "High-Contrast Noir" approach where the absence of color creates a premium vacuum for content to live in.

### The "No-Line" Rule
Traditional 1px solid borders are forbidden for sectioning. They clutter the editorial flow. Instead, boundaries must be defined by:
1.  **Background Shifts:** Transitioning from `surface` (#F9F9F9) to `surface_container_low` (#F3F3F3).
2.  **Negative Space:** Using the `20` (7rem) or `24` (8.5rem) spacing tokens to create a "void" between content blocks.

### Surface Hierarchy & Layering
Treat the UI as a series of stacked sheets of high-grade paper.
*   **Base:** `surface` (#F9F9F9) is your canvas.
*   **Secondary Content:** Use `surface_container` (#EEEEEE) for sidebars or secondary modules.
*   **Interactive Elements:** Use `surface_container_lowest` (#FFFFFF) for cards that need to "pop" subtly against the greyish base.

### Signature Textures
To avoid a "flat" feel, use a subtle linear gradient on main CTAs: `primary` (#000000) transitioning to `primary_container` (#3B3B3B) at a 45-degree angle. This adds a "carbon-fiber" depth that feels expensive and intentional.

---

## 3. Typography: The Editorial Voice
Typography is the primary UI element. We use a "Size as Structure" philosophy.

*   **Headlines (Space Grotesk):** These are architectural. Use `display-lg` (3.5rem) with tight letter-spacing (-0.04em) to create a sense of density and power. Space Grotesk’s geometric quirks provide the "signature" look that distinguishes this system from a standard layout.
*   **Body (Pretendard/Inter):** Pretendard is used for its exceptional legibility at small scales. It acts as the "functional" counterweight to the "expressive" headlines.
*   **The Hierarchy of Authority:**
    *   **Display:** For impact and brand moments.
    *   **Headline:** For section starts.
    *   **Label-sm:** Used in All-Caps with 0.1rem letter-spacing for metadata, creating a "technical" or "curated" feel.

---

## 4. Elevation & Depth: Tonal Stacking
We reject the standard "Drop Shadow." Elevation in this system is achieved through **Tonal Layering** and **Atmospheric Blurs.**

*   **The Layering Principle:** Depth is created by stacking surface tiers. A `surface_container_highest` (#E2E2E2) element on a `surface` (#F9F9F9) background creates a tactile lift without a single shadow.
*   **Ambient Shadows:** If an element must float (e.g., a premium modal), use an ultra-diffused shadow: `box-shadow: 0 20px 80px rgba(0, 0, 0, 0.04)`. The shadow must feel like a "whisper," not a dark glow.
*   **The Ghost Border:** For accessibility in input fields, use `outline_variant` at 20% opacity. It should be barely perceptible, serving only as a structural guide.
*   **Glassmorphism:** For top navigation bars, use `surface` at 80% opacity with a `backdrop-filter: blur(20px)`. This allows the "Monolithic" content to scroll underneath, maintaining a sense of layered physical space.

---

## 5. Components: Sharp, Bold, Persistent

### Buttons (0px Roundedness)
*   **Primary:** Solid `primary` (#000000) with `on_primary` (#E2E2E2) text. No rounding. Use `16` (5.5rem) horizontal padding for a "wide-screen" look.
*   **Secondary:** `surface_container_highest` (#E2E2E2) background. Sharp edges.
*   **Tertiary:** Text only, but with a 2px `primary` underline that appears on hover, mimicking an editorial link.

### Cards & Lists
*   **The Divider Rule:** Forbid 1px dividers. Use a 4px vertical gap (`1` spacing token) between list items where the background color of the list item is `surface_container_low`. The "negative space" becomes the divider.
*   **Cards:** No borders. Use `surface_container_lowest` (#FFFFFF) against the `surface` background. Padding must be generous (Spacing `6` or `8`).

### Input Fields
*   **State:** Underline-only style. A 1px `outline` (#777777) bottom border that expands to 2px `primary` on focus. This mimics a signature line on a contract.

### New Component: The "Editorial Masthead"
A large-scale component for page headers using `display-lg` typography, a `surface_dim` background, and a strict 2-column asymmetric grid (left column 33% width for labels, right column 66% for headlines).

---

## 6. Do’s and Don’ts

### Do:
*   **Embrace Asymmetry:** Place a small `label-md` far to the left and a `display-md` headline to the right. The tension creates sophistication.
*   **Use Heavy Weights:** Use `Bold` or `Semi-Bold` for almost all headlines to lean into the "Bold Editorial" concept.
*   **Trust the Grid:** Align every element to a strict 12-column grid. Precision is the soul of this system.

### Don’t:
*   **Don't Round Anything:** 0px is the law. Any radius—even 2px—will break the "Architectural Monolith" feel and make it look generic.
*   **Don't Use Grey for Text:** Use `on_surface` (#1A1C1C) for body. We want high contrast. If something is less important, reduce the font size or use All-Caps, but keep the contrast high.
*   **Don't Use Standard Icons:** Use thin-stroke (1px) geometric icons. Avoid "filled" or "rounded" icon sets.