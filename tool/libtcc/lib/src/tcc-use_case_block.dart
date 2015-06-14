part of libtcc.base;

/**
 * Class representing a list of use case entries.
 */
class UseCaseBlock extends IterableBase<UseCaseEntry>{

  Iterator get iterator => _entries.iterator;

  final List<UseCaseEntry> _entries;

  UseCaseBlock(Iterable<UseCaseEntry> entries) :
    _entries = []..addAll(entries);

}