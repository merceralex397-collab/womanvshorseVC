# Ticket Board

| Wave | ID | Title | Lane | Stage | Status | Resolution | Verification | Parallel Safe | Overlap Risk | Depends On | Follow-ups |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0 | SETUP-001 | Create 3D arena scene | scene-setup | planning | todo | open | suspect | no | high | MODEL-006 | - |
| 0 | SETUP-002 | Create player controller | scene-setup | planning | todo | open | suspect | no | high | SETUP-001 | - |
| 1 | MODEL-001 | Generate woman-warrior via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | MODEL-002 | Generate horse-brown via Blender-MCP | model-generation | closeout | done | done | reverified | yes | low | - | - |
| 1 | MODEL-003 | Generate horse-black via Blender-MCP | model-generation | review | review | open | suspect | yes | low | - | - |
| 1 | MODEL-004 | Generate horse-war via Blender-MCP | model-generation | review | review | open | suspect | yes | low | - | - |
| 1 | MODEL-005 | Generate horse-boss via Blender-MCP | model-generation | planning | todo | open | suspect | yes | low | - | - |
| 1 | MODEL-006 | Generate arena-ground via Blender-MCP | model-generation | planning | todo | open | suspect | yes | low | - | - |
| 1 | ANDROID-001 | Android export surface setup | android-export | plan_review | plan_review | open | suspect | yes | low | - | RELEASE-001 |
| 2 | CORE-001 | Implement 3D attack system | core-gameplay | planning | todo | open | suspect | no | medium | SETUP-002 | - |
| 2 | CORE-002 | Create 3D enemy horse base class | core-gameplay | planning | todo | open | suspect | no | medium | SETUP-001 | - |
| 2 | CORE-003 | Wave spawner (3D positions) | core-gameplay | planning | todo | open | suspect | no | medium | CORE-002 | - |
| 2 | CORE-004 | 3D HUD (CanvasLayer) | ui | planning | todo | open | suspect | yes | low | SETUP-001 | - |
| 2 | CORE-005 | 3D collision and damage system | core-gameplay | planning | todo | open | suspect | no | high | CORE-001, CORE-002 | - |
| 2 | CORE-006 | Enemy variants with model swapping | core-gameplay | planning | todo | open | suspect | no | medium | CORE-002, MODEL-001, MODEL-002, MODEL-003, MODEL-004, MODEL-005 | - |
| 2 | UI-001 | Title screen | ui | planning | todo | open | suspect | yes | low | - | - |
| 2 | UI-002 | Game over screen | ui | planning | todo | open | suspect | yes | low | - | - |
| 3 | RELEASE-001 | Build Android runnable proof (debug APK) | release-readiness | planning | todo | open | suspect | no | medium | CORE-001, CORE-002, CORE-003, CORE-004, CORE-005, CORE-006, UI-001, UI-002 | - |
| 4 | REMED-001 | Godot headless validation fails | remediation | closeout | done | done | reverified | no | low | - | - |
| 5 | REMED-002 | Android-targeted Godot repo is missing export surfaces or debug APK runnable proof | remediation | closeout | done | done | reverified | no | low | - | - |
| 6 | REMED-003 | Remediation review artifact does not contain runnable command evidence | remediation | review | review | open | suspect | no | low | - | REMED-001, REMED-002, REMED-004, REMED-006, REMED-007, REMED-008 |
| 7 | REMED-004 | Remediation review artifact does not contain runnable command evidence | remediation | planning | todo | open | suspect | no | low | - | - |
| 8 | REMED-005 | Remediation review artifact does not contain runnable command evidence | remediation | closeout | done | superseded | reverified | no | low | - | - |
| 9 | REMED-006 | Godot headless validation fails | remediation | planning | todo | open | suspect | no | low | - | - |
| 10 | REMED-007 | Android-targeted Godot repo is missing export surfaces or debug APK runnable proof | remediation | planning | todo | open | suspect | no | low | - | - |
| 11 | REMED-008 | Remediation review artifact does not contain runnable command evidence | remediation | planning | todo | open | suspect | no | low | - | - |
