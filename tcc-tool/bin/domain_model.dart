library domain_model;

class Message {}

class Receptionist {
  void send(Message m) {
    throw new UnimplementedError();
  }

  void save(Message m) {
    throw new UnimplementedError();
  }

  void retrieve(Message m) {
    throw new UnimplementedError();
  }
}

abstract class ReceptionistPool {
  static Receptionist aquire() {
    return new Receptionist();
  }
}