# Smoke Test

## Ticket

- REMED-002

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `stat /home/pc/projects/womanvshorseVC/.opencode/state/reviews/remed-002-review-review.md`
- exit_code: 0
- duration_ms: 2
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
  File: /home/pc/projects/womanvshorseVC/.opencode/state/reviews/remed-002-review-review.md
  Size: 4483      	Blocks: 16         IO Block: 4096   regular file
Device: 8,48	Inode: 563993      Links: 1
Access: (0644/-rw-r--r--)  Uid: ( 1000/      pc)   Gid: ( 1000/      pc)
Access: 2026-04-10 12:51:15.513584633 +0100
Modify: 2026-04-10 05:33:16.723864725 +0100
Change: 2026-04-10 12:49:48.217240826 +0100
 Birth: 2026-04-10 05:26:58.502122513 +0100
~~~~

#### stderr

~~~~text
<no output>
~~~~
