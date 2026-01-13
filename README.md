# 🛡️ DeepVoice Shield - Mobile App

> **Deepfake Detection Service Application** > 온디바이스 AI 기반 딥보이스 탐지 모바일 애플리케이션

![React Native](https://img.shields.io/badge/React_Native-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![TypeScript](https://img.shields.io/badge/TypeScript-007ACC?style=for-the-badge&logo=typescript&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## 📌 Project Overview
이 프로젝트는 **React Native**로 개발된 딥보이스 탐지 서비스 애플리케이션입니다.  
사용자의 통화 또는 음성 녹음 파일을 분석하여 AI 기반으로 딥페이크 여부를 판별합니다.

## 🚀 Getting Started

> **Note**: 시작하기 전에 [React Native 개발 환경 설정](https://reactnative.dev/docs/set-up-your-environment)이 완료되어 있어야 합니다.

### 1. Start Metro
Javascript 번들러인 Metro 서버를 실행합니다.

```bash
# Using npm
npm start

# OR using Yarn
yarn start
```

###2. Build and Run
새로운 터미널을 열고 앱을 에뮬레이터 또는 디바이스에 설치합니다.

**굵게Android**
```bash
npm run android
# OR
yarn android
```

## 🛠 Features
+ 실시간/파일 기반 딥보이스 탐지: 온디바이스 AI 모델 연동

+ 결과 리포트: 탐지 확률 및 위험도 시각화

+ 히스토리 관리: 검사 기록 저장 및 관리

## 📂 Project Structure
```bash
root
├── src
│   ├── components  # 재사용 가능한 UI 컴포넌트
│   ├── screens     # 각 페이지 화면
│   ├── navigation  # 네비게이션 설정
│   └── services    # API 및 비즈니스 로직
├── android         # Android 네이티브 코드
├── ios             # iOS 네이티브 코드
└── App.tsx         # 엔트리 포인트
```

## 🔗 Related Repositories
+ Backend: [deepfake_detection_service_backend](https://github.com/thisNorm/deepfake_detection_service_backend.git)

+ Frontend (Landing): [deepfake_detection_service_frontend](https://github.com/thisNorm/deepfake_detection_service_frontend.git)

+ Algorithm: [deepfake_detection_service_algorithm](https://github.com/thisNorm/deepfake_detection_service_algorithm.git)
