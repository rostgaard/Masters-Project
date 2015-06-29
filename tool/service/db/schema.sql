----------------------------------------------------------------------------
--  System users: For later login system.

CREATE TABLE users (
   id               INTEGER NOT NULL PRIMARY KEY,
   name             TEXT    NOT NULL
);

CREATE TABLE groups (
   id   INTEGER NOT NULL PRIMARY KEY,
   name TEXT    NOT NULL
);

CREATE TABLE user_groups (
   user_id  INTEGER NOT NULL REFERENCES users (id)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
   group_id INTEGER NOT NULL REFERENCES groups (id)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,

  PRIMARY KEY (user_id, group_id)
);

CREATE TABLE auth_identities (
   identity  TEXT    NOT NULL PRIMARY KEY,
   user_id   INTEGER NOT NULL REFERENCES users (id)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE
);

---------------------------------------------------------------------------
--  Domain concepts (also Actors).

CREATE TABLE concept_types (
   name TEXT NOT NULL PRIMARY KEY
);

CREATE TABLE concepts  (
   id          INTEGER NOT NULL PRIMARY KEY,
   name        TEXT    NOT NULL,
   role        TEXT    NOT NULL,
   type        TEXT    NOT NULL REFERENCES concept_types(name),
   description TEXT    NOT NULL DEFAULT '',
   UNIQUE (name, role)
);

----------------------------------------------------------------------------
--  Use cases

CREATE TABLE use_cases (
   id               INTEGER NOT NULL PRIMARY KEY,
   name             TEXT    NOT NULL UNIQUE,
   primary_role_id  INTEGER REFERENCES concepts (id),
   scenario         JSON    NOT NULL DEFAULT '[]',
   extensions       JSON    NOT NULL DEFAULT '[]',
   preconditions    JSON    NOT NULL DEFAULT '[]',
   postconditions   JSON    NOT NULL DEFAULT '[]',
   description      TEXT    NOT NULL DEFAULT ''
);

CREATE TABLE configuration (
   client JSON NOT NULL
);

CREATE TABLE templates (
   id          INTEGER NOT NULL PRIMARY KEY,
   name        TEXT    NOT NULL,
   body        TEXT    NOT NULL,
   description TEXT    NOT NULL
);

----------------------------------------------------------------------------
--  Create key sequences.

CREATE SEQUENCE users_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE users_id_sequence OWNED BY users.id;
ALTER TABLE ONLY users ALTER COLUMN id
  SET DEFAULT nextval ('users_id_sequence'::regclass);

CREATE SEQUENCE groups_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE groups_id_sequence OWNED BY groups.id;
ALTER TABLE ONLY groups ALTER COLUMN id
  SET DEFAULT nextval ('groups_id_sequence'::regclass);

CREATE SEQUENCE concepts_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE concepts_id_sequence OWNED BY concepts.id;
ALTER TABLE ONLY concepts ALTER COLUMN id
  SET DEFAULT nextval ('concepts_id_sequence'::regclass);

CREATE SEQUENCE templates_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE templates_id_sequence OWNED BY templates.id;
ALTER TABLE ONLY templates ALTER COLUMN id
  SET DEFAULT nextval ('templates_id_sequence'::regclass);

CREATE SEQUENCE use_cases_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE use_cases_id_sequence OWNED BY use_cases.id;
ALTER TABLE ONLY use_cases ALTER COLUMN id
  SET DEFAULT nextval ('use_cases_id_sequence'::regclass);

----------------------------------------------------------------------------
--  Set ownership:

ALTER TABLE users OWNER TO tcc;
ALTER TABLE groups OWNER TO tcc;
ALTER TABLE concepts OWNER TO tcc;
ALTER TABLE templates OWNER TO tcc;
ALTER TABLE use_cases OWNER TO tcc;

ALTER SEQUENCE users_id_sequence OWNER TO tcc;
ALTER SEQUENCE groups_id_sequence OWNER TO tcc;
ALTER SEQUENCE concepts_id_sequence OWNER TO tcc;
ALTER SEQUENCE templates_id_sequence OWNER TO tcc;
ALTER SEQUENCE use_cases_id_sequence OWNER TO tcc;

----------------------------------------------------------------------------
