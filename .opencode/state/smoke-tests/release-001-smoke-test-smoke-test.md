# Smoke Test

## Ticket

- RELEASE-001

## Overall Result

Overall Result: PASS

## Notes

All detected deterministic smoke-test commands passed.

## Commands

### 1. command override 1

- reason: Explicit smoke-test command override supplied by the caller.
- command: `godot4 --headless --path . --quit`
- exit_code: 0
- duration_ms: 161
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
Godot Engine v4.6.1.stable.official.14d19694e - https://godotengine.org
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 2. command override 2

- reason: Explicit smoke-test command override supplied by the caller.
- command: `ls -la build/android/womanvshorsevc-debug.apk`
- exit_code: 0
- duration_ms: 1
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
-rw-rw-r-- 1 rowan rowan 29867630 Apr 17 16:01 build/android/womanvshorsevc-debug.apk
~~~~

#### stderr

~~~~text
<no output>
~~~~

### 3. command override 3

- reason: Explicit smoke-test command override supplied by the caller.
- command: `unzip -l build/android/womanvshorsevc-debug.apk`
- exit_code: 0
- duration_ms: 5
- missing_executable: none
- failure_classification: none
- blocked_by_permissions: false

#### stdout

~~~~text
Archive:  build/android/womanvshorsevc-debug.apk
  Length      Date    Time    Name
