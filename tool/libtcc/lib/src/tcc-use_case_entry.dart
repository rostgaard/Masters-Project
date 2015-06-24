part of libtcc.base;

/**
 * Class representing a single use case entry.
 */
class UseCaseEntry {

  int id;
  static const int noID = -1;
  String text = 'undefined';

  static final UseCaseEntry termination =
      new UseCaseEntry('termination')..id = noID;

  UseCaseEntry (this.text);

  operator == (UseCaseEntry other) => this.id == other.id;

  @override
  String toString() => '$id. $text';

  Map toJson() => {
    Key.id : id,
    Key.value : text
  };
}