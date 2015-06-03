part of tcc;

class Statement {
  String get identity => normalize ('${this.actor}::${this.action}::${this.object}');
  Actor  actor;
  Action action;
  Target object;

  Statement (this.actor, this.action, this.object);

  @override
  String toString () => '${this.actor.role} ${this.action} ${this.object}';

  Map toJson () => {
    Key.identity : identity,
    Key.actor : actor,
    Key.action : action,
    Key.target : object
  };
}

class StatementList extends IterableBase<Statement> {
  List<Statement> _statements = [];

  @override
  Iterator get iterator => _statements.iterator;

  StatementList (this._statements);

  StatementList.empty();

  @override
  String toString () =>
      this._statements.map((Statement stmt) => '${stmt}').join('\n');

  List toJson() => _statements;
}