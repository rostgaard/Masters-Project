part of libtcc.base;

/**
 * Class representing a use case.
 */
class UseCase {
  int id;
  String name;
  Actor primaryActor;
  String description = 'No description provided';
  String get identity => normalize(this.name);

  UseCaseBlock preconditions = new UseCaseBlock.empty();
  UseCaseBlock _scenario = new UseCaseBlock.empty();
  UseCaseBlock postconditions = new UseCaseBlock.empty();
  List<Actor> stakeholders = [];

  /// The extensions of the use case.
  List<UseCaseExtension> extensions = [];

  UseCaseBlock get scenario => _scenario;
  set scenario (UseCaseBlock block) {
    _scenario = block;

    int i = 0;

    block.forEach ((UseCaseEntry e) {
      e.id = ++i;
    });
  }

  /**
   * Default constructor.
   */
  UseCase(this.name);

  /**
   * Default deserializing constructor.
   */
  UseCase.fromMap (Map map) {
    Iterable<UseCaseEntry> mappedPreconditions =
        (map[Key.preconditions] as Iterable).map(UseCaseEntry.decode);

    Iterable<UseCaseEntry> mappedPostconditions =
        (map[Key.postconditions] as Iterable).map(UseCaseEntry.decode);

    Iterable<UseCaseEntry> mappedScenario =
        (map[Key.scenario] as Iterable).map(UseCaseEntry.decode);

    id = map[Key.id];
    name = map[Key.name];
    primaryActor = new Actor.fromMap(map[Key.primaryActor]);
    description = map[Key.description];
    preconditions = new UseCaseBlock(mappedPreconditions);
    postconditions = new UseCaseBlock(mappedPostconditions);
   _scenario = new UseCaseBlock(mappedScenario);

  }

  /**
   * Serialization function.
   */
  Map toJson() => {
    Key.id : id,
    Key.name : name,
    Key.primaryActor : primaryActor,
    Key.description : description,
    Key.scenario : _scenario,
    Key.preconditions : preconditions,
    Key.postconditions : postconditions,
    Key.stakeholders : stakeholders,
    Key.extensions : extensions
  };

  /**
   * Decoder factory.
   */
  static decode (Map map) => new UseCase.fromMap(map);

  /**
   * Returns the entries that lead down to the node [uce].
   */
  Iterable<UseCaseEntry> pathDownto(UseCaseEntry uce) =>
    []..addAll(_scenario.takeWhile((uce1) => uce != uce1))
      ..add(uce);

  /**
   *
   */
  Iterable<UseCaseEntry> pathFrom(UseCaseEntry uce) {
    List<UseCaseEntry> remaining = [];
    bool found = false;

    _scenario.forEach((e) {
       if (e == uce) {
         found = true;
       }

       if (found) {
         remaining.add(e);
       }
    });

    return remaining;
  }


  /**
   * Retrive the path of an extension.
   */
  Iterable<UseCaseEntry> pathOfExtension(UseCaseExtension uce) {
    // Join it in the tree
    List<UseCaseEntry> path = []..addAll(pathDownto(uce.extensionOf))
                                ..addAll(uce.entries);

    if (uce.returnsTo != UseCaseEntry.termination) {
      path.addAll(pathFrom(uce.returnsTo));
    }

    return path;
  }

  /**
   * Retrieve every path of a use case - with extensions.
   */
  List<List<UseCaseEntry>> get paths {
    List<List<UseCaseEntry>>  values = [];

    // First path is the happy path.
    values.add(scenario.toList());

    // Next paths are the extensions.

    extensions.forEach((UseCaseExtension uce) {
      values.add(pathOfExtension(uce));
    });

    return values;
  }

  /**
   * Retrive a list of all extensions that includes loops.
   */
  List<UseCaseExtension> get loops {
    List<UseCaseExtension>  values = [];

    extensions.forEach((UseCaseExtension uce) {

      if (uce.returnsTo != UseCaseEntry.termination) {
        List<UseCaseEntry> tailPath = pathFrom(uce.returnsTo);
        if (tailPath.contains(uce.extensionOf)) {
          values.add(uce);
        }
      }
    });

    return values;
  }

  /**
   * Basic string representation. Mostly for debug purposes.
   */
  @override
  String toString() =>
    'Preconditions: $preconditions \n'
    'Scenario: $scenario \n'
    'Extensions: $extensions \n'
    'Postconditions: $postconditions';
}