---------  ---------- -----   ----
  5642620  2026-04-17 16:01   classes.dex
   340044  2026-04-17 16:01   classes2.dex
    40828  2026-04-17 16:01   classes3.dex
      828  2026-04-17 16:01   classes4.dex
  6933952  2026-04-17 16:01   lib/arm64-v8a/libc++_shared.so
 65494072  2026-04-17 16:01   lib/arm64-v8a/libgodot_android.so
     1738  2026-04-17 16:01   DebugProbesKt.bin
      928  2026-04-17 16:01   kotlin/annotation/annotation.kotlin_builtins
     3685  2026-04-17 16:01   kotlin/collections/collections.kotlin_builtins
      200  2026-04-17 16:01   kotlin/coroutines/coroutines.kotlin_builtins
      646  2026-04-17 16:01   kotlin/internal/internal.kotlin_builtins
    18640  2026-04-17 16:01   kotlin/kotlin.kotlin_builtins
     3399  2026-04-17 16:01   kotlin/ranges/ranges.kotlin_builtins
     2426  2026-04-17 16:01   kotlin/reflect/reflect.kotlin_builtins
     7908  2026-04-17 16:01   AndroidManifest.xml
      364  2026-04-17 16:01   res/anim-v21/fragment_fast_out_extra_slow_in.xml
     1128  2026-04-17 16:01   res/animator/fragment_close_enter.xml
     1128  2026-04-17 16:01   res/animator/fragment_close_exit.xml
      452  2026-04-17 16:01   res/animator/fragment_fade_enter.xml
      452  2026-04-17 16:01   res/animator/fragment_fade_exit.xml
     1128  2026-04-17 16:01   res/animator/fragment_open_enter.xml
     1128  2026-04-17 16:01   res/animator/fragment_open_exit.xml
      212  2026-04-17 16:01   res/drawable-hdpi-v4/notification_bg_low_normal.9.png
      225  2026-04-17 16:01   res/drawable-hdpi-v4/notification_bg_low_pressed.9.png
      212  2026-04-17 16:01   res/drawable-hdpi-v4/notification_bg_normal.9.png
      225  2026-04-17 16:01   res/drawable-hdpi-v4/notification_bg_normal_pressed.9.png
      107  2026-04-17 16:01   res/drawable-hdpi-v4/notify_panel_notification_icon_bg.png
      215  2026-04-17 16:01   res/drawable-mdpi-v4/notification_bg_low_normal.9.png
      223  2026-04-17 16:01   res/drawable-mdpi-v4/notification_bg_low_pressed.9.png
      215  2026-04-17 16:01   res/drawable-mdpi-v4/notification_bg_normal.9.png
      223  2026-04-17 16:01   res/drawable-mdpi-v4/notification_bg_normal_pressed.9.png
       98  2026-04-17 16:01   res/drawable-mdpi-v4/notify_panel_notification_icon_bg.png
     1180  2026-04-17 16:01   res/drawable-v21/notification_action_background.xml
     1216  2026-04-17 16:01   res/drawable-v23/compat_splash_screen.xml
     1076  2026-04-17 16:01   res/drawable-v23/compat_splash_screen_no_icon_background.xml
      221  2026-04-17 16:01   res/drawable-xhdpi-v4/notification_bg_low_normal.9.png
      252  2026-04-17 16:01   res/drawable-xhdpi-v4/notification_bg_low_pressed.9.png
      221  2026-04-17 16:01   res/drawable-xhdpi-v4/notification_bg_normal.9.png
      247  2026-04-17 16:01   res/drawable-xhdpi-v4/notification_bg_normal_pressed.9.png
      138  2026-04-17 16:01   res/drawable-xhdpi-v4/notify_panel_notification_icon_bg.png
      264  2026-04-17 16:01   res/drawable/compat_splash_screen.xml
      264  2026-04-17 16:01   res/drawable/compat_splash_screen_no_icon_background.xml
      372  2026-04-17 16:01   res/drawable/icon_background.xml
      532  2026-04-17 16:01   res/drawable/notification_bg.xml
      532  2026-04-17 16:01   res/drawable/notification_bg_low.xml
      372  2026-04-17 16:01   res/drawable/notification_icon_background.xml
      304  2026-04-17 16:01   res/drawable/notification_tile_bg.xml
     1052  2026-04-17 16:01   res/layout-v21/notification_action.xml
     1228  2026-04-17 16:01   res/layout-v21/notification_action_tombstone.xml
     2456  2026-04-17 16:01   res/layout-v21/notification_template_custom_big.xml
      988  2026-04-17 16:01   res/layout-v21/notification_template_icon_group.xml
      612  2026-04-17 16:01   res/layout/custom_dialog.xml
     4276  2026-04-17 16:01   res/layout/downloading_expansion.xml
      356  2026-04-17 16:01   res/layout/godot_app_layout.xml
      440  2026-04-17 16:01   res/layout/notification_template_part_chronometer.xml
      440  2026-04-17 16:01   res/layout/notification_template_part_time.xml
      616  2026-04-17 16:01   res/layout/splash_screen_view.xml
     2612  2026-04-17 16:01   res/layout/status_bar_ongoing_event_progress_bar.xml
      448  2026-04-17 16:01   res/mipmap-anydpi-v26/icon.xml
     3762  2026-04-17 16:01   res/mipmap-hdpi-v4/icon.png
      375  2026-04-17 16:01   res/mipmap-hdpi-v4/icon_background.png
     2998  2026-04-17 16:01   res/mipmap-hdpi-v4/icon_foreground.png
     2672  2026-04-17 16:01   res/mipmap-mdpi-v4/icon.png
      240  2026-04-17 16:01   res/mipmap-mdpi-v4/icon_background.png
     1909  2026-04-17 16:01   res/mipmap-mdpi-v4/icon_foreground.png
     5186  2026-04-17 16:01   res/mipmap-xhdpi-v4/icon.png
      517  2026-04-17 16:01   res/mipmap-xhdpi-v4/icon_background.png
     4490  2026-04-17 16:01   res/mipmap-xhdpi-v4/icon_foreground.png
     8154  2026-04-17 16:01   res/mipmap-xxhdpi-v4/icon.png
      905  2026-04-17 16:01   res/mipmap-xxhdpi-v4/icon_background.png
     7415  2026-04-17 16:01   res/mipmap-xxhdpi-v4/icon_foreground.png
    11749  2026-04-17 16:01   res/mipmap-xxxhdpi-v4/icon.png
     1360  2026-04-17 16:01   res/mipmap-xxxhdpi-v4/icon_background.png
    11325  2026-04-17 16:01   res/mipmap-xxxhdpi-v4/icon_foreground.png
    11749  2026-04-17 16:01   res/mipmap/icon.png
      240  2026-04-17 16:01   res/mipmap/icon_background.png
     1909  2026-04-17 16:01   res/mipmap/icon_foreground.png
      668  2026-04-17 16:01   res/xml/godot_provider_paths.xml
    56980  2026-04-17 16:01   resources.arsc
      526  2026-04-17 16:01   assets/android/scafforge-managed.json
   397954  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage1.blend
   397954  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage2.blend
   439266  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage3.blend
   449594  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage4.blend
   449594  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage5.blend
   449594  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage6.blend
   449594  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage7.blend
   449720  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage8.blend
   473057  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage9.blend
   483385  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage10.blend
   473057  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage11.blend
   473057  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage12.blend
   473213  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage13.blend
   473213  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage14.blend
   473213  2026-04-17 16:01   assets/assets/blender/work/horse-war/stage15.blend
   377298  2026-04-17 16:01   assets/assets/blender/work/horse-war/work.blend
    36108  2026-04-17 16:01   assets/assets/models/arena-ground.glb
   372134  2026-04-17 16:01   assets/assets/models/horse-black-init.blend
   372134  2026-04-17 16:01   assets/assets/models/horse-black-stage1.blend
   449594  2026-04-17 16:01   assets/assets/models/horse-black-stage2.blend
   449594  2026-04-17 16:01   assets/assets/models/horse-black-stage3.blend
   395770  2026-04-17 16:01   assets/assets/models/horse-black-stage4.blend
   399436  2026-04-17 16:01   assets/assets/models/horse-black-stage5.blend
   422773  2026-04-17 16:01   assets/assets/models/horse-black-stage6.blend
   422773  2026-04-17 16:01   assets/assets/models/horse-black-stage7.blend
   414542  2026-04-17 16:01   assets/assets/models/horse-black-stage8.blend
   414542  2026-04-17 16:01   assets/assets/models/horse-black-stage9.blend
   372134  2026-04-17 16:01   assets/assets/models/horse-black-step1.blend
   372134  2026-04-17 16:01   assets/assets/models/horse-black.blend
    14596  2026-04-17 16:01   assets/assets/models/horse-black.glb
   338612  2026-04-17 16:01   assets/assets/models/horse-boss.glb
    18727  2026-04-17 16:01   assets/.godot/imported/horse-brown.glb-056461ab0ca84818de6850ecd60684b5.scn
      172  2026-04-17 16:01   assets/assets/models/horse-brown.glb.import
   372134  2026-04-17 16:01   assets/assets/models/horse-war-final.blend
   372134  2026-04-17 16:01   assets/assets/models/horse-war-init.blend
   372134  2026-04-17 16:01   assets/assets/models/horse-war-stage1.blend
   372134  2026-04-17 16:01   assets/assets/models/horse-war-step1.blend
   372134  2026-04-17 16:01   assets/assets/models/horse-war.blend
    46636  2026-04-17 16:01   assets/assets/models/horse-war.glb
     4370  2026-04-17 16:01   assets/.godot/imported/woman-warrior.glb-c54e8eda7a1d2bb62b178fb734436df4.scn
      175  2026-04-17 16:01   assets/assets/models/woman-warrior.glb.import
     2387  2026-04-17 16:01   assets/assets/pipeline.json
     1738  2026-04-17 16:01   assets/diagnosis/20260409-221836/disposition-bundle.json
     5182  2026-04-17 16:01   assets/diagnosis/20260409-221836/manifest.json
     2012  2026-04-17 16:01   assets/diagnosis/20260409-221836/recommended-ticket-payload.json
     1738  2026-04-17 16:01   assets/diagnosis/20260409-231527/disposition-bundle.json
     5238  2026-04-17 16:01   assets/diagnosis/20260409-231527/manifest.json
     2012  2026-04-17 16:01   assets/diagnosis/20260409-231527/recommended-ticket-payload.json
     1738  2026-04-17 16:01   assets/diagnosis/20260409-234108/disposition-bundle.json
     5238  2026-04-17 16:01   assets/diagnosis/20260409-234108/manifest.json
     2012  2026-04-17 16:01   assets/diagnosis/20260409-234108/recommended-ticket-payload.json
     1738  2026-04-17 16:01   assets/diagnosis/20260409-234646/disposition-bundle.json
     5238  2026-04-17 16:01   assets/diagnosis/20260409-234646/manifest.json
     2012  2026-04-17 16:01   assets/diagnosis/20260409-234646/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-031611/disposition-bundle.json
     6942  2026-04-17 16:01   assets/diagnosis/20260410-031611/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-031611/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-031809/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-031809/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-031809/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-032027/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-032027/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-032027/recommended-ticket-payload.json
     1494  2026-04-17 16:01   assets/diagnosis/20260410-033506/disposition-bundle.json
     5032  2026-04-17 16:01   assets/diagnosis/20260410-033506/manifest.json
     2272  2026-04-17 16:01   assets/diagnosis/20260410-033506/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-033655/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-033655/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-033655/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-033906/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-033906/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-033906/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-055819/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-055819/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-055819/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-060039/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-060039/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-060039/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-104539/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-104539/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-104539/recommended-ticket-payload.json
     3453  2026-04-17 16:01   assets/diagnosis/20260410-104842/disposition-bundle.json
    11767  2026-04-17 16:01   assets/diagnosis/20260410-104842/manifest.json
     6405  2026-04-17 16:01   assets/diagnosis/20260410-104842/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-105242/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-105242/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-105242/recommended-ticket-payload.json
     1494  2026-04-17 16:01   assets/diagnosis/20260410-105513/disposition-bundle.json
     5368  2026-04-17 16:01   assets/diagnosis/20260410-105513/manifest.json
     2272  2026-04-17 16:01   assets/diagnosis/20260410-105513/recommended-ticket-payload.json
     2267  2026-04-17 16:01   assets/diagnosis/20260410-110814/disposition-bundle.json
     7279  2026-04-17 16:01   assets/diagnosis/20260410-110814/manifest.json
     3319  2026-04-17 16:01   assets/diagnosis/20260410-110814/recommended-ticket-payload.json
     1494  2026-04-17 16:01   assets/diagnosis/20260410-111030/disposition-bundle.json
     5368  2026-04-17 16:01   assets/diagnosis/20260410-111030/manifest.json
     2272  2026-04-17 16:01   assets/diagnosis/20260410-111030/recommended-ticket-payload.json
     1459  2026-04-17 16:01   assets/diagnosis/20260410-113153/disposition-bundle.json
     5263  2026-04-17 16:01   assets/diagnosis/20260410-113153/manifest.json
     2202  2026-04-17 16:01   assets/diagnosis/20260410-113153/recommended-ticket-payload.json
     2232  2026-04-17 16:01   assets/diagnosis/20260410-114715/disposition-bundle.json
     7174  2026-04-17 16:01   assets/diagnosis/20260410-114715/manifest.json
     3249  2026-04-17 16:01   assets/diagnosis/20260410-114715/recommended-ticket-payload.json
     1459  2026-04-17 16:01   assets/diagnosis/20260410-114948/disposition-bundle.json
     5263  2026-04-17 16:01   assets/diagnosis/20260410-114948/manifest.json
     2202  2026-04-17 16:01   assets/diagnosis/20260410-114948/recommended-ticket-payload.json
     2397  2026-04-17 16:01   assets/diagnosis/20260411-155227/disposition-bundle.json
     8498  2026-04-17 16:01   assets/diagnosis/20260411-155227/manifest.json
     4515  2026-04-17 16:01   assets/diagnosis/20260411-155227/recommended-ticket-payload.json
     3170  2026-04-17 16:01   assets/diagnosis/20260411-155502/disposition-bundle.json
    10744  2026-04-17 16:01   assets/diagnosis/20260411-155502/manifest.json
     5562  2026-04-17 16:01   assets/diagnosis/20260411-155502/recommended-ticket-payload.json
     2397  2026-04-17 16:01   assets/diagnosis/20260411-155656/disposition-bundle.json
     8834  2026-04-17 16:01   assets/diagnosis/20260411-155656/manifest.json
     4515  2026-04-17 16:01   assets/diagnosis/20260411-155656/recommended-ticket-payload.json
     3657  2026-04-17 16:01   assets/diagnosis/20260411-162540/disposition-bundle.json
    12590  2026-04-17 16:01   assets/diagnosis/20260411-162540/manifest.json
     6824  2026-04-17 16:01   assets/diagnosis/20260411-162540/recommended-ticket-payload.json
     2884  2026-04-17 16:01   assets/diagnosis/20260411-162723/disposition-bundle.json
    10670  2026-04-17 16:01   assets/diagnosis/20260411-162723/manifest.json
     5777  2026-04-17 16:01   assets/diagnosis/20260411-162723/recommended-ticket-payload.json
     3746  2026-04-17 16:01   assets/diagnosis/20260411-162754/disposition-bundle.json
    12871  2026-04-17 16:01   assets/diagnosis/20260411-162754/manifest.json
     7008  2026-04-17 16:01   assets/diagnosis/20260411-162754/recommended-ticket-payload.json
     3657  2026-04-17 16:01   assets/diagnosis/20260411-162806/disposition-bundle.json
    12590  2026-04-17 16:01   assets/diagnosis/20260411-162806/manifest.json
     6824  2026-04-17 16:01   assets/diagnosis/20260411-162806/recommended-ticket-payload.json
     3746  2026-04-17 16:01   assets/diagnosis/20260411-163017/disposition-bundle.json
    12871  2026-04-17 16:01   assets/diagnosis/20260411-163017/manifest.json
     7008  2026-04-17 16:01   assets/diagnosis/20260411-163017/recommended-ticket-payload.json
     3489  2026-04-17 16:01   assets/diagnosis/20260411-163428/disposition-bundle.json
    12890  2026-04-17 16:01   assets/diagnosis/20260411-163428/manifest.json
     7615  2026-04-17 16:01   assets/diagnosis/20260411-163428/recommended-ticket-payload.json
     4267  2026-04-17 16:01   assets/diagnosis/20260411-163712/disposition-bundle.json
    14940  2026-04-17 16:01   assets/diagnosis/20260411-163712/manifest.json
     8787  2026-04-17 16:01   assets/diagnosis/20260411-163712/recommended-ticket-payload.json
     3715  2026-04-17 16:01   assets/diagnosis/20260411-163832/disposition-bundle.json
    12881  2026-04-17 16:01   assets/diagnosis/20260411-163832/manifest.json
     7051  2026-04-17 16:01   assets/diagnosis/20260411-163832/recommended-ticket-payload.json
     3746  2026-04-17 16:01   assets/diagnosis/20260411-164047/disposition-bundle.json
    12871  2026-04-17 16:01   assets/diagnosis/20260411-164047/manifest.json
     7008  2026-04-17 16:01   assets/diagnosis/20260411-164047/recommended-ticket-payload.json
     3489  2026-04-17 16:01   assets/diagnosis/20260411-164832/disposition-bundle.json
    12890  2026-04-17 16:01   assets/diagnosis/20260411-164832/manifest.json
     7615  2026-04-17 16:01   assets/diagnosis/20260411-164832/recommended-ticket-payload.json
     3657  2026-04-17 16:01   assets/diagnosis/20260411-165047/disposition-bundle.json
    12705  2026-04-17 16:01   assets/diagnosis/20260411-165047/manifest.json
     6939  2026-04-17 16:01   assets/diagnosis/20260411-165047/recommended-ticket-payload.json
     3746  2026-04-17 16:01   assets/diagnosis/20260411-165224/disposition-bundle.json
    12871  2026-04-17 16:01   assets/diagnosis/20260411-165224/manifest.json
     7008  2026-04-17 16:01   assets/diagnosis/20260411-165224/recommended-ticket-payload.json
     3010  2026-04-17 16:01   assets/diagnosis/20260411-165402/disposition-bundle.json
    11406  2026-04-17 16:01   assets/diagnosis/20260411-165402/manifest.json
     6369  2026-04-17 16:01   assets/diagnosis/20260411-165402/recommended-ticket-payload.json
     3872  2026-04-17 16:01   assets/diagnosis/20260411-165436/disposition-bundle.json
    13607  2026-04-17 16:01   assets/diagnosis/20260411-165436/manifest.json
     7600  2026-04-17 16:01   assets/diagnosis/20260411-165436/recommended-ticket-payload.json
     3010  2026-04-17 16:01   assets/diagnosis/20260411-170057/disposition-bundle.json
    11069  2026-04-17 16:01   assets/diagnosis/20260411-170057/manifest.json
     6369  2026-04-17 16:01   assets/diagnosis/20260411-170057/recommended-ticket-payload.json
     3178  2026-04-17 16:01   assets/diagnosis/20260411-170254/disposition-bundle.json
    10883  2026-04-17 16:01   assets/diagnosis/20260411-170254/manifest.json
     5693  2026-04-17 16:01   assets/diagnosis/20260411-170254/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-170511/disposition-bundle.json
     8858  2026-04-17 16:01   assets/diagnosis/20260411-170511/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-170511/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-171228/disposition-bundle.json
     8522  2026-04-17 16:01   assets/diagnosis/20260411-171228/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-171228/recommended-ticket-payload.json
     3178  2026-04-17 16:01   assets/diagnosis/20260411-171435/disposition-bundle.json
    10883  2026-04-17 16:01   assets/diagnosis/20260411-171435/manifest.json
     5693  2026-04-17 16:01   assets/diagnosis/20260411-171435/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-171643/disposition-bundle.json
     8858  2026-04-17 16:01   assets/diagnosis/20260411-171643/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-171643/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-172009/disposition-bundle.json
     8522  2026-04-17 16:01   assets/diagnosis/20260411-172009/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-172009/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-172420/disposition-bundle.json
     8522  2026-04-17 16:01   assets/diagnosis/20260411-172420/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-172420/recommended-ticket-payload.json
     3576  2026-04-17 16:01   assets/diagnosis/20260411-172608/disposition-bundle.json
    12381  2026-04-17 16:01   assets/diagnosis/20260411-172608/manifest.json
     6708  2026-04-17 16:01   assets/diagnosis/20260411-172608/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-172820/disposition-bundle.json
     8858  2026-04-17 16:01   assets/diagnosis/20260411-172820/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-172820/recommended-ticket-payload.json
     3576  2026-04-17 16:01   assets/diagnosis/20260411-173252/disposition-bundle.json
    12381  2026-04-17 16:01   assets/diagnosis/20260411-173252/manifest.json
     6708  2026-04-17 16:01   assets/diagnosis/20260411-173252/recommended-ticket-payload.json
     3665  2026-04-17 16:01   assets/diagnosis/20260411-173822/disposition-bundle.json
    12547  2026-04-17 16:01   assets/diagnosis/20260411-173822/manifest.json
     6777  2026-04-17 16:01   assets/diagnosis/20260411-173822/recommended-ticket-payload.json
     2803  2026-04-17 16:01   assets/diagnosis/20260411-174317/disposition-bundle.json
    10009  2026-04-17 16:01   assets/diagnosis/20260411-174317/manifest.json
     5546  2026-04-17 16:01   assets/diagnosis/20260411-174317/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-174706/disposition-bundle.json
     8522  2026-04-17 16:01   assets/diagnosis/20260411-174706/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-174706/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-175012/disposition-bundle.json
     8858  2026-04-17 16:01   assets/diagnosis/20260411-175012/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-175012/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-175158/disposition-bundle.json
     8858  2026-04-17 16:01   assets/diagnosis/20260411-175158/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-175158/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-180821/disposition-bundle.json
     8522  2026-04-17 16:01   assets/diagnosis/20260411-180821/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-180821/recommended-ticket-payload.json
     2405  2026-04-17 16:01   assets/diagnosis/20260411-180902/disposition-bundle.json
     8522  2026-04-17 16:01   assets/diagnosis/20260411-180902/manifest.json
     4531  2026-04-17 16:01   assets/diagnosis/20260411-180902/recommended-ticket-payload.json
     2880  2026-04-17 16:01   assets/diagnosis/20260411-193236/disposition-bundle.json
    10387  2026-04-17 16:01   assets/diagnosis/20260411-193236/manifest.json
     5768  2026-04-17 16:01   assets/diagnosis/20260411-193236/recommended-ticket-payload.json
     4051  2026-04-17 16:01   assets/diagnosis/20260411-193303/disposition-bundle.json
    14238  2026-04-17 16:01   assets/diagnosis/20260411-193303/manifest.json
     7945  2026-04-17 16:01   assets/diagnosis/20260411-193303/recommended-ticket-payload.json
     5237  2026-04-17 16:01   assets/diagnosis/20260411-205301/disposition-bundle.json
    18274  2026-04-17 16:01   assets/diagnosis/20260411-205301/manifest.json
    10916  2026-04-17 16:01   assets/diagnosis/20260411-205301/recommended-ticket-payload.json
     5237  2026-04-17 16:01   assets/diagnosis/20260412-030500/disposition-bundle.json
    18274  2026-04-17 16:01   assets/diagnosis/20260412-030500/manifest.json
    10916  2026-04-17 16:01   assets/diagnosis/20260412-030500/recommended-ticket-payload.json
     3653  2026-04-17 16:01   assets/diagnosis/20260412-030731/disposition-bundle.json
    12740  2026-04-17 16:01   assets/diagnosis/20260412-030731/manifest.json
     6930  2026-04-17 16:01   assets/diagnosis/20260412-030731/recommended-ticket-payload.json
     2880  2026-04-17 16:01   assets/diagnosis/20260412-030918/disposition-bundle.json
    10715  2026-04-17 16:01   assets/diagnosis/20260412-030918/manifest.json
     5768  2026-04-17 16:01   assets/diagnosis/20260412-030918/recommended-ticket-payload.json
     2880  2026-04-17 16:01   assets/diagnosis/20260412-031656/disposition-bundle.json
    10379  2026-04-17 16:01   assets/diagnosis/20260412-031656/manifest.json
     5768  2026-04-17 16:01   assets/diagnosis/20260412-031656/recommended-ticket-payload.json
     3948  2026-04-17 16:01   assets/diagnosis/20260414-031053/disposition-bundle.json
    14639  2026-04-17 16:01   assets/diagnosis/20260414-031053/manifest.json
     8783  2026-04-17 16:01   assets/diagnosis/20260414-031053/recommended-ticket-payload.json
     3929  2026-04-17 16:01   assets/diagnosis/20260414-220536/disposition-bundle.json
    14609  2026-04-17 16:01   assets/diagnosis/20260414-220536/manifest.json
     8783  2026-04-17 16:01   assets/diagnosis/20260414-220536/recommended-ticket-payload.json
     4653  2026-04-17 16:01   assets/diagnosis/20260415-031748/disposition-bundle.json
    17010  2026-04-17 16:01   assets/diagnosis/20260415-031748/manifest.json
    10296  2026-04-17 16:01   assets/diagnosis/20260415-031748/recommended-ticket-payload.json
     4041  2026-04-17 16:01   assets/diagnosis/20260415-032235/disposition-bundle.json
    14107  2026-04-17 16:01   assets/diagnosis/20260415-032235/manifest.json
     7835  2026-04-17 16:01   assets/diagnosis/20260415-032235/recommended-ticket-payload.json
     2874  2026-04-17 16:01   assets/diagnosis/20260415-032448/disposition-bundle.json
    10697  2026-04-17 16:01   assets/diagnosis/20260415-032448/manifest.json
     5768  2026-04-17 16:01   assets/diagnosis/20260415-032448/recommended-ticket-payload.json
      571  2026-04-17 16:01   assets/diagnosis/20260415-203600/disposition-bundle.json
     1416  2026-04-17 16:01   assets/diagnosis/20260415-203600/manifest.json
     2582  2026-04-17 16:01   assets/diagnosis/20260416-011537/disposition-bundle.json
     9433  2026-04-17 16:01   assets/diagnosis/20260416-011537/manifest.json
     5343  2026-04-17 16:01   assets/diagnosis/20260416-011537/recommended-ticket-payload.json
     2582  2026-04-17 16:01   assets/diagnosis/20260416-011743/disposition-bundle.json
     9433  2026-04-17 16:01   assets/diagnosis/20260416-011743/manifest.json
     5343  2026-04-17 16:01   assets/diagnosis/20260416-011743/recommended-ticket-payload.json
     3355  2026-04-17 16:01   assets/diagnosis/20260416-012258/disposition-bundle.json
    11473  2026-04-17 16:01   assets/diagnosis/20260416-012258/manifest.json
     6510  2026-04-17 16:01   assets/diagnosis/20260416-012258/recommended-ticket-payload.json
     3355  2026-04-17 16:01   assets/diagnosis/20260416-144639/disposition-bundle.json
    11473  2026-04-17 16:01   assets/diagnosis/20260416-144639/manifest.json
     6510  2026-04-17 16:01   assets/diagnosis/20260416-144639/recommended-ticket-payload.json
     4993  2026-04-17 16:01   assets/diagnosis/20260416-144646/disposition-bundle.json
    15839  2026-04-17 16:01   assets/diagnosis/20260416-144646/manifest.json
     8948  2026-04-17 16:01   assets/diagnosis/20260416-144646/recommended-ticket-payload.json
     4358  2026-04-17 16:01   assets/diagnosis/20260416-153203/disposition-bundle.json
    16503  2026-04-17 16:01   assets/diagnosis/20260416-153203/manifest.json
    10270  2026-04-17 16:01   assets/diagnosis/20260416-153203/recommended-ticket-payload.json
     3396  2026-04-17 16:01   assets/diagnosis/20260416-153221/disposition-bundle.json
    12885  2026-04-17 16:01   assets/diagnosis/20260416-153221/manifest.json
     7482  2026-04-17 16:01   assets/diagnosis/20260416-153221/recommended-ticket-payload.json
     3790  2026-04-17 16:01   assets/diagnosis/20260416-184444/disposition-bundle.json
    14299  2026-04-17 16:01   assets/diagnosis/20260416-184444/manifest.json
     8682  2026-04-17 16:01   assets/diagnosis/20260416-184444/recommended-ticket-payload.json
     4448  2026-04-17 16:01   assets/diagnosis/20260416-193254/disposition-bundle.json
    14845  2026-04-17 16:01   assets/diagnosis/20260416-193254/manifest.json
     8682  2026-04-17 16:01   assets/diagnosis/20260416-193254/recommended-ticket-payload.json
     4448  2026-04-17 16:01   assets/diagnosis/20260416-193334/disposition-bundle.json
    15148  2026-04-17 16:01   assets/diagnosis/20260416-193334/manifest.json
     8682  2026-04-17 16:01   assets/diagnosis/20260416-193334/recommended-ticket-payload.json
     4028  2026-04-17 16:01   assets/diagnosis/20260416-193720/disposition-bundle.json
    13482  2026-04-17 16:01   assets/diagnosis/20260416-193720/manifest.json
     7520  2026-04-17 16:01   assets/diagnosis/20260416-193720/recommended-ticket-payload.json
     2010  2026-04-17 16:01   assets/diagnosis/20260416-202637/disposition-bundle.json
     7098  2026-04-17 16:01   assets/diagnosis/20260416-202637/manifest.json
     3800  2026-04-17 16:01   assets/diagnosis/20260416-202637/recommended-ticket-payload.json
     2430  2026-04-17 16:01   assets/diagnosis/20260416-202704/disposition-bundle.json
     9087  2026-04-17 16:01   assets/diagnosis/20260416-202704/manifest.json
     4962  2026-04-17 16:01   assets/diagnosis/20260416-202704/recommended-ticket-payload.json
     2430  2026-04-17 16:01   assets/diagnosis/20260416-203612/disposition-bundle.json
     9087  2026-04-17 16:01   assets/diagnosis/20260416-203612/manifest.json
     4962  2026-04-17 16:01   assets/diagnosis/20260416-203612/recommended-ticket-payload.json
     2430  2026-04-17 16:01   assets/diagnosis/20260416-203731/disposition-bundle.json
     9087  2026-04-17 16:01   assets/diagnosis/20260416-203731/manifest.json
     4962  2026-04-17 16:01   assets/diagnosis/20260416-203731/recommended-ticket-payload.json
     2010  2026-04-17 16:01   assets/diagnosis/20260416-203930/disposition-bundle.json
     7421  2026-04-17 16:01   assets/diagnosis/20260416-203930/manifest.json
     3800  2026-04-17 16:01   assets/diagnosis/20260416-203930/recommended-ticket-payload.json
     2411  2026-04-17 16:01   assets/diagnosis/20260416-204737/disposition-bundle.json
     9030  2026-04-17 16:01   assets/diagnosis/20260416-204737/manifest.json
     4962  2026-04-17 16:01   assets/diagnosis/20260416-204737/recommended-ticket-payload.json
     1609  2026-04-17 16:01   assets/diagnosis/20260416-211512/disposition-bundle.json
     6139  2026-04-17 16:01   assets/diagnosis/20260416-211512/manifest.json
     2928  2026-04-17 16:01   assets/diagnosis/20260416-211512/recommended-ticket-payload.json
     1909  2026-04-17 16:01   assets/diagnosis/20260416-212735/disposition-bundle.json
     6465  2026-04-17 16:01   assets/diagnosis/20260416-212735/manifest.json
     2928  2026-04-17 16:01   assets/diagnosis/20260416-212735/recommended-ticket-payload.json
     1909  2026-04-17 16:01   assets/diagnosis/20260416-213146/disposition-bundle.json
     6465  2026-04-17 16:01   assets/diagnosis/20260416-213146/manifest.json
     2928  2026-04-17 16:01   assets/diagnosis/20260416-213146/recommended-ticket-payload.json
     1909  2026-04-17 16:01   assets/diagnosis/20260416-213653/disposition-bundle.json
     6465  2026-04-17 16:01   assets/diagnosis/20260416-213653/manifest.json
     2928  2026-04-17 16:01   assets/diagnosis/20260416-213653/recommended-ticket-payload.json
     3202  2026-04-17 16:01   assets/diagnosis/20260417-022609/disposition-bundle.json
    11327  2026-04-17 16:01   assets/diagnosis/20260417-022609/manifest.json
     6241  2026-04-17 16:01   assets/diagnosis/20260417-022609/recommended-ticket-payload.json
     2782  2026-04-17 16:01   assets/diagnosis/20260417-023206/disposition-bundle.json
     9661  2026-04-17 16:01   assets/diagnosis/20260417-023206/manifest.json
     5079  2026-04-17 16:01   assets/diagnosis/20260417-023206/recommended-ticket-payload.json
     2514  2026-04-17 16:01   assets/diagnosis/20260417-023543/disposition-bundle.json
     9013  2026-04-17 16:01   assets/diagnosis/20260417-023543/manifest.json
     4766  2026-04-17 16:01   assets/diagnosis/20260417-023543/recommended-ticket-payload.json
     2514  2026-04-17 16:01   assets/diagnosis/20260417-023632/disposition-bundle.json
     9013  2026-04-17 16:01   assets/diagnosis/20260417-023632/manifest.json
     4766  2026-04-17 16:01   assets/diagnosis/20260417-023632/recommended-ticket-payload.json
     1909  2026-04-17 16:01   assets/diagnosis/20260417-023825/disposition-bundle.json
     6465  2026-04-17 16:01   assets/diagnosis/20260417-023825/manifest.json
     2928  2026-04-17 16:01   assets/diagnosis/20260417-023825/recommended-ticket-payload.json
     2865  2026-04-17 16:01   assets/diagnosis/20260417-042304/disposition-bundle.json
     9884  2026-04-17 16:01   assets/diagnosis/20260417-042304/manifest.json
     5503  2026-04-17 16:01   assets/diagnosis/20260417-042304/recommended-ticket-payload.json
     2834  2026-04-17 16:01   assets/diagnosis/20260417-065602/disposition-bundle.json
     9878  2026-04-17 16:01   assets/diagnosis/20260417-065602/manifest.json
     5213  2026-04-17 16:01   assets/diagnosis/20260417-065602/recommended-ticket-payload.json
     1641  2026-04-17 16:01   assets/diagnosis/20260417-073409/disposition-bundle.json
     5582  2026-04-17 16:01   assets/diagnosis/20260417-073409/manifest.json
     2731  2026-04-17 16:01   assets/diagnosis/20260417-073409/recommended-ticket-payload.json
     2834  2026-04-17 16:01   assets/diagnosis/20260417-075213/disposition-bundle.json
     9878  2026-04-17 16:01   assets/diagnosis/20260417-075213/manifest.json
     5213  2026-04-17 16:01   assets/diagnosis/20260417-075213/recommended-ticket-payload.json
     2440  2026-04-17 16:01   assets/diagnosis/20260417-080950/disposition-bundle.json
     8494  2026-04-17 16:01   assets/diagnosis/20260417-080950/manifest.json
     4308  2026-04-17 16:01   assets/diagnosis/20260417-080950/recommended-ticket-payload.json
     2020  2026-04-17 16:01   assets/diagnosis/20260417-081640/disposition-bundle.json
     6837  2026-04-17 16:01   assets/diagnosis/20260417-081640/manifest.json
     3146  2026-04-17 16:01   assets/diagnosis/20260417-081640/recommended-ticket-payload.json
     2440  2026-04-17 16:01   assets/diagnosis/20260417-085239/disposition-bundle.json
     8494  2026-04-17 16:01   assets/diagnosis/20260417-085239/manifest.json
     4308  2026-04-17 16:01   assets/diagnosis/20260417-085239/recommended-ticket-payload.json
     2020  2026-04-17 16:01   assets/diagnosis/20260417-090306/disposition-bundle.json
     6837  2026-04-17 16:01   assets/diagnosis/20260417-090306/manifest.json
     3146  2026-04-17 16:01   assets/diagnosis/20260417-090306/recommended-ticket-payload.json
     2915  2026-04-17 16:01   assets/diagnosis/20260417-095141/disposition-bundle.json
    10373  2026-04-17 16:01   assets/diagnosis/20260417-095141/manifest.json
     5545  2026-04-17 16:01   assets/diagnosis/20260417-095141/recommended-ticket-payload.json
     2495  2026-04-17 16:01   assets/diagnosis/20260417-095349/disposition-bundle.json
     8716  2026-04-17 16:01   assets/diagnosis/20260417-095349/manifest.json
     4383  2026-04-17 16:01   assets/diagnosis/20260417-095349/recommended-ticket-payload.json
     1722  2026-04-17 16:01   assets/diagnosis/20260417-101926/disposition-bundle.json
     6087  2026-04-17 16:01   assets/diagnosis/20260417-101926/manifest.json
     3063  2026-04-17 16:01   assets/diagnosis/20260417-101926/recommended-ticket-payload.json
     2915  2026-04-17 16:01   assets/diagnosis/20260417-102133/disposition-bundle.json
    10373  2026-04-17 16:01   assets/diagnosis/20260417-102133/manifest.json
     5545  2026-04-17 16:01   assets/diagnosis/20260417-102133/recommended-ticket-payload.json
     2495  2026-04-17 16:01   assets/diagnosis/20260417-102907/disposition-bundle.json
     8716  2026-04-17 16:01   assets/diagnosis/20260417-102907/manifest.json
     4383  2026-04-17 16:01   assets/diagnosis/20260417-102907/recommended-ticket-payload.json
     3198  2026-04-17 16:01   assets/diagnosis/20260417-105116/disposition-bundle.json
    10383  2026-04-17 16:01   assets/diagnosis/20260417-105116/manifest.json
     5567  2026-04-17 16:01   assets/diagnosis/20260417-105116/recommended-ticket-payload.json
     3618  2026-04-17 16:01   assets/diagnosis/20260417-105138/disposition-bundle.json
    12361  2026-04-17 16:01   assets/diagnosis/20260417-105138/manifest.json
     6729  2026-04-17 16:01   assets/diagnosis/20260417-105138/recommended-ticket-payload.json
     3198  2026-04-17 16:01   assets/diagnosis/20260417-105507/disposition-bundle.json
    10704  2026-04-17 16:01   assets/diagnosis/20260417-105507/manifest.json
     5567  2026-04-17 16:01   assets/diagnosis/20260417-105507/recommended-ticket-payload.json
     3483  2026-04-17 16:01   assets/diagnosis/20260417-130026/disposition-bundle.json
    13159  2026-04-17 16:01   assets/diagnosis/20260417-130026/manifest.json
     7866  2026-04-17 16:01   assets/diagnosis/20260417-130026/recommended-ticket-payload.json
     4400  2026-04-17 16:01   assets/diagnosis/20260417-130810/disposition-bundle.json
    16698  2026-04-17 16:01   assets/diagnosis/20260417-130810/manifest.json
    10368  2026-04-17 16:01   assets/diagnosis/20260417-130810/recommended-ticket-payload.json
     3058  2026-04-17 16:01   assets/diagnosis/20260417-130905/disposition-bundle.json
    11769  2026-04-17 16:01   assets/diagnosis/20260417-130905/manifest.json
     6671  2026-04-17 16:01   assets/diagnosis/20260417-130905/recommended-ticket-payload.json
     2638  2026-04-17 16:01   assets/diagnosis/20260417-131517/disposition-bundle.json
    10103  2026-04-17 16:01   assets/diagnosis/20260417-131517/manifest.json
     5509  2026-04-17 16:01   assets/diagnosis/20260417-131517/recommended-ticket-payload.json
     2212  2026-04-17 16:01   assets/diagnosis/20260417-132112/disposition-bundle.json
     8423  2026-04-17 16:01   assets/diagnosis/20260417-132112/manifest.json
     4330  2026-04-17 16:01   assets/diagnosis/20260417-132112/recommended-ticket-payload.json
     2212  2026-04-17 16:01   assets/diagnosis/20260417-132452/disposition-bundle.json
     8423  2026-04-17 16:01   assets/diagnosis/20260417-132452/manifest.json
     4330  2026-04-17 16:01   assets/diagnosis/20260417-132452/recommended-ticket-payload.json
       47  2026-04-17 16:01   assets/node_modules/@opencode-ai/plugin/package.json
     1328  2026-04-17 16:01   assets/.godot/exported/133200997/export-8ddfe6f8446e54dd7240dc80a2be5fea-arena.scn
     1596  2026-04-17 16:01   assets/.godot/exported/133200997/export-955c8496af06026112ca205bac2d6992-horse_base.scn
     1601  2026-04-17 16:01   assets/.godot/exported/133200997/export-c2c62cb8c73458cd122faf659769dc80-player.scn
     1710  2026-04-17 16:01   assets/.godot/exported/133200997/export-ba494dd9b051bd79084501bcfe9f90ed-game_over_screen.scn
     3435  2026-04-17 16:01   assets/scenes/ui/hud.tscn
     1415  2026-04-17 16:01   assets/.godot/exported/133200997/export-5eabcd2865b627a14b0c7b9586988c63-title_screen.scn
      791  2026-04-17 16:01   assets/.godot/exported/133200997/export-7165550c0b61bf6ca2260a0ddfc1dd1a-wave_spawner.scn
     1848  2026-04-17 16:01   assets/.godot/exported/133200997/export-3ad5c15c4f3250da0cc7c1af1770d85f-main.scn
    12456  2026-04-17 16:01   assets/scripts/audio/audio_manager.gdc
     1012  2026-04-17 16:01   assets/scripts/enemies/HealthComponent.gdc
     9444  2026-04-17 16:01   assets/scripts/enemies/horse_base.gdc
     2412  2026-04-17 16:01   assets/scripts/enemies/horse_variants.gdc
     2088  2026-04-17 16:01   assets/scripts/ui/attack_button.gdc
     3212  2026-04-17 16:01   assets/scripts/ui/game_over_screen.gdc
     3564  2026-04-17 16:01   assets/scripts/ui/health_display.gdc
     1940  2026-04-17 16:01   assets/scripts/ui/score_display.gdc
     1068  2026-04-17 16:01   assets/scripts/ui/title_screen.gdc
     3728  2026-04-17 16:01   assets/scripts/ui/virtual_joystick.gdc
     6052  2026-04-17 16:01   assets/scripts/ui/wave_display.gdc
    12280  2026-04-17 16:01   assets/scripts/wave_spawner/wave_spawner.gdc
     2200  2026-04-17 16:01   assets/scripts/attack_system.gdc
      912  2026-04-17 16:01   assets/scripts/HitFlash.gdc
     1092  2026-04-17 16:01   assets/scripts/PlayerHitFlash.gdc
     8528  2026-04-17 16:01   assets/scripts/player_controller.gdc
   249511  2026-04-17 16:01   assets/tickets/manifest.json
   372134  2026-04-17 16:01   assets/tmp/model-005/init.blend
   449127  2026-04-17 16:01   assets/tmp/model-005/stage1.blend
   596227  2026-04-17 16:01   assets/tmp/model-005/stage2.blend
   676589  2026-04-17 16:01   assets/tmp/model-005/stage3.blend
   608609  2026-04-17 16:01   assets/tmp/model-005/stage4.blend
   717038  2026-04-17 16:01   assets/tmp/model-005/stage5.blend
   740375  2026-04-17 16:01   assets/tmp/model-005/stage6.blend
   372134  2026-04-17 16:01   assets/tmp/model-005/staging.blend
   372134  2026-04-17 16:01   assets/tmp/model-005/work.blend
   372134  2026-04-17 16:01   assets/tmp/model-005-test/init.blend
   500760  2026-04-17 16:01   assets/tmp/model-006/stage1.blend
   524097  2026-04-17 16:01   assets/tmp/model-006/stage2.blend
   549481  2026-04-17 16:01   assets/tmp/model-006/stage3.blend
   372134  2026-04-17 16:01   assets/tmp/model-006/work.blend
   372134  2026-04-17 16:01   assets/tmp/staging/horse-war/stage1.blend
   372134  2026-04-17 16:01   assets/tmp/staging/horse-war/stage1a.blend
   372134  2026-04-17 16:01   assets/tmp/horse-black-init.blend
   377298  2026-04-17 16:01   assets/tmp/remed-009-test-chain.blend
   372134  2026-04-17 16:01   assets/tmp/remed-009-test-init.blend
   372134  2026-04-17 16:01   assets/horse-war-stage1.blend
   372134  2026-04-17 16:01   assets/stage1.blend
       98  2026-04-17 16:01   assets/scenes/arena/arena.tscn.remap
      103  2026-04-17 16:01   assets/scenes/enemies/horse_base.tscn.remap
       99  2026-04-17 16:01   assets/scenes/player/player.tscn.remap
      109  2026-04-17 16:01   assets/scenes/ui/game_over_screen.tscn.remap
      105  2026-04-17 16:01   assets/scenes/ui/title_screen.tscn.remap
      105  2026-04-17 16:01   assets/scenes/wave_spawner/wave_spawner.tscn.remap
       97  2026-04-17 16:01   assets/scenes/main.tscn.remap
       54  2026-04-17 16:01   assets/scripts/audio/audio_manager.gd.remap
       58  2026-04-17 16:01   assets/scripts/enemies/HealthComponent.gd.remap
       53  2026-04-17 16:01   assets/scripts/enemies/horse_base.gd.remap
       57  2026-04-17 16:01   assets/scripts/enemies/horse_variants.gd.remap
       51  2026-04-17 16:01   assets/scripts/ui/attack_button.gd.remap
       54  2026-04-17 16:01   assets/scripts/ui/game_over_screen.gd.remap
       52  2026-04-17 16:01   assets/scripts/ui/health_display.gd.remap
       51  2026-04-17 16:01   assets/scripts/ui/score_display.gd.remap
       50  2026-04-17 16:01   assets/scripts/ui/title_screen.gd.remap
       54  2026-04-17 16:01   assets/scripts/ui/virtual_joystick.gd.remap
       50  2026-04-17 16:01   assets/scripts/ui/wave_display.gd.remap
       60  2026-04-17 16:01   assets/scripts/wave_spawner/wave_spawner.gd.remap
       48  2026-04-17 16:01   assets/scripts/attack_system.gd.remap
       43  2026-04-17 16:01   assets/scripts/HitFlash.gd.remap
       49  2026-04-17 16:01   assets/scripts/PlayerHitFlash.gd.remap
       52  2026-04-17 16:01   assets/scripts/player_controller.gd.remap
      902  2026-04-17 16:01   assets/.godot/global_script_class_cache.cfg
      100  2026-04-17 16:01   assets/.godot/uid_cache.bin
      730  2026-04-17 16:01   assets/project.binary
    40820  2026-04-17 16:01   assets/assets.sparsepck
       94  2026-04-17 16:01   assets/_cl_
    67026  2026-04-17 16:01   META-INF/ANDROIDD.SF
     1223  2026-04-17 16:01   META-INF/ANDROIDD.RSA
    66899  2026-04-17 16:01   META-INF/MANIFEST.MF
---------                     -------
105493018                     550 files
~~~~

#### stderr

~~~~text
<no output>
~~~~
