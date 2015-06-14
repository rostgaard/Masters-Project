part of libtcc.base;

class BaseUseCase {
  String name;
  Actor primaryActor;
  String description = 'No description provided';
  String get identity => normalize(this.name);

  List<UseCaseBlock> preconditions = [];
  List<UseCaseBlock> scenario = [];
  List<UseCaseBlock> postconditions = [];
  List<Actor> stakeholders = [];

  List<UseCaseExtension> extensions;

  BaseUseCase(this.name);

}
