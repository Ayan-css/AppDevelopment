#!/usr/bin/env bash
set -euo pipefail

VERSION_TAG="${VERSION_TAG:-v0.1.0}"
MODE="${MODE:-release}"   # release | commit

echo "==> Flutter version"
flutter --version

# Generate platform folders only if missing
if [ ! -d "android" ]; then
  echo "==> android folder missing, running flutter create ."
  flutter create .
fi

echo "==> Getting dependencies"
flutter pub get

echo "==> Building release APK"
flutter build apk --release

APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
if [ ! -f "$APK_PATH" ]; then
  echo "ERROR: APK not found at $APK_PATH"
  exit 1
fi
echo "==> APK built: $APK_PATH"

if [ "$MODE" = "release" ]; then
  echo "==> Uploading to GitHub Release: $VERSION_TAG"
  gh release create "$VERSION_TAG" "$APK_PATH" \
    --title "Founder Cockpit $VERSION_TAG" \
    --notes "Android release APK" \
    || gh release upload "$VERSION_TAG" "$APK_PATH" --clobber
  echo "==> Release upload done."
elif [ "$MODE" = "commit" ]; then
  mkdir -p releases/android
  cp "$APK_PATH" "releases/android/founder-cockpit-${VERSION_TAG}.apk"
  git add releases/android
  git commit -m "Add Android release APK ${VERSION_TAG}" || true
  git push
  echo "==> APK committed to repo."
else
  echo "ERROR: MODE must be 'release' or 'commit'"
  exit 1
fi
