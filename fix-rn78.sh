#!/usr/bin/env bash
set -euo pipefail

echo "== React Native 0.78 라이브러리 Gradle 정리 =="

# 문제 가능성이 높은 패키지 목록
PKGS=(
  lottie-react-native
  react-native-gesture-handler
  react-native-reanimated
  react-native-safe-area-context
  react-native-screens
  react-native-svg
  react-native-vector-icons
  react-native-fs
  react-native-incall-manager
  react-native-file-picker
  @react-native-async-storage/async-storage
)

for P in "${PKGS[@]}"; do
  FILE="node_modules/$P/android/build.gradle"
  if [[ -f "$FILE" ]]; then
    echo "→ patching $FILE"

    # 1) 서브모듈에서 RN 플러그인 적용 제거
    #    apply plugin: 'com.facebook.react'
    sed -i '' "/apply[[:space:]]\+plugin[[:space:]]*:[[:space:]]*['\"]com.facebook.react['\"]/d" "$FILE" || true

    #    plugins { id "com.facebook.react" ... }
    #    (해당 줄 제거)
    sed -i '' "/id[[:space:]]\+['\"]com.facebook.react['\"]/d" "$FILE" || true

    # 2) 라이브러리 플러그인 보장 (없으면 파일 상단에 삽입)
    if ! grep -q "com.android.library" "$FILE"; then
      printf "plugins {\n    id 'com.android.library'\n}\n\n" | cat - "$FILE" > "$FILE.tmp" && mv "$FILE.tmp" "$FILE"
    fi

    # 3) 구식 좌표 치환
    #    com.facebook.react:react-native:+  -> com.facebook.react:react-android
    sed -i '' "s/com.facebook.react:react-native:+/com.facebook.react:react-android/g" "$FILE" || true
    #    com.facebook.react:react-android:+ -> com.facebook.react:react-android (고정)
    sed -i '' "s/com.facebook.react:react-android:+/com.facebook.react:react-android/g" "$FILE" || true
    #    com.facebook.react:hermes-android:+ -> com.facebook.react:hermes-android
    sed -i '' "s/com.facebook.react:hermes-android:+/com.facebook.react:hermes-android/g" "$FILE" || true
  fi
done

echo "== done =="
