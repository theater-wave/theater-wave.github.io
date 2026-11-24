-- 「파도가 밀려올 때」 관객 마음 저장소
-- Supabase 대시보드 > SQL Editor 에 붙여넣고 Run 하세요. (한 번만)

create table if not exists public.waves (
  id   uuid primary key default gen_random_uuid(),
  seq  bigint generated always as identity,          -- 남겨진 순서 (날짜·시각은 저장하지 않음)
  text text not null check (char_length(btrim(text)) between 1 and 300)
);

alter table public.waves enable row level security;

-- 새 프로젝트는 표를 외부(Data API)에 자동으로 열어주지 않으므로 직접 허용
grant usage on schema public to anon, authenticated;
grant select, insert on table public.waves to anon, authenticated;

-- 누구나(로그인 없이) 읽기
drop policy if exists "waves are readable by everyone" on public.waves;
create policy "waves are readable by everyone"
  on public.waves for select
  to anon, authenticated
  using (true);

-- 누구나 새 글 남기기 (수정·삭제는 불가 — 삭제는 대시보드에서 운영자만)
drop policy if exists "anyone can leave a wave" on public.waves;
create policy "anyone can leave a wave"
  on public.waves for insert
  to anon, authenticated
  with check (char_length(btrim(text)) between 1 and 300);

-- 다른 관객의 글이 새로고침 없이 바로 보이도록 실시간 전송 켜기
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'waves'
  ) then
    alter publication supabase_realtime add table public.waves;
  end if;
end $$;
