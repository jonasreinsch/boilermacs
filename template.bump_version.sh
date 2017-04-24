#!/bin/bash

PLIST_FILE='##CURSOR_POS.plist'

version=$(/usr/libexec/PlistBuddy -c  'Print CFBundleVersion' "${PLIST_FILE}")

new_version=$(<<< 0.1+"$version" bc)

/usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString $new_version" "${PLIST_FILE}"
/usr/libexec/PlistBuddy -c "Set CFBundleVersion $new_version" "${PLIST_FILE}"

string_to_pbcopy="git commit -am 'bump version to $new_version'"

echo -n "$string_to_pbcopy" | pbcopy
echo "$string_to_pbcopy" copied to pasteboard
