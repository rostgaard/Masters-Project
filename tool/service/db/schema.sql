-------------------------------------------------------------------------------
--  System users:

CREATE TABLE users (
   id               INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   name             TEXT    NOT NULL
);

CREATE TABLE groups (
   id   INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   name TEXT    NOT NULL
);

CREATE TABLE user_groups (
   user_id  INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
   group_id INTEGER NOT NULL REFERENCES groups (id) ON UPDATE CASCADE ON DELETE CASCADE,

  PRIMARY KEY (user_id, group_id)
);

CREATE TABLE auth_identities (
   identity  TEXT    NOT NULL PRIMARY KEY,
   user_id   INTEGER NOT NULL REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE
);

-------------------------------------------------------------------------------
--  Dial-plans:

CREATE TABLE dialplan_templates (
   id       INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   template JSON    NOT NULL
);

-------------------------------------------------------------------------------
--  Domain concepts (also Actors).

CREATE TABLE concepts (
   id   INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   name TEXT    NOT NULL,
   description TEXT    NOT NULL
);

CREATE TABLE actors (
   id   INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   name TEXT    NOT NULL,
   description TEXT    NOT NULL
);

CREATE TABLE concept_roles (
   id          INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   concept_id  INTEGER REFERENCES concepts (id) ON UPDATE CASCADE ON DELETE CASCADE,
   name        TEXT    NOT NULL,
   description TEXT    NOT NULL
);

CREATE TABLE actor_roles (
   id          INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   actor_id    INTEGER REFERENCES actors (id) ON UPDATE CASCADE ON DELETE CASCADE,
   name TEXT   NOT NULL,
   description TEXT    NOT NULL
);

CREATE TABLE use_cases (
   id   INTEGER NOT NULL PRIMARY KEY, --  AUTOINCREMENT
   data JSON    NOT NULL,
   description TEXT    NOT NULL
);

-------------------------------------------------------------------------------
--  Create keys.

CREATE SEQUENCE users_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE users_id_sequence OWNED BY users.id;
ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval ('users_id_sequence'::regclass);

CREATE SEQUENCE groups_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE groups_id_sequence OWNED BY groups.id;
ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval ('groups_id_sequence'::regclass);

CREATE SEQUENCE concepts_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE concepts_id_sequence OWNED BY concepts.id;
ALTER TABLE ONLY concepts ALTER COLUMN id SET DEFAULT nextval ('concepts_id_sequence'::regclass);

CREATE SEQUENCE actors_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE actors_id_sequence OWNED BY actors.id;
ALTER TABLE ONLY actors ALTER COLUMN id SET DEFAULT nextval ('actors_id_sequence'::regclass);

CREATE SEQUENCE concept_roles_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE concept_roles_id_sequence OWNED BY concept_roles.id;
ALTER TABLE ONLY concept_roles ALTER COLUMN id SET DEFAULT nextval ('concept_roles_id_sequence'::regclass);

CREATE SEQUENCE actor_roles_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE actor_roles_id_sequence OWNED BY actor_roles.id;
ALTER TABLE ONLY actor_roles ALTER COLUMN id SET DEFAULT nextval ('actor_roles_id_sequence'::regclass);

CREATE SEQUENCE use_cases_id_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
ALTER SEQUENCE use_cases_id_sequence OWNED BY use_cases.id;
ALTER TABLE ONLY use_cases ALTER COLUMN id SET DEFAULT nextval ('use_cases_id_sequence'::regclass);


-------------------------------------------------------------------------------
--  Set ownership:

ALTER TABLE users OWNER TO tcc;
ALTER TABLE groups OWNER TO tcc;
ALTER TABLE actors OWNER TO tcc;
ALTER TABLE concepts OWNER TO tcc;
ALTER TABLE actor_roles OWNER TO tcc;
ALTER TABLE concept_roles OWNER TO tcc;
ALTER TABLE use_cases OWNER TO tcc;

ALTER SEQUENCE users_id_sequence OWNER TO tcc;
ALTER SEQUENCE groups_id_sequence OWNER TO tcc;
ALTER SEQUENCE concepts_id_sequence OWNER TO tcc;
ALTER SEQUENCE actors_id_sequence OWNER TO tcc;
ALTER SEQUENCE concept_roles_id_sequence OWNER TO tcc;
ALTER SEQUENCE actor_roles_id_sequence OWNER TO tcc;
ALTER SEQUENCE use_cases_id_sequence OWNER TO tcc;

-------------------------------------------------------------------------------
