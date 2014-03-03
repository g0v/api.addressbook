CREATE TABLE IF NOT EXISTS organizations (
    id integer PRIMARY KEY,
    name text,
    other_names json,
    identifiers json,
    classification json,
    parent_id integer,
    founding_date date,
    dissolutions_date date,
    image text,
    contact_details json,
    links json
);