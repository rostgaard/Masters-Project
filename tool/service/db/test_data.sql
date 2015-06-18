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

INSERT INTO actors (name, description)
VALUES ('user', 'Basic user'),
       ('admin', 'An admin user');

INSERT INTO actor_roles (name, description)
VALUES ('user', 'Basic user'),
       ('admin', 'An admin user');

-------------------

SELECT setval('users_id_sequence', (SELECT max(id)+1 FROM users), FALSE);
SELECT setval('groups_id_sequence', (SELECT max(id)+1 FROM groups), FALSE);

SELECT setval('concepts_id_sequence', (SELECT max(id)+1 FROM concepts), FALSE);
SELECT setval('actors_id_sequence', (SELECT max(id)+1 FROM actors), FALSE);
SELECT setval('use_cases_id_sequence', (SELECT max(id)+1 FROM use_cases), FALSE);

