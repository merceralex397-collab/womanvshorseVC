# Initial Codebase Review

## Scope

- subject repo: /home/rowan/womanvshorseVC
- diagnosis timestamp: 2026-04-15T03:17:48Z
- audit scope: managed workflow, restart, ticket, prompt, and execution surfaces
- verification scope: current repo state only

## Result State

- result_state: validated failures found
- finding_count: 8
- errors: 7
- warnings: 1

## Validated Findings

### Workflow Findings

### FINISH003

- finding_id: FINISH003
- summary: Consumer-facing repo records a Product Finish Contract but is missing the finish-validation workflow lane that proves it.
- severity: error
- evidence_grade: repo-state validation
- affected_files_or_surfaces: docs/spec/CANONICAL-BRIEF.md, tickets/manifest.json
- observed_or_reproduced: The canonical brief declares finish acceptance signals, but the ticket graph does not guarantee a dedicated finish-validation owner or release dependency. Older repos can then close release work without any first-class lane that proves the recorded finish bar.
- evidence:
  - tickets/manifest.json has no FINISH-VALIDATE-001 even though the canonical brief records finish_acceptance_signals.
- remaining_verification_gap: None recorded beyond the validated finding scope.

### WFLOW026

- finding_id: WFLOW026
- summary: Current artifacts contain explicit verdict headings or labels, but the generated verdict extractor still reports them as unclear.
- severity: error
- evidence_grade: repo-state validation
- affected_files_or_surfaces: .opencode/lib/workflow.ts, tickets/manifest.json, .opencode/state/artifacts/history/model-002/qa/2026-04-10T03-48-29-990Z-qa.md, .opencode/state/artifacts/history/model-002/review/2026-04-10T11-55-03-194Z-backlog-verification.md
- observed_or_reproduced: The repo-local workflow parser does not cover the real artifact verdict forms already present in downstream review and QA artifacts, including markdown-emphasized labels, compact stage headings such as `## QA PASS`, and plain `**Overall**: PASS` labels. Those explicit verdicts then look unparseable and block review or QA transitions even though the artifact body is clear.
- evidence:
  - .opencode/state/artifacts/history/model-002/qa/2026-04-10T03-48-29-990Z-qa.md contains `- **Result**: PASS`, but .opencode/lib/workflow.ts still lacks parser coverage for that explicit verdict form.
  - .opencode/state/artifacts/history/model-002/review/2026-04-10T11-55-03-194Z-backlog-verification.md contains `- **Result**: PASS`, but .opencode/lib/workflow.ts still lacks parser coverage for that explicit verdict form.
- remaining_verification_gap: None recorded beyond the validated finding scope.

### CONFIG010

- finding_id: CONFIG010
- summary: A managed game repo is missing canonical asset-pipeline starter surfaces.
- severity: warning
- evidence_grade: repo-state validation
- affected_files_or_surfaces: assets/sprites, assets/audio, assets/fonts, assets/themes, assets/previews, assets/workfiles, assets/licenses, assets/import-reports, assets/pipeline.json, assets/briefs/README.md, .opencode/meta/asset-pipeline-bootstrap.json
- observed_or_reproduced: Legacy scaffold or repair runs did not propagate the deterministic asset route metadata and starter layout into the repo.
- evidence:
  - Missing asset starter surfaces: assets/sprites, assets/audio, assets/fonts, assets/themes, assets/previews, assets/workfiles, assets/licenses, assets/import-reports, assets/pipeline.json, assets/briefs/README.md, .opencode/meta/asset-pipeline-bootstrap.json
  - Invalid asset starter surfaces: assets/pipeline.json, .opencode/meta/asset-pipeline-bootstrap.json, assets/PROVENANCE.md
- remaining_verification_gap: None recorded beyond the validated finding scope.

## Code Quality Findings

### EXEC-GODOT-004

- finding_id: EXEC-GODOT-004
- summary: Godot headless validation fails.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: project.godot
- observed_or_reproduced: The project cannot complete a deterministic headless Godot load pass on the current host, indicating broken project configuration or scripts.
- evidence:
  - Error: Can't run project: no main scene defined in the project.
  - Error: Can't open display:

### EXEC-GODOT-005a

- finding_id: EXEC-GODOT-005a
- summary: Android-targeted Godot repo is missing export surfaces or debug APK runnable proof.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: project.godot, export_presets.cfg, android
- observed_or_reproduced: The repo has started or closed Android release work but is still missing the repo-managed export preset, android/ support surfaces, or the canonical debug APK. Runnable proof requires export_presets.cfg, non-placeholder android/ surfaces, and a debug APK at the canonical build path.
- evidence:
  - open_ticket_count = 21
  - release_lane_started_or_done = True
  - repo_claims_completion = False
  - missing runnable surfaces: debug APK runnable proof at build/android/womanvshorsevc-debug.apk

### EXEC-REMED-001

- finding_id: EXEC-REMED-001
- summary: Remediation review artifact does not contain runnable command evidence.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: tickets/manifest.json, .opencode/state/reviews/remed-001-review-reverification.md
- observed_or_reproduced: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- evidence:
  - ticket REMED-001 carries finding_source `EXEC-GODOT-004`
  - review artifact: .opencode/state/reviews/remed-001-review-reverification.md
  - missing exact command record
  - missing raw command output evidence

### EXEC-REMED-001

- finding_id: EXEC-REMED-001
- summary: Remediation review artifact does not contain runnable command evidence.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: tickets/manifest.json, .opencode/state/reviews/remed-002-review-reverification.md
- observed_or_reproduced: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- evidence:
  - ticket REMED-002 carries finding_source `EXEC-GODOT-005a`
  - review artifact: .opencode/state/reviews/remed-002-review-reverification.md
  - missing exact command record
  - missing raw command output evidence

### EXEC-REMED-001

- finding_id: EXEC-REMED-001
- summary: Remediation review artifact does not contain runnable command evidence.
- severity: CRITICAL
- evidence_grade: repo-state validation
- affected_files_or_surfaces: tickets/manifest.json, .opencode/state/reviews/remed-003-review-review.md
- observed_or_reproduced: A ticket created from a validated finding is being reviewed on prose alone, so the audit cannot confirm that the original failing command or canonical acceptance command was actually rerun after the fix.
- evidence:
  - ticket REMED-003 carries finding_source `EXEC-REMED-001`
  - review artifact: .opencode/state/reviews/remed-003-review-review.md
  - missing exact command record
  - missing raw command output evidence
  - missing explicit post-fix PASS/FAIL result

## Verification Gaps

- The diagnosis pack validates the concrete failures above. It does not claim broader runtime-path coverage than the current audit and supporting evidence actually exercised.

