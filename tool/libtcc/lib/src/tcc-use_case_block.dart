part of libtcc.base;

/**
 * Class representing a list of use case entries.
 */
class UseCaseBlock extends IterableBase<UseCaseEntry>{

  /// By default, every block leads to termination.
  UseCaseEntry returnsTo = UseCaseEntry.termination;

  Iterator get iterator => ([]..addAll(_entries)..add(returnsTo)).iterator;

  final List<UseCaseEntry> _entries;

  UseCaseBlock(Iterable<UseCaseEntry> entries) :
    _entries = []..addAll(entries);

}