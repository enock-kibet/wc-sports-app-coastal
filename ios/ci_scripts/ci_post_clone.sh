#!/bin/sh

# Install CocoaPods using Homebrew
HOMEBREW_NO_AUTO_UPDATE=1
brew install cocoapods

# Install Flutter
brew install --cask flutter

# Run Flutter doctor
flutter doctor

# Precache iOS dependencies
flutter precache --ios

# Get packages
flutter pub get

# Install pods
cd ios
pod install --repo-update
cd ..

# Build iOS app
flutter build ios --no-codesign