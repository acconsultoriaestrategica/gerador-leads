insert into users (id, name, email, role)
values
    ('11111111-1111-1111-1111-111111111111', 'Usuário Exemplo', 'exemplo@acconsultoria.com', 'admin')
on conflict (email) do nothing;
