#!/usr/bin/env bash
theme="catppuccin-frappe"
dir="$HOME/.config/rofi/"

# catppuccin
ALPHA="#00000000"
BG="#24273A"
FG="#BF616A"
SELECT="#1E1E2E"
ACCENT="#24273A"

# overwrite colors file
cat > $dir/colors.rasi <<- EOF
	/* colors */

	* {
	  al:  $ALPHA;
	  bg:  $BG;
	  se:  $SELECT;
	  fg:  $FG;
	  ac:  $ACCENT;
	}
EOF

rofi -no-lazy-grab -show drun -modi drun -theme $dir/"$theme"
