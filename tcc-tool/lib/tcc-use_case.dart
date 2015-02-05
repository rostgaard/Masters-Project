part of tcc;

class UseCase {
  String        name;
  ConditionList _preconditions = new ConditionList.empty();
  StatementList _statements;
  ConditionList _postconditions = new ConditionList.empty();

  UseCase (this.name, this._preconditions, this._statements, this._postconditions);

  @override
  String toString () =>
      'Preconditions:' ' ${this._preconditions} \n'
      'Use case:'      ' ${this._statements} \n'
      'Postconditions:'' ${this._postconditions}';


  Set<Declaration> get declarations =>
    this._statements.map((Statement stmt) => new Declaration.fromStatement(stmt)).toSet();

  Set<Actor> get involvedActors => (this._statements.map((Statement stmt) => stmt.actor)).toSet();
}
