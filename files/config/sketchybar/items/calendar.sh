#!/bin/bash

sketchybar --add item calendar.event right \
  --set calendar.event label.color=$ACCENT_COLOR \
  updates=on \
  update_freq=60 \
  script="$PLUGIN_DIR/calendar.sh" \
  label.max_chars=6 \
  scroll_texts=on \
  icon.drawing=off \
  background.drawing=off \
  click_script="open -a \"Google Calendar\""

sketchybar --add item calendar.time right \
  --set calendar.time label.color=$ACCENT_COLOR \
  label.max_chars=5 \
  icon.drawing=off \
  background.drawing=off \
  click_script="open -a \"Google Calendar\""

sketchybar --add item calendar.icon right \
  --set calendar.icon label.drawing=off \
  icon.padding_left=0 \
  icon.padding_right=0 \
  icon="󰃰" \
  icon.color=$ACCENT_COLOR \
  background.drawing=off \
  click_script="open -a \"Google Calendar\""
