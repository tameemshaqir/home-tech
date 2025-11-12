#!/bin/bash

# استخدم: ./change_package_name.sh com.old.package com.new.package

OLD_PACKAGE=$1
NEW_PACKAGE=$2

if [[ -z "$OLD_PACKAGE" || -z "$NEW_PACKAGE" ]]; then
  echo "❌ Usage: ./change_package_name.sh com.old.package com.new.package"
  exit 1
fi

# المسارات داخل Android
MAIN_KOTLIN_PATH="android/app/src/main/kotlin"
OLD_PATH="${MAIN_KOTLIN_PATH}/$(echo $OLD_PACKAGE | tr '.' '/')"
NEW_PATH="${MAIN_KOTLIN_PATH}/$(echo $NEW_PACKAGE | tr '.' '/')"

# إنشاء مجلد جديد
mkdir -p "$NEW_PATH"

# نقل الملفات من المجلد القديم إلى الجديد
mv "$OLD_PATH/"* "$NEW_PATH/"
rm -rf "$MAIN_KOTLIN_PATH/$(echo $OLD_PACKAGE | cut -d'.' -f1)"

# تحديث package في MainActivity
MAIN_ACTIVITY="$NEW_PATH/MainActivity.kt"
sed -i '' "s/package $OLD_PACKAGE/package $NEW_PACKAGE/" "$MAIN_ACTIVITY"

# تحديث applicationId في build.gradle
BUILD_GRADLE="android/app/build.gradle"
sed -i '' "s/applicationId \"$OLD_PACKAGE\"/applicationId \"$NEW_PACKAGE\"/" "$BUILD_GRADLE"

# تحديث AndroidManifest
MANIFEST="android/app/src/main/AndroidManifest.xml"
sed -i '' "s/package=\"$OLD_PACKAGE\"/package=\"$NEW_PACKAGE\"/" "$MANIFEST"

echo "✅ Package name changed from $OLD_PACKAGE to $NEW_PACKAGE"
