part of tcc;

class Condition {
  Statement statement;
}

class ConditionList extends IterableBase<Condition> {

  List<Condition> _conditions = [];

  @override
  Iterator get iterator => _conditions.iterator;

  factory ConditionList.empty() => new ConditionList([]);

  ConditionList (this._conditions);
}