part of tcc;

class Predicate {
  Expression expr;
  Matcher matcher;
  Expectation expectation;

  Predicate(this.expr, this.matcher, this.expectation);

  @override
  String toString() => '${this.expr} ${this.matcher} ${this.expectation}';
}

class Expression {

  String get identity => normalize ('${this.expression}');

  String expression;

  Expression(this.expression);

  @override
  String toString() => '${this.expression}';
}

final Matcher is_ = new Matcher('is');
final Matcher isNot = new Matcher('has');
final Matcher has = new Matcher('has');

final Set<Matcher> predefinedMatchers = [is_, has].toSet();

class Matcher {
  String get type => this.runtimeType.toString();
  String get identity => normalize ('${this.type}::${this.value}');
  String value;

  Matcher(this.value);

  @override
  String toString() => '${this.value}';

  @override
  int get hashCode => this.identity.hashCode;
}

class Expectation {
  String identity;

  String value;

  Expectation(this.value);

  @override
  String toString() => '${this.value}';
}


class ConditionList extends IterableBase<Predicate> {

  List<Predicate> _conditions = [];

  @override
  Iterator get iterator => _conditions.iterator;

  factory ConditionList.empty() => new ConditionList([]);

  ConditionList (this._conditions);
}