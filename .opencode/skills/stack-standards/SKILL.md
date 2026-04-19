---
name: stack-standards
description: Hold the repo-specific engineering, validation, and release-proof standards for Woman vs Horse VC's Godot 4.6 Android stack.
---

# Stack Standards

Before applying these rules, call `skill_ping` with `skill_id: "stack-standards"` and `scope: "project"`.

Current stack: `Godot 4.6 / GDScript / Android / Blender-MCP GLB assets`

## Repo-specific operating rules

- Build and validation work is Godot-first. Do not substitute generic Python or Node tooling for the real project-load and Android export commands.
- Runtime code lives in `scripts/` and scene ownership lives in `scenes/`. Check the live tree before inventing new scene names or script paths.
- Gameplay is a fixed top-down 3D arena on the XZ plane. Keep movement, combat, and spawn logic centered on X/Z and treat Y as gravity / vertical presentation only.
- The Android target is landscape and touch-only. UI work must preserve large touch targets and avoid desktop-only input assumptions.
- Visual assets are low-poly GLB files under `assets/models/`, generated from the seeded asset brief and Blender-MCP route. Do not claim an asset is usable until the GLB imports cleanly in Godot.

## GDScript conventions already present in this repo

- Prefer typed exported properties and typed locals (`@export var speed: float = 5.0`, `var mesh: Mesh = ...`) instead of untyped catch-all values.
- Use `CharacterBody3D`, `NavigationAgent3D`, `Area3D`, and explicit signals for gameplay actors instead of custom ad hoc movement abstractions.
- Keep runtime loading and warnings explicit: use `push_warning` / `push_error` when GLB loading or node lookup fails rather than silently swallowing bad state.
- Follow the current naming pattern: scene-facing nodes may stay PascalCase when they mirror node names (`AttackArea`, `ModelContainer`), while functions stay snake_case.

## Validation and release-proof commands

Run the smallest command set that matches the ticket scope, but use these as the canonical repo checks:

```bash
godot4 --headless --path . --quit
godot4 --headless --path . --export-debug "Android Debug" build/android/womanvshorsevc-debug.apk
ls -lh build/android/womanvshorsevc-debug.apk
unzip -l build/android/womanvshorsevc-debug.apk | rg "AndroidManifest.xml|classes|resources"
```

Use `godot4 --headless --path . --quit` after asset or scene changes to prove the project loads and imports without errors.

Use the Android export plus APK existence and `unzip -l` checks for `ANDROID-001`, `RELEASE-001`, and any ticket that claims release-proof progress.

## Asset and import rules

- Asset work starts from `assets/briefs/<asset-name>.md`, then Blender-MCP generation, then `assets/models/<asset-name>.glb`, then provenance and Godot import proof.
- Keep the Blender-MCP saved-blend chain intact across mutating calls; do not accept `input_blend: null` / `output_blend: null` mutating sequences as valid bridge evidence.
- Do not wire gameplay around placeholder meshes once a ticket claims the model lane is complete; use the real GLB path recorded in the asset brief / provenance surfaces.

## Finish-contract implications

- The finish contract requires a real Android game APK with non-placeholder 3D visuals and audio. Do not describe placeholder art, empty audio lanes, or missing gameplay content as acceptable closeout.
- `RELEASE-001` is not done unless the debug APK export succeeds at `build/android/womanvshorsevc-debug.apk` and the archive contents prove a real Android package.

## Common failure modes to reject

- Declaring Blender or Android tooling broken before rerunning the exact repo-local command with the current managed surfaces.
- Marking a ticket done from prose alone when the ticket acceptance already names a runnable Godot load, export, or asset-import check.
- Inventing new scene layout, combat systems, or input mappings without checking the current repo state and canonical brief first.
