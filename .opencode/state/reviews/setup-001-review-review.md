# Review: SETUP-001 — Create 3D Arena Scene

## Ticket
- ID: SETUP-001
- Stage: plan_review
- Plan artifact: `.opencode/state/plans/setup-001-planning-plan.md`

## Review Verdict: **APPROVE with advisory notes**

The plan correctly maps all 6 acceptance criteria to verifiable evidence and has no blocking defects. One non-blocking advisory is recorded for implementation awareness.

---

## Acceptance Criteria Review

| AC | Description | Plan Coverage | Status |
|----|-------------|---------------|--------|
| AC-1 | `scenes/arena/arena.tscn` exists with Node3D root | Lines 27, 56: root node `Arena` type `Node3D` | ✅ PASS |
| AC-2 | Camera3D with orthographic projection | Lines 31–36, 60–65: `projection = 1` (ORTHOGONAL) | ✅ PASS |
| AC-3 | DirectionalLight3D for sun lighting | Lines 38–41, 67–69: type `DirectionalLight3D`, `light_energy = 1.4` | ✅ PASS |
| AC-4 | arena-ground.glb instanced as child | Lines 54, 71 (or 83, 100–101 fallback): GLB resource + child node | ✅ PASS |
| AC-5 | Empty EnemyContainer Node3D for spawner | Lines 29, 58: `Node3D` named `EnemyContainer` | ✅ PASS |
| AC-6 | Scene loads without errors | Lines 110–116: `godot --headless --path . --quit` validation | ✅ PASS |

---

## Findings

### Finding 1: Camera3D needs explicit transform (advisory, non-blocking)

**Location**: Plan lines 31–36 / 60–65, node structure lines 123–126

**Issue**: The plan's Camera3D node declaration has no `transform =` property. Godot's Camera3D defaults to position `(0, 0, 0)` with no intrinsic look-direction — it must be explicitly positioned and aimed.

The plan text (lines 144–152) acknowledges this and proposes a transform, but that transform is **not included in the actual scene structure** presented in Steps 1/Revised Step 1. Without it, the camera sits at the world origin looking in -Z, which is not a top-down view of the arena.

The existing `scenes/main.tscn` confirms the correct pattern:
```
transform = Transform3D(1, 0, 0, 0, 0.422618, 0.906308, 0, -0.906308, 0.422618, 0, 7.5, 7.5)
projection = 1
size = 8.0
current = true
```

For a true top-down view (per spec: "Fixed top-down orthographic camera"), the camera should be positioned at `(0, elevation, 0)` looking at `(0, 0, 0)`. The plan should include an explicit camera transform — either the near-top-down angle from main.tscn or a straight overhead position.

**Verdict**: Non-blocking advisory. The plan correctly identifies the issue in the text (lines 144–152) and provides the correct fix. Implementation must include the camera transform. Reviewer confirms the implementer can resolve this at implementation time without a plan revision.

### Finding 2: arena-ground.glb.import does not exist yet (advisory, non-blocking)

**Location**: Plan lines 54, 71 (or 83, 100–101 fallback)

**Evidence**: `assets/models/arena-ground.glb` exists (36,108 bytes from MODEL-006), but `assets/models/arena-ground.glb.import` does not exist in the project. Other GLB files (woman-warrior.glb, horse-brown.glb) have .import files.

**Assessment**: This is expected — Godot creates .import files when it actually processes a resource during a project load. Since no scene yet references arena-ground.glb, the .import hasn't been generated. The plan correctly handles this with both PackedScene (primary) and MeshInstance3D (fallback) approaches based on what Godot actually produces when the scene is first loaded.

The model geometry (25 objects: 1 ground plane + 16 fence posts + 8 rails) means the GLB is multi-object, which typically produces separate mesh resources rather than a single PackedScene — the MeshInstance3D fallback is likely what will be needed.

**Verdict**: Non-blocking. Plan correctly anticipates both import forms.

---

## Strengths

1. **Dual-path GLB handling**: Primary PackedScene approach with MeshInstance3D fallback correctly anticipates how Godot imports multi-object GLBs.
2. **All 6 ACs mapped**: Each acceptance criterion is connected to a specific verification method with verifiable evidence.
3. **Risk register**: Medium risk (missing resource import) is identified with explicit mitigation.
4. **Dependency confirmed**: MODEL-006 is done and trusted; bootstrap is ready.
5. **Scene structure is Godot 4.6 format=3 compliant**: `[gd_scene load_steps=N format=3]` and `[ext_resource]` syntax matches Godot 4 scene format.

---

## Required Revisions

None. The plan is approved as-is. The Camera3D transform gap is an implementation-time resolution, not a plan defect, because the plan text (lines 144–152) already provides the correct camera transform. Implementation must copy the camera transform into the actual `.tscn` node declaration.

---

## Summary

- **Decision**: APPROVE
- **Blocking issues**: 0
- **Advisory notes**: 2 (Camera3D transform needs inclusion in node declaration; arena-ground.glb.import will be generated on first load)
- **Next stage**: Implementation, following the plan's Steps 1 Revised through 3
