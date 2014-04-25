export meta = do
  'pgrest.memberships': do
    as: 'public.memberships'   
  'pgrest.organizations': do
    as: 'public.organizations'
    columns:
      '*': {}
      memberships: do
        $from: 'pgrest.memberships'
        $query: 'organization_id': $literal: 'organizations.id'
        columns:
          '*': <[id role label start_date end_date]>
      organizations: do
        $from: 'public.organizations as sub'
        $query: 'sub.parent_id': $literal: 'organizations.id'
        columns:
          '*': <[id name]>
  'pgrest.person': do
    as: 'public.person'
    columns:
      '*': {}
      memberships:
        $from: 'pgrest.memberships'
        $query: 'person_id': $literal: 'person.id'
        columns:
          '*': <[id role label start_date end_date]>