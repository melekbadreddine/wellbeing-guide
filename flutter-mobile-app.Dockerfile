# Use the official Flutter image as a base
FROM cirrusci/flutter:stable AS builder

# Set the working directory
WORKDIR /app

# Copy the pubspec.yaml and pubspec.lock
COPY pubspec.yaml pubspec.lock ./

# Get dependencies
RUN flutter pub get

# Copy the entire project
COPY . .

# Build the Flutter app for Android and iOS
RUN flutter build apk --release
RUN flutter build ios --release
