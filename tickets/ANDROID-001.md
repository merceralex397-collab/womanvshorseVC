# ANDROID-001: Android export surface setup

## Summary

Configure and validate the Android export surfaces for this Godot project. Verify export_presets.cfg has correct package name, debug keystore path, and export path. Ensure the android/ support directory exists. Confirm the canonical debug export command can be invoked (even if models are not yet present).

## Wave

1

## Lane

android-export

## Parallel Safety

- parallel_safe: true
- overlap_risk: low

## Stage

planning

## Status

todo

## Depends On

- None

## Decision Blockers

- None

## Acceptance Criteria

- [ ] `export_presets.cfg` at repo root with Android Debug preset
- [ ] `package/unique_name` = `com.wvh.vc`
- [ ] `package/name` = `womanvshorseVC`
- [ ] Debug keystore path: `/home/pc/.local/share/godot/keystores/debug.keystore`
- [ ] Debug keystore user: `androiddebugkey`, password: `android`
- [ ] Export path: `build/android/womanvshorseVC-debug.apk`
- [ ] `android/` support directory exists
- [ ] `godot --headless --export-debug "Android Debug" build/android/womanvshorseVC-debug.apk` is the canonical export command (may fail if models missing, but command is correct)

## Artifacts

- None yet

## Notes

- Debug keystore at `/home/pc/.local/share/godot/keystores/debug.keystore`
- RELEASE-001 depends on this ticket for export surfaces
- Can run in parallel with MODEL tickets since it only touches export config
