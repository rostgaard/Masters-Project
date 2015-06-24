INSERT INTO users (id, name)
VALUES (1,  'Kim Rostgaard Christensen');

INSERT INTO groups (id, name)
VALUES (1, 'Receptionist'),
       (2, 'Administrator'),
       (3, 'Service agent');

INSERT INTO user_groups (user_id, group_id)
VALUES (1, 1),
       (1, 2),
       (1, 3);

INSERT INTO auth_identities (identity, user_id)
VALUES ('kim.rostgaard@gmail.com', 1);

INSERT INTO actors (id, name, description)
VALUES (1, 'user',
'##Basic user 
Markdown syntax is supported, and gives list items

  * For example this
  * And this

Very convenient.'),
       (2, 'admin', 'An admin user');

INSERT INTO actor_roles (id, name, description, actor_id)
VALUES (1, 'user 1', 'Basic user', 1),
       (2, 'admin 1', 'An admin user', 2);

INSERT INTO concepts (id, name, description)
VALUES (1, 'message', 'A message'),
       (2, 'call', 'A call');

INSERT INTO use_cases (name, primary_role_id, scenario, extensions, description)
VALUES ('Transfer call', 1, '[]', '[]', 'Transfer an inbound call'),
       ('Send message', 2, '[]', '[]', 'Send a message to an employee');

INSERT INTO configuration (client)
VALUES ('{"jenkinsUri":"http://localhost/jenkins"}');

-------------------

SELECT setval('users_id_sequence', (SELECT max(id)+1 FROM users), FALSE);
SELECT setval('groups_id_sequence', (SELECT max(id)+1 FROM groups), FALSE);

SELECT setval('concepts_id_sequence', (SELECT max(id)+1 FROM concepts), FALSE);
SELECT setval('actors_id_sequence', (SELECT max(id)+1 FROM actors), FALSE);
SELECT setval('use_cases_id_sequence', (SELECT max(id)+1 FROM use_cases), FALSE);

