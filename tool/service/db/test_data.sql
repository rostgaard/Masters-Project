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

INSERT INTO concept_types (name)
VALUES ('concept'),
       ('actor');

INSERT INTO concepts (type, role, name, description)
VALUES ('actor', 'user', 'User',
'##Basic user
Markdown syntax is supported, and gives list items

  * For example this
  * And this

Very convenient.'),
       ('actor', 'admin', 'Admin', 'An admin user');

INSERT INTO concepts (type, name, role, description)
VALUES ('concept', 'message', 'Message', 'A message'),
       ('concept', 'Call', 'call', 'A call');


INSERT INTO use_cases (name, primary_role_id, scenario, extensions, description)
VALUES ('Transfer call', 1, '[{"id":1,"value":"Receptionist picks up call"},{"id":2,"value":"Receptionist gives greeting"},{"id":3,"value":"Receptionist looks up employee"},{"id":4,"value":"Receptionist select specific employee"},{"id":5,"value":"Receptionist dials contact"},{"id":6,"value":"Receptionist initiates transfer"}]', '[{"extensionOf":{"id":3,"value":"Receptionist looks up employee"},"returnsTo":{"id":5,"value":"Receptionist dials contact"},"entries":[{"id":1,"value":"Receptionist searches for employee"}]},{"extensionOf":{"id":3,"value":"Receptionist looks up employee"},"returnsTo":{"id":3,"value":"Receptionist looks up employee"},"entries":[{"id":1,"value":"Receptionist searches for employee"}]}]', 'Transfer an inbound call'),
       ('Send message', 2, '[]', '[]', 'Send a message to an employee');

INSERT INTO configuration (client)
VALUES ('{"jenkinsUri":"http://localhost/jenkins",
          "testLocation" : "/home/krc/tests/",
          "analyzerLocation" : "/home/krc/lib/dart/dart-sdk/bin/dartanalyzer"}');

INSERT INTO templates (name, description, body)
VALUES ('Call transfer template', 'A simple test template for send message use case',
'import "dart:async";
import "package:logging/logging.dart";

import "test_support.dart";

DateTime _startTime = null;
int _nextStep = 1;
Customer caller = null;
MessageStore messageStore = null;
ContactStore contactStore = null;
ReceptionStore receptionStore = null;

Logger log = new Logger("UseCase.TransferCall");

Future setup() {
  _startTime = new DateTime.now();
  _nextStep = 1;

  log.finest("Setting up preconditions...");

  log.finest("Setting up a MessageStore...");
  messageStore = new MessageStore();

  log.finest("Setting up a ReceptionStore...");
  receptionStore = new ReceptionStore();

  log.finest("Send message test case: Preconditions set up.");

  return new Future.value(null);
}

void teardown() {
  log.finest("Cleaning up after test...");
}

void receptionist_picks_up_call(Call c, Receptionist r) {
  r.pickup(c);
}

void receptionist_gives_greeting(Receptionist receptionist) {
  log.finest("Receptionist gives greeting");
}

void receptionist_looks_up_employee(Receptionist receptionist) {
  log.finest("receptionist_looks_up_employee");
}

void receptionist_select_specific_employee(Receptionist receptionist) {
  log.finest("receptionist_select_specific_employee");
}

void receptionist_dials_contact(Receptionist receptionist) {
  log.finest("receptionist_dials_contact");
}

void receptionist_initiates_transfer(Receptionist receptionist) {
  log.finest("receptionist_initiates_transfer");
}

  /*[@USECASES@]*/

');

-------------------

SELECT setval('users_id_sequence', (SELECT max(id)+1 FROM users), FALSE);
SELECT setval('groups_id_sequence', (SELECT max(id)+1 FROM groups), FALSE);

SELECT setval('concepts_id_sequence', (SELECT max(id)+1 FROM concepts), FALSE);
SELECT setval('templates_id_sequence', (SELECT max(id)+1 FROM templates), FALSE);
SELECT setval('use_cases_id_sequence', (SELECT max(id)+1 FROM use_cases), FALSE);

