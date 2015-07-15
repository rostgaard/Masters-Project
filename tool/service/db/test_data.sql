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
       ('concept', 'call', 'Call', 'A call');

INSERT INTO use_cases (name, primary_role_id, scenario, extensions, description)
VALUES ('Transfer call', 1, '[{"id" : 1, "value" : "User does something."}]', '[]', 'Transfer an inbound call'),
       ('Send message', 2, '[]', '[]', 'Send a message to an employee');

INSERT INTO configuration (client)
VALUES ('{"jenkinsUri":"http://localhost/jenkins"}');

INSERT INTO templates (name, description, body)
VALUES ('Send message template', 'A simple test template for send message use case',
'part of or_test_fw;

abstract class SendMessage {

  static DateTime startTime = null;
  static int nextStep = 1;
  static Customer caller = null;
  static Receptionist receptionist = null;
  static Storage.Message messageStore = null;
  static Storage.Contact contactStore = null;

  static Logger log = new Logger("$libraryName.UseCase.SendMessage");

  static Future setup() {
    startTime = new DateTime.now();
    nextStep = 1;

    log.finest("Setting up preconditions...");

    log.finest ("Setting up a MessageStore...");
    messageStore = new Service.RESTMessageStore(
        Config.messageStoreUri,
        receptionist.authToken,
        new Transport.Client());

    log.finest ("Setting up a ReceptionStore...");
    contactStore= new Service.RESTContactStore(
        Config.contactStoreUri,
        receptionist.authToken,
        new Transport.Client());

    log.finest ("Send message test case: Preconditions set up.");

    return new Future.value (null);
  }

  static void teardown() {
    log.finest("Cleaning up after test...");
  }

  static Future Receptionist_Send_Message () {
    step ("Receptionist sends a message...");
    Model.Message message = new Model.Message.stub(Model.Message.noID);
    return contactStore.getByReception(4, 1).then((Model.Contact contact) {
      message.recipients = contact.distributionList;
      message.body = "Sent from test framework.";
      message.sender = receptionist.user;
   }).then((_) {
      return messageStore.enqueue(message);
   }).then((_) {
      step ("Receptionist has sent message.");
   });
  }

  static Future Callee_Checks_For_Message () {
    step ("Callee checks for message...");
    log.severe("Assuming the message is delivered, as we do not have built "
        "access to IMAP stores yet);
    return new Future.value(null);
  }

  /*[@USECASES@]*/

}');

-------------------

SELECT setval('users_id_sequence', (SELECT max(id)+1 FROM users), FALSE);
SELECT setval('groups_id_sequence', (SELECT max(id)+1 FROM groups), FALSE);

SELECT setval('concepts_id_sequence', (SELECT max(id)+1 FROM concepts), FALSE);
SELECT setval('templates_id_sequence', (SELECT max(id)+1 FROM templates), FALSE);
SELECT setval('use_cases_id_sequence', (SELECT max(id)+1 FROM use_cases), FALSE);

