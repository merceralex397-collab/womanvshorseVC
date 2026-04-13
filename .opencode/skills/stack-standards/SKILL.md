---
name: stack-standards
description: Apply Woman vs Horse VC's Godot 4.6 Android, low-poly asset, and release-proof engineering standards.
---

# Stack Standards

Before applying these rules, call `skill_ping` with `skill_id: "stack-standards"` and `scope: "project"`.

This repository is a Godot 4.6 Android project for a low-poly 3D arena action game. The product target is an Android APK with Blender-MCP generated GLB assets, touch controls, a fixed top-down orthographic camera, and no placeholder final models.

## Project Stack

- Engine: Godot 4.6, Forward+ rendering, Android landscape output.
- Main config: `project.godot`.
- Android export config: `export_presets.cfg`.
- Canonical debug APK path: `build/android/womanvshorseVC-debug.apk`.
- Asset source: Blender 4.5.0 at `/home/pc/blender-4.5.0/blender` via blender-agent MCP.
- Model format: GLB files under `assets/models/`.
- Asset provenance: `assets/PROVENANCE.md`.

## Godot Rules

- Keep gameplay code and scenes compatible with Godot 4.6.
- Use fixed top-down orthographic camera assumptions unless the canonical brief changes.
- Keep controls touch-first: virtual joystick movement plus attack buttons. Do not add keyboard-only acceptance for Android-facing tickets.
- Treat `project.godot`, `.tscn`, `.tres`, `.gd`, `export_presets.cfg`, and Android export surfaces as first-class review targets.
- Do not add save systems, online features, IAP, narrative systems, or high-poly realism without a pivot decision in canonical truth.

## Low-Poly Asset Rules

- Required models are `woman-warrior`, `horse-brown`, `horse-black`, `horse-war`, `horse-boss`, `arena-ground`, `sword-projectile`, and `heart-pickup`.
- Use Blender-MCP generated GLB assets for final product content. Placeholder models are not acceptable for finish closure.
- Keep model budgets within the canonical brief: 2000-5000 triangles for character and horse models, about 500 triangles for arena ground, and about 100-200 triangles for small props.
- Keep textures at 512x512 or smaller unless the canonical brief is updated.
- Every committed final model must be listed in `assets/PROVENANCE.md` with source, license, author, and acquisition date.
- GLB assets must load in Godot without import errors before a ticket can claim visual finish.

## Validation Commands

Use the smallest command set that proves the touched surface. Record exact command output in stage artifacts.

- Project load check: `godot --headless --path . --quit`
- Android debug export: `godot --headless --path . --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk`
- APK existence check: `test -f build/android/womanvshorseVC-debug.apk`
- APK content check: `unzip -l build/android/womanvshorseVC-debug.apk`
- Asset provenance check: inspect `assets/PROVENANCE.md` for each changed file under `assets/models/`.

If the local Godot binary is unavailable, Android export templates are missing, Java/Android tooling is absent, or the debug keystore is missing, report a host prerequisite blocker. Do not turn an unrun command into PASS evidence.

## Review And QA Gates

- Review must inspect the exact Godot, asset, ticket, or workflow files changed by the ticket.
- QA must run the ticket's canonical validation command when host prerequisites are present.
- Remediation tickets with `finding_source` must rerun the original finding-producing check or the exact acceptance command named by the finding.
- `smoke_test` is the only legal producer of smoke-test PASS artifacts.
- If `godot --headless --path . --quit` fails, the repo remains blocked on Godot project-load repair or an explicit host prerequisite blocker.
- If the Android export command fails, `RELEASE-001` cannot close.

## Release Proof

`RELEASE-001` is not complete until:

- `export_presets.cfg` contains an Android preset for this project.
- `android/` support surfaces exist and are non-placeholder.
- `godot --headless --path . --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk` succeeds or records an explicit environment blocker.
- `build/android/womanvshorseVC-debug.apk` exists.
- `unzip -l build/android/womanvshorseVC-debug.apk` shows Android manifest plus compiled classes or resources content.
- All terminal product tickets required for playable waves, controls, assets, and finish have current trusted proof.

## Coding Standards

- Prefer clear Godot scene and script boundaries over large all-purpose scripts.
- Keep runtime behavior deterministic enough for headless project-load checks.
- Validate external file paths and generated asset imports at the boundary.
- Remove dead placeholder content once real Blender-MCP assets exist.
- Add dependencies only when Godot 4.6 or Android export work cannot reasonably proceed without them.
- Keep ticket artifacts current through `artifact_write` and `artifact_register`; do not update queue state with raw file edits.
