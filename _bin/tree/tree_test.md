└─ src
  ├─ public # favicon, manifest, fonts, images, svgs
  │ ├─ fonts # 폰트 woff, woff2 / otf, ttf
  │ ├─ images # jpg, png
  │ └─ svgs # svg, index.ts(svg component export)
  ├─ app # app source, routing용 파일(page.tsx import from containers)
  ├─ components # UI component
  ├─ constants # 공통 사용 상수
  ├─ containers # tsx, css, state, hooks
  ├─ hooks # 공통 훅
  ├─ libs # 외부 라이브러리
  │ └─ isotope-layout
  ├─ services # API 요청, apiBe, apiFe, auth.ts, ...
  ├─ states # 전역 상태관리
  ├─ styles # 스타일 시트 관련 공통 요소 (globals.scss, levels.scss, variable.scss, animations.scss, reset.scss, base.module.scss, mixins)
  ├─ types # typescript 정의 파일
  └─ utils # 유틸성 함수