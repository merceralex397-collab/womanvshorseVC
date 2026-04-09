# Ticket Board

| ID | Title | Wave | Lane | Stage | Status | Depends On |
| --- | --- | --- | --- | --- | --- | --- |
| MODEL-001 | Generate woman-warrior via Blender-MCP | 1 | model-generation | planning | todo | - |
| MODEL-002 | Generate horse-brown via Blender-MCP | 1 | model-generation | planning | todo | - |
| MODEL-003 | Generate horse-black via Blender-MCP | 1 | model-generation | planning | todo | - |
| MODEL-004 | Generate horse-war via Blender-MCP | 1 | model-generation | planning | todo | - |
| MODEL-005 | Generate horse-boss via Blender-MCP | 1 | model-generation | planning | todo | - |
| MODEL-006 | Generate arena-ground via Blender-MCP | 1 | model-generation | planning | todo | - |
| SETUP-001 | Create 3D arena scene | 0 | scene-setup | planning | todo | MODEL-006 |
| SETUP-002 | Create player controller | 0 | scene-setup | planning | todo | SETUP-001 |
| CORE-001 | Implement 3D attack system | 2 | core-gameplay | planning | todo | SETUP-002 |
| CORE-002 | Create 3D enemy horse base class | 2 | core-gameplay | planning | todo | SETUP-001 |
| CORE-003 | Wave spawner (3D positions) | 2 | core-gameplay | planning | todo | CORE-002 |
| CORE-004 | 3D HUD (CanvasLayer) | 2 | ui | planning | todo | SETUP-001 |
| CORE-005 | 3D collision and damage system | 2 | core-gameplay | planning | todo | CORE-001, CORE-002 |
| CORE-006 | Enemy variants with model swapping | 2 | core-gameplay | planning | todo | CORE-002, MODEL-* |
| UI-001 | Title screen | 2 | ui | planning | todo | - |
| UI-002 | Game over screen | 2 | ui | planning | todo | - |
| RELEASE-001 | Android export and APK build | 3 | release-readiness | planning | todo | All above |
