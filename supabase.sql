-- Estado compartilhado das marcações do leilão
create table if not exists public.verificacoes_leilao (
  patrimonio text primary key,
  verificado boolean not null default false,
  atualizado_em timestamptz not null default now()
);

alter table public.verificacoes_leilao enable row level security;

-- GitHub Pages usa a chave publicável no navegador.
-- Para este caso, qualquer visitante do site pode ler e alterar o status.
create policy "leilao leitura publica"
on public.verificacoes_leilao
for select
to anon
using (true);

create policy "leilao insercao publica"
on public.verificacoes_leilao
for insert
to anon
with check (true);

create policy "leilao atualizacao publica"
on public.verificacoes_leilao
for update
to anon
using (true)
with check (true);

grant select, insert, update on table public.verificacoes_leilao to anon;
