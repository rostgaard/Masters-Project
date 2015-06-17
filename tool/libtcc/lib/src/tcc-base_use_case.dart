part of libtcc.base;

class BaseUseCase {
  String name;
  Actor primaryActor;
  String description = 'No description provided';
  String get identity => normalize(this.name);

  UseCaseBlock preconditions;
  UseCaseBlock _scenario;
  UseCaseBlock postconditions;
  List<Actor> stakeholders = [];

  UseCaseBlock get scenario => _scenario;
  set scenario (UseCaseBlock block) {
    _scenario = block;

    int i = 0;

    block.forEach ((UseCaseEntry e) {
      e.id = ++i;
    });

  }

  Iterable<UseCaseEntry> pathDownto(UseCaseEntry uce) =>
    []..addAll(_scenario.takeWhile((uce1) => uce != uce1))
      ..add(uce);

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


  Iterable<int> pathOfExtension(UseCaseExtension uce) {
    List<int> main = idsOfBlock(uce.entries);

  }

  List<List<UseCaseEntry>> get paths {
    List<List<UseCaseEntry>>  values = [];

    // First path is the happy path.
    values.add(scenario.toList());

    // Next paths are the extensions.
    Iterable<UseCaseEntry> exts = extensions.first.entries;

    // Join it in the tree
    List<UseCaseEntry> path = []..addAll(pathDownto(extensions.first.extensionOf))
                                ..addAll(exts);

    if (extensions.first.returnsTo != UseCaseEntry.termination) {

    } else {
      print ('termination detected!');
    }


    //print (pathDownto (this._scenario.first));
    //print (pathFrom (this._scenario.elementAt(2)));
    //print (this._scenario.elementAt(1));

   // print (pathFrom(this._scenario.elementAt(2)));

    print (path);

    return values;
  }



  List<UseCaseExtension> extensions;

  BaseUseCase(this.name);

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
