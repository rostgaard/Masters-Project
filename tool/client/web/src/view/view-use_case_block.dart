part of tcc.client.view;

/**
 * Class representing a list of use case entries.
 */
class UseCaseBlock {

  final DivElement element = new DivElement();
  OListElement _blockList;

  /// Stream for external use.
  StreamController<libtcc.UseCaseBlock> _blockChange = new StreamController<libtcc.UseCaseBlock>();
  Stream<libtcc.UseCaseBlock> get onBlockChange => _blockChange.stream;


  /**
   * Default constructor.
   */
  UseCaseBlock(libtcc.UseCaseBlock block, libtcc.Definitions definitions) {
    _blockList = new OListElement()
      ..children = block.map((libtcc.UseCaseEntry entry) =>
          _entryToLI (entry, definitions)).toList(growable: false);

    element.children = [_blockList, _addEntryField(block, definitions)];
  }

  /**
   * Convenience method for converting a [libtcc.UseCaseEntry] to [LIElement]
   */
  LIElement _entryToLI (libtcc.UseCaseEntry entry, libtcc.Definitions definitions) {
    UseCaseEntry view = new UseCaseEntry(entry, definitions)
        ..onEntryChange.listen((_) => _blockChange.add(harvestBlock()));

    return view.element;
  }


  /**
   * Convenience method for an element that adds a new entry.
   */
  DivElement _addEntryField (libtcc.UseCaseBlock block, libtcc.Definitions definitions) {
    DivElement body = new DivElement();
    ButtonElement addButton = new ButtonElement()..text = 'Add';
    InputElement input = new InputElement(type: 'text')..placeholder =
        'Use case entry';

    addButton.onClick.listen((_) {
      libtcc.UseCaseEntry entry = new libtcc.UseCaseEntry(input.value);
      block.append(entry);
      _blockList.append(_entryToLI (entry, definitions));

      _blockChange.add(harvestBlock());
    });

    body.children.addAll([input, addButton]);

    return body;
  }

  /**
   * TODO: Enumerate the nodes.
   */
  libtcc.UseCaseBlock harvestBlock() {

    return new libtcc.UseCaseBlock([]);
  }

}