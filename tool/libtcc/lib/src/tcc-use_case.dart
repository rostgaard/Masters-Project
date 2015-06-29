part of libtcc.base;

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

  List<UseCaseExtension> extensions = [];

  UseCase(this.name);

  UseCase.fromMap (Map map) {

  }

  Map toJson() => {
    Key.name : name,
    Key.primaryActor : primaryActor,
    Key.description : description,
    Key.scenario : _scenario,
    Key.preconditions : preconditions,
    Key.postconditions : postconditions,
    Key.stakeholders : stakeholders,
    Key.extensions : extensions
  };


  UseCaseBlock get scenario => _scenario;
  set scenario (UseCaseBlock block) {
    _scenario = block;

    int i = 0;

    block.forEach ((UseCaseEntry e) {
      e.id = ++i;
    });
  }

  /**
   *
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


  @override
  String toString() =>
    '''
Preconditions
  $preconditions
Scenario
  $scenario
Extensions
  $extensions
Postconditions
''';
}
