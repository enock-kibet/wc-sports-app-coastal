#!/bin/bash
set -e

echo "💙 Installing Flutter..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
export PATH="$HOME/flutter/bin:$PATH"

echo "💙 Getting Flutter dependencies..."
flutter pub get

echo "💙 Building iOS release..."
flutter build ios --release --no-codesign

echo "💙 Installing CocoaPods..."
pod install

echo "💙 Done!"
