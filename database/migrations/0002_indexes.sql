create index if not exists idx_search_requests_user_id
on search_requests(user_id);

create index if not exists idx_search_requests_city
on search_requests(city);

create index if not exists idx_search_requests_state
on search_requests(state);

create index if not exists idx_businesses_cnpj
on businesses(cnpj);

create index if not exists idx_businesses_city
on businesses(city);

create index if not exists idx_businesses_state
on businesses(state);

create index if not exists idx_businesses_neighborhood
on businesses(neighborhood);

create index if not exists idx_business_locations_business_id
on business_locations(business_id);

create index if not exists idx_business_locations_place_id
on business_locations(place_id);

create index if not exists idx_business_sources_business_id
on business_sources(business_id);

create index if not exists idx_business_sources_source_type
on business_sources(source_type);

create index if not exists idx_business_contacts_business_id
on business_contacts(business_id);

create index if not exists idx_business_contacts_normalized_value
on business_contacts(normalized_value);

create index if not exists idx_business_contact_evidences_contact_id
on business_contact_evidences(business_contact_id);

create index if not exists idx_business_scores_business_id
on business_scores(business_id);

create index if not exists idx_business_scores_search_request_id
on business_scores(search_request_id);

create index if not exists idx_business_activity_signals_business_id
on business_activity_signals(business_id);

create index if not exists idx_search_results_search_request_id
on search_results(search_request_id);

create index if not exists idx_search_results_business_id
on search_results(business_id);

create index if not exists idx_sales_attempts_business_id
on sales_attempts(business_id);

create index if not exists idx_sales_attempts_user_id
on sales_attempts(user_id);

create index if not exists idx_score_feedback_events_business_id
on score_feedback_events(business_id);

create index if not exists idx_score_feedback_events_sales_attempt_id
on score_feedback_events(sales_attempt_id);
