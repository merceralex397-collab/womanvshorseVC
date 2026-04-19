# Ticket Board

| Wave | ID | Title | Lane | Stage | Status | Resolution | Verification | Parallel Safe | Overlap Risk | Depends On | Follow-ups |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | SETUP-001 | Create 3D arena scene | scene-setup | closeout | done | done | reverified | no | high | MODEL-006 | - |
| 0 | SETUP-002 | Create player controller | scene-setup | closeout | done | done | reverified | no | high | SETUP-001 | - |
| 1 | MODEL-001 | Generate woman-warrior via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | MODEL-002 | Generate horse-brown via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | MODEL-003 | Generate horse-black via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | MODEL-004 | Generate horse-war via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | MODEL-005 | Generate horse-boss via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | MODEL-006 | Generate arena-ground via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | ANDROID-001 | Android export surface setup | android-export | closeout | done | done | reverified | yes | low | - | - |
| 2 | CORE-001 | Implement 3D attack system | core-gameplay | closeout | done | done | trusted | no | medium | SETUP-002 | - |
| 2 | CORE-002 | Create 3D enemy horse base class | core-gameplay | closeout | done | done | trusted | no | medium | SETUP-001 | - |
| 2 | CORE-003 | Wave spawner (3D positions) | core-gameplay | closeout | done | done | reverified | no | medium | CORE-002 | - |
| 2 | CORE-004 | 3D HUD (CanvasLayer) | ui | closeout | done | done | reverified | yes | low | SETUP-001 | - |
| 2 | CORE-005 | 3D collision and damage system | core-gameplay | closeout | done | done | reverified | no | high | CORE-001, CORE-002 | - |
| 2 | CORE-006 | Enemy variants with model swapping | core-gameplay | closeout | done | done | trusted | no | medium | CORE-002, MODEL-001, MODEL-002, MODEL-003, MODEL-004, MODEL-005 | - |
| 2 | UI-001 | Title screen | ui | closeout | done | done | reverified | yes | low | - | - |
| 2 | UI-002 | Game over screen | ui | closeout | done | done | reverified | yes | low | - | - |
| 3 | RELEASE-001 | Build Android runnable proof (debug APK) | release-readiness | closeout | done | done | reverified | no | medium | FINISH-VALIDATE-001 | - |
| 4 | REMED-001 | Godot headless validation fails | remediation | closeout | done | done | reverified | no | low | - | - |
| 5 | REMED-002 | Android-targeted Godot repo is missing export surfaces or debug APK runnable proof | remediation | closeout | done | done | reverified | no | low | - | - |
| 6 | REMED-003 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | REMED-001, REMED-002 |
| 7 | REMED-004 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 8 | REMED-005 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 9 | REMED-006 | Godot headless validation fails | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 10 | REMED-007 | Android-targeted Godot repo is missing export surfaces or debug APK runnable proof | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 11 | REMED-008 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 12 | VISUAL-001 | Own ship-ready visual finish | finish-visual | closeout | done | done | reverified | no | medium | SETUP-001 | MODEL-007, MODEL-008, FENCE-001 |
| 13 | AUDIO-001 | Own ship-ready audio finish | finish-audio | closeout | done | done | trusted | no | medium | SETUP-001 | - |
| 14 | FINISH-VALIDATE-001 | Validate product finish contract | finish-validation | closeout | done | done | trusted | no | medium | VISUAL-001, AUDIO-001 | - |
| 15 | REMED-009 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | done | reverified | no | low | - | - |
| 16 | REMED-010 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 17 | REMED-011 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 18 | REMED-012 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 19 | REMED-013 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 20 | REMED-014 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 21 | REMED-015 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 22 | REMED-016 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 23 | REMED-017 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 12 | MODEL-007 | Generate sword-projectile via Blender-MCP | model-generation | closeout | done | done | trusted | yes | low | - | REMED-023 |
| 12 | MODEL-008 | Generate heart-pickup via Blender-MCP | model-generation | closeout | done | done | trusted | yes | low | - | - |
| 12 | FENCE-001 | Add arena fence boundary | finish-visual | closeout | done | done | trusted | yes | low | - | - |
| 24 | REMED-018 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | done | trusted | no | low | - | - |
| 25 | REMED-019 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 26 | REMED-020 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 27 | REMED-021 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | REMED-018 |
| 28 | REMED-022 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 29 | REMED-023 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | done | reverified | no | low | - | - |
| 30 | REMED-024 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 31 | REMED-025 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 32 | REMED-026 | Recorded Blender-MCP mutating calls violated the stateless saved-blend chaining contract | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 33 | REMED-027 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 34 | REMED-028 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
