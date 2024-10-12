└─ src
  ├─ app # app source, routing용 파일(page.tsx import from containers)
  │ ├─ assets # 폰트, 이미지, svg
  │ │ ├─ fonts # 폰트 woff, woff2 / otf, ttf
  │ │ ├─ images # jpg, png
  │ │ └─ svgs # svg, index.ts(svg component export)
  │ ├─ (auth) # 회원 인증 관련 페이지
  │ ├─ (page) # 일반 페이지
  │ ├─ (admin) # 관리자 페이지
  │ ├─ (markdown) # markdown 페이지
  │ └─ (post) # 포스팅 페이지
  ├─ components # UI component
  ├─ constants # 공통 사용 상수
  ├─ containers # section 단위 tsx, css, state, hooks
  ├─ hooks # 공통 훅
  ├─ libs # 외부 라이브러리
  ├─ service # API 요청, apiBe, apiFe, auth.ts, ...
  ├─ store # 전역 상태관리
  ├─ styles # 스타일 시트 관련 공통 요소 (globals.scss, levels.scss, variable.scss, animations.scss, reset.scss, base.module.scss, mixins)
  ├─ types # typescript 정의 파일
  └─ utils # 유틸성 함수