#!/bin/bash
set -e

echo "💙 Setting up Flutter..."
git clone https://github.com/flutter/flutter.git --depth 1 -b stable $HOME/flutter
export PATH="$HOME/flutter/bin:$PATH"

echo "💙 Getting Flutter dependencies..."
flutter pub get

echo "💙 Building iOS release..."
flutter build ios --release --no-codesign

echo "💙 Installing CocoaPods..."
cd ios
pod install

echo "💙 Done!"
