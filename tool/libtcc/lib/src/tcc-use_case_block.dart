part of libtcc.base;

/**
 * Class representing a list of use case entries.
 */
class UseCaseBlock extends IterableBase<UseCaseEntry>{

  Iterator get iterator => _entries.iterator;

  final List<UseCaseEntry> _entries;

  factory UseCaseBlock.empty() => new UseCaseBlock([]);

  UseCaseBlock(Iterable<UseCaseEntry> entries) :
    _entries = []..addAll(entries);

  /**
   *
   */
  void append (UseCaseEntry entry) {
    _entries.add(entry);
  }

    List toJson() => _entries.map((UseCaseEntry e) => e.toJson()).toList(growable : false);
}