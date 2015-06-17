part of libtcc.base;

/**
 * Class representing a list of use case entries.
 */
class UseCaseExtension {

  final UseCaseEntry extensionOf;

  /// By default, every block leads to termination.
  UseCaseEntry returnsTo = UseCaseEntry.termination;

  Iterator get iterator => ([]..addAll(entries)..add(returnsTo)).iterator;

  final UseCaseBlock entries;

  UseCaseExtension(this.extensionOf, Iterable<UseCaseEntry> scenario) :
    entries = new UseCaseBlock(scenario) {

    int i = 0;

    entries.forEach ((UseCaseEntry e) {
      e.id = ++i;
    });
  }

  @override
  String toString() =>
'''
extends : $extensionOf

${entries.map((var uce) => '${extensionOf.id}.$uce').join('\n')}
''';

}