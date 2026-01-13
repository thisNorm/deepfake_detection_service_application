# 🛡️ DeepVoice Shield - Mobile App

> **Deepfake Detection Service Application** > 온디바이스 AI와 WebRTC를 활용한 실시간 딥보이스 탐지 안드로이드 애플리케이션

![React Native](https://img.shields.io/badge/React_Native-v0.78.0-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Android](https://img.shields.io/badge/Android-SDK_34-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![PyTorch Mobile](https://img.shields.io/badge/PyTorch_Mobile-Lite_1.13.1-EE4C2C?style=for-the-badge&logo=pytorch&logoColor=white)
![WebRTC](https://img.shields.io/badge/WebRTC-Realtime_Comm-333333?style=for-the-badge&logo=webrtc&logoColor=white)
![Socket.io](https://img.shields.io/badge/Socket.io-Signaling-010101?style=for-the-badge&logo=socket.io&logoColor=white)

## 📌 Project Overview
**DeepVoice Shield App**은 보이스피싱 및 딥페이크 범죄를 예방하기 위한 모바일 솔루션입니다.
사용자 간의 VoIP 통화 시 **실시간으로 오디오 스트림을 분석**하거나, 녹음된 파일을 업로드하여 위변조 여부를 판별합니다.

특히, **PyTorch Mobile Lite**를 탑재하여 서버 통신 없이도(On-device) 빠르고 안전하게 딥보이스를 탐지할 수 있는 하이브리드 아키텍처를 채택했습니다.

## 🌟 Key Features

### 1. 🔍 On-device Deepfake Detection
- **PyTorch Mobile Lite (.ptl)** 모델을 앱 내부에 탑재하여 인터넷 연결 없이도 추론 가능.
- Java/Kotlin Native Module(`DeepfakeDetector`)을 통해 React Native와 고성능 통신.

### 2. 📞 Secure VoIP Calling
- **WebRTC** 기반의 고품질 음성 통화 기능 제공.
- 통화 중 실시간 오디오 버퍼를 추출하여 AI 모델에 전달.
- 딥보이스 의심 구간 감지 시 즉각적인 **경고(Warning Screen/Vibration)** 발생.

### 3. 📂 File Analysis
- 통화 녹음 파일(WAV 등) 업로드 및 분석 기능.
- 상세 분석 결과 리포트(진짜/가짜 확률, 위험도 등급) 제공.

## 🚀 System Architecture

```mermaid
graph TD
    User[Mobile User] -->|Touch/Input| RN[React Native UI]
    
    subgraph "Mobile App (Android)"
        RN -->|Bridge| Native[Native Module (Java/Kotlin)]
        Native -->|Load Model| PyTorch[PyTorch Mobile Lite]
        Native -->|Audio Stream| Mic[Microphone / WebRTC Audio]
        
        PyTorch -->|Inference Result| Native
        Native -->|Event Emitter| RN
    end
    
    subgraph "Network"
        RN -->|Socket.io / HTTP| Server[Backend Server (EC2)]
        RN -->|WebRTC P2P| Peer[Remote Peer]
    end
    
    Native -.->|Real-time Alert| User
```

## 🛠️ Tech Stack

| Category | Technology | Description |
| :--- | :--- | :--- |
| **Framework** | React Native (0.78.0) | Cross-platform mobile development |
| **Language** | JavaScript, Java, Kotlin | Hybrid development (JS + Native Modules) |
| **AI Engine** | PyTorch Android Lite | On-device AI Inference (.ptl model) |
| **Communication** | React Native WebRTC | VoIP Audio Streaming & P2P Connection |
| **Signaling** | Socket.io Client | Call signaling & Real-time events |
| **Network** | Axios | REST API Communication |
| **Storage** | Async Storage | Local data persistence |

## 📂 Directory Structure

```
android/                # Android Native Project
├── app/src/main/java/  # Native Modules (DeepfakeDetector, WebRTC wrappers)
└── app/src/main/assets # .ptl Model files
src/
├── contexts/           # Theme, Auth Contexts
├── lib/                # API Config (Axios, Socket)
├── screens/            # UI Screens
│   ├── HomeScreen.js       # Main Detection UI
│   ├── VoIPScreen.js       # Dialer & Call UI
│   ├── InCallScreen.js     # Active Call Interface
│   └── DashBoardScreen.js  # Community Board
├── services/           # Logic Layers
│   ├── PhoneService.js     # Android Permissions
│   └── useVoIPConnection.js # WebRTC Hook
└── App.js              # Entry Point & Navigation
```

## 🚀 Getting Started

### Prerequisites
- **Node.js** >= 18
- **JDK** 17 (Defined in `build.gradle`)
- **Android Studio** & SDK (API Level 34 recommended)
- **Physical Device** (Recommended for Microphone/WebRTC testing)

### 1. Installation
```bash
# Clone the repository
git clone [https://github.com/thisNorm/deepfake_detection_service_application.git](https://github.com/thisNorm/deepfake_detection_service_application.git)
cd deepfake_detection_service_application

# Install NPM dependencies
npm install
```

### 2. Environment Setup
`src/lib/config.js` 파일에서 백엔드 서버 주소를 확인하세요.
```javascript
export const API_BASE = 'http://YOUR_EC2_IP:3000';
```

### 3. Run on Android
WebRTC 및 오디오 권한 테스트를 위해 **실물 기기** 연결을 권장합니다.

```bash
# Start Metro Bundler
npm start

# Run Android App
npm run android
```

## ⚠️ Permissions
이 앱은 다음과 같은 민감한 권한을 필요로 합니다 (`AndroidManifest.xml`):

| Permission | Description |
| :--- | :--- |
| `RECORD_AUDIO` | 보이스피싱/딥보이스 탐지를 위한 오디오 데이터 접근 |
| `INTERNET` | 백엔드 서버 통신 및 WebRTC P2P 연결 |
| `READ_PHONE_STATE` | 전화 수신/발신 상태 감지 |
| `READ_MEDIA_AUDIO` | 분석할 녹음 파일 불러오기 (Android 13+) |
| `READ_EXTERNAL_STORAGE` | 분석할 녹음 파일 불러오기 (Android 12 이하) |

## 🐛 Troubleshooting

**Q. 빌드 시 `fbjni` 또는 `libc++_shared.so` 충돌이 발생합니다.**
- `android/app/build.gradle` 내의 `packagingOptions` 설정을 확인하세요. `pickFirst` 옵션이 적용되어 있어야 합니다.

**Q. 앱이 실행되자마자 종료됩니다.**
- `.ptl` 모델 파일이 `android/app/src/main/assets` 경로에 올바르게 위치해 있는지 확인하세요. PyTorch Mobile은 모델 파일을 로드하지 못하면 초기화에 실패할 수 있습니다.


## 🔗 Related Repositories
+ Backend: [deepfake_detection_service_backend](https://github.com/thisNorm/deepfake_detection_service_backend.git)

+ Frontend (Landing): [deepfake_detection_service_frontend](https://github.com/thisNorm/deepfake_detection_service_frontend.git)

+ Algorithm: [deepfake_detection_service_algorithm](https://github.com/thisNorm/deepfake_detection_service_algorithm.git)
