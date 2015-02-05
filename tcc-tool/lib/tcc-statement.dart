part of tcc;

class Statement {
  Actor  actor;
  Action action;
  Target object;

  Statement (this.actor, this.action, this.object);

  @override
  String toString () => '${this.actor} ${this.action} ${this.object}';
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
}