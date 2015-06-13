part of tcc.client.view;

/**
 * Class representing a list of use case entries.
 */
class UseCaseBlock {

  final OListElement element;

  UseCaseBlock(libtcc.UseCaseBlock block, libtcc.Definitions definitions) :
    element = new OListElement()
      ..children = block.map((libtcc.UseCaseEntry entry) =>
          _entryToLI (entry, definitions)).toList(growable: false);

  /**
   * Convenience method for converting a [libtcc.UseCaseEntry] to [LIElement]
   */
  static LIElement _entryToLI (libtcc.UseCaseEntry entry, libtcc.Definitions definitions) =>
      (new UseCaseEntry(entry, definitions)).element;
}