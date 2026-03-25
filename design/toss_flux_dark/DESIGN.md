```markdown
# Design System Specification: Intuitive Depth & Modern Connectivity

## 1. Overview & Creative North Star: "The Ethereal Interface"
This design system moves away from the rigid, boxed-in layouts of traditional fintech. Our Creative North Star is **"The Ethereal Interface"**—a digital environment that feels less like a website and more like a fluid, physical space. 

By leveraging the "Toss" philosophy of radical simplicity, we replace heavy structural lines with **Tonal Layering** and **Intentional Asymmetry**. We break the "template" look by using exaggerated typography scales and overlapping elements that suggest a sense of kinetic energy and technological advancement. Every interaction should feel like it’s floating in a deep, cosmic vacuum, guided by soft light and intuitive depth.

---

## 2. Color & Materiality
The palette is rooted in a deep, midnight obsidian, punctuated by high-energy indigo accents.

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1px solid borders for sectioning or containment. 
Structure must be defined purely through:
- **Background Color Shifts:** Moving from `surface` to `surface_container_low`.
- **Vertical Rhythm:** Using the spacing scale to imply boundaries.
- **Negative Space:** Allowing the `background` (#060e20) to act as the primary separator.

### Surface Hierarchy & Nesting
Treat the UI as a series of stacked, semi-translucent sheets. 
- **Base Layer:** `surface` (#060e20)
- **Secondary Content Blocks:** `surface_container_low` (#091328)
- **Interactive High-Priority Cards:** `surface_container` (#0f1930)
- **Floating Modals/Popovers:** `surface_bright` (#1f2b49)

### The "Glass & Gradient" Rule
To achieve a premium, custom feel, use **Glassmorphism** for floating navigation bars and action sheets.
- **Recipe:** Background `surface_variant` at 60% opacity + `backdrop-blur` (20px-40px).
- **Signature Textures:** Use a subtle linear gradient for `primary` CTAs, transitioning from `primary_fixed` (#6aa0ff) to `primary` (#83aeff) at a 135-degree angle. This adds a "glow" that flat hex codes cannot replicate.

---

## 3. Typography: The Editorial Voice
We utilize **Plus Jakarta Sans** (as a high-end alternative to Pretendard) for its modern, rounded terminals that balance friendliness with professional authority.

- **Display Scale (`display-lg` to `display-sm`):** Use these for hero numbers and "Toss-style" big-statement headers. Reduce letter-spacing by -2% for a tighter, editorial feel.
- **Headline & Title Scale:** These act as the "anchors." Always pair a `headline-md` with `body-md` at `on_surface_variant` (lower opacity) to create an immediate visual hierarchy.
- **The Label Logic:** `label-md` and `label-sm` are strictly for functional metadata. Use `on_surface_variant` to ensure they don't compete with primary information.

**Hierarchy Principle:** If everything is white, nothing is important. Use `on_surface` (#dee5ff) for primary headings and `on_surface_variant` (#a3aac4) for secondary body text.

---

## 4. Elevation & Depth
Depth in this system is a result of light behavior, not artificial strokes.

- **The Layering Principle:** Instead of shadows, stack `surface_container_lowest` cards on top of a `surface_container_high` background. This creates a "natural lift" through value contrast alone.
- **Ambient Shadows:** When an element must float (e.g., a FAB or a floating Notification), use an exaggerated blur:
    - **Blur:** 48px to 64px.
    - **Opacity:** 4% - 8%.
    - **Color:** Use `primary` (#83aeff) tinted with black, rather than pure grey, to maintain the dark-mode vibrance.
- **The "Ghost Border" Fallback:** If accessibility requires a container boundary, use `outline_variant` (#40485d) at **15% opacity**. It should be felt, not seen.

---

## 5. Components & Primitive Styling

### Buttons (The "Touch-First" Philosophy)
- **Primary:** Gradient-filled (`primary_fixed` to `primary`), `rounded-lg` (2rem), and high internal horizontal padding (`spacing-8`).
- **Secondary:** Use `secondary_container`. No border.
- **Tertiary:** Purely typographic using `primary` color, no background container.

### Cards & Lists (The "Anti-Divider" Rule)
- **Forbid Divider Lines.** To separate list items, use a `1.5rem` (`md`) vertical gap or place items inside individual `surface_container_low` rounded pods.
- **Rounding:** All cards must use `rounded-DEFAULT` (1rem) or `rounded-md` (1.5rem) to maintain the "Soft Sans" brand feel.

### Input Fields
- **State Styling:** Inactive inputs use `surface_container_highest` with no border. 
- **Focus State:** Transition the background to `surface_bright` and add a "Ghost Border" of `primary` at 30% opacity. 

### Signature Component: The "Fluid Progress"
For onboarding or financial tracking, use wide, high-radius bars (9999px) with `primary_container` as the track and a glowing `primary` gradient as the indicator.

---

## 6. Do’s and Don’ts

### Do
- **Do** use `rounded-full` (9999px) for buttons and chips to emphasize the "Intuitive" concept.
- **Do** use `spacing-16` or `spacing-20` for section margins. Breathing room is a luxury signal.
- **Do** use varying text opacities (87% for primary, 60% for secondary, 38% for disabled) to create depth without changing colors.

### Don't
- **Don't** use pure #000000 black except for `surface_container_lowest` in deep-nested states.
- **Don't** use 1px borders to separate content. Use the spacing scale.
- **Don't** use standard "Drop Shadows" with high opacity. They break the ethereal, glass-like nature of the system.
- **Don't** crowd the layout. If a screen feels full, increase the container rounding and add `spacing-10` of padding.```