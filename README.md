# 파도가 밀려올 때 — 떠나지 못한 감정들에 대하여

관객이 남긴 마음이 파도 위의 점이 되어 쌓이는 참여형 아카이브 사이트입니다.

- `index.html` — 사이트 전체 (디자인, 파도 그래프, 입력창)
- `config.js` — Supabase 연결 정보
- `supabase/schema.sql` — 글 저장용 테이블과 접근 규칙

## 처음 한 번 설정

1. **Supabase**: https://supabase.com 에서 새 프로젝트를 만듭니다.
2. **SQL Editor**에 `supabase/schema.sql` 내용을 붙여넣고 Run 합니다.
3. **Project Settings → API**에서 `Project URL`과 `anon public` 키를 복사해 `config.js`에 넣습니다.
4. **GitHub 저장소 → Settings → Pages**에서 Source를 `Deploy from a branch`, Branch를 `main` / `/(root)`로 저장합니다.
5. 1~2분 뒤 `https://eumin26.github.io/theatre-wave/` 에서 사이트가 열립니다.

## 운영

- 부적절한 글 지우기: Supabase 대시보드 → Table Editor → `waves` → 해당 행 삭제. 사이트에서 바로 사라집니다.
- 저장되는 정보는 글 내용과 순번뿐입니다. 날짜·시각, 이름, 기기 정보는 저장하지 않습니다.
