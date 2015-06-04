part of libtcc.base;

class Predicate {
  Expression expr;
  Matcher matcher;
  Expectation expectation;

  Predicate(this.expr, this.matcher, this.expectation);

  @override
  String toString() => '${this.expr} ${this.matcher} ${this.expectation}';

  Map toJson() => {
    Key.expression : expr,
    Key.matcher : matcher,
    Key.expectation : expectation
  };

}

class Expression {

  String get identity => normalize ('${this.expression}');

  String expression;

  Expression(this.expression);

  @override
  String toString() => '${this.expression}';

  Map toJson() => {
    Key.identity : identity,
    Key.expression : expression,
  };
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

  Map toJson() => {
    Key.identity : identity,
    Key.type : type,
    Key.value : value
  };
}

class Expectation {
  String identity;

  String value;

  Expectation(this.value);

  @override
  String toString() => '${this.value}';

  Map toJson() => {
    Key.identity : identity,
    Key.value : value
  };
}


class ConditionList extends IterableBase<Predicate> {

  List<Predicate> _conditions = [];

  @override
  Iterator get iterator => _conditions.iterator;

  factory ConditionList.empty() => new ConditionList([]);

  ConditionList (this._conditions);
}