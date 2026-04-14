create table if not exists users (
    id uuid primary key,
    name text,
    email text unique,
    role text,
    created_at timestamptz default now()
);

create table if not exists search_requests (
    id uuid primary key default gen_random_uuid(),
    user_id uuid references users(id),
    state text not null,
    city text not null,
    neighborhood text,
    segment_query text not null,
    score_min integer not null,
    score_max integer,
    status text default 'pending',
    requested_at timestamptz default now(),
    completed_at timestamptz
);

create table if not exists businesses (
    id uuid primary key default gen_random_uuid(),
    canonical_name text,
    legal_name text,
    trade_name text,
    cnpj text,
    state text,
    city text,
    neighborhood text,
    primary_category text,
    website_url text,
    primary_phone text,
    is_active_business boolean,
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

create table if not exists business_locations (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references businesses(id) on delete cascade,
    place_id text,
    source text,
    address_full text,
    state text,
    city text,
    neighborhood text,
    postal_code text,
    lat numeric,
    lng numeric,
    maps_url text,
    is_primary_location boolean default false,
    last_refreshed_at timestamptz
);

create table if not exists business_sources (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references businesses(id) on delete cascade,
    source_type text not null,
    source_reference text,
    raw_payload jsonb,
    found_at timestamptz default now(),
    confidence_score numeric
);

create table if not exists business_contacts (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references businesses(id) on delete cascade,
    contact_type text not null,
    normalized_value text not null,
    display_value text,
    is_primary boolean default false,
    sources_count integer default 1,
    confidence_score numeric,
    has_whatsapp_signal boolean default false,
    last_seen_at timestamptz
);

create table if not exists business_contact_evidences (
    id uuid primary key default gen_random_uuid(),
    business_contact_id uuid not null references business_contacts(id) on delete cascade,
    source_type text not null,
    source_reference text,
    raw_value text,
    found_at timestamptz default now()
);

create table if not exists business_scores (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references businesses(id) on delete cascade,
    search_request_id uuid references search_requests(id) on delete cascade,
    score_total integer,
    priority_band text,
    structure_score integer,
    presence_score integer,
    consistency_score integer,
    contact_score integer,
    recency_score integer,
    social_score integer,
    score_reason_summary text,
    calculated_at timestamptz default now()
);

create table if not exists business_activity_signals (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references businesses(id) on delete cascade,
    signal_type text not null,
    signal_value text,
    signal_date timestamptz,
    source_type text,
    confidence_score numeric
);

create table if not exists search_results (
    id uuid primary key default gen_random_uuid(),
    search_request_id uuid not null references search_requests(id) on delete cascade,
    business_id uuid not null references businesses(id) on delete cascade,
    score_total integer,
    priority_band text,
    position_rank integer,
    included_in_results boolean default true,
    created_at timestamptz default now()
);

create table if not exists sales_attempts (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references businesses(id) on delete cascade,
    user_id uuid references users(id),
    attempted_at timestamptz default now(),
    contact_used text,
    attempt_result text,
    decision_maker_reached boolean,
    whatsapp_confirmed boolean,
    notes text
);

create table if not exists score_feedback_events (
    id uuid primary key default gen_random_uuid(),
    business_id uuid not null references businesses(id) on delete cascade,
    sales_attempt_id uuid references sales_attempts(id) on delete cascade,
    feedback_type text not null,
    feedback_weight numeric,
    created_at timestamptz default now()
);
