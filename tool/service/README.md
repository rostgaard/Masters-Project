Use case structuring and test generation service
================================================

This folder contains the server that provides persistent storage and test generation service to web clients. It exposes a REST interface which is documented in the thesis that the service is created in the context of.


Prerequisites
-------------

This service requires a few additional components to be able to run.

  - PostgreSQL 9.3+
  - Dart SDK 1.10+

Additionally, a the PostgreSQL server needs to be configured with a new database and user. The `makefile.setup.dist` file provides makefile variables that enables the makefile rule `install_latest_db`, provided that a corresponding `.pgpass` file has been setup prior. The file `lib/config.dart` defines the database connection parameters, and may be changed to suit your deployment.

Building & dependencies
--------

Dart is an interpreted just-in-time compiled language, so there is no build step. We do need to download additional dependencies. This is done by the `pub` package management tool by running the command:

`pub get`

The `pub` tool will resolve remote dependencies and prepare the project for running.

Running
-------

Make sure that the Dart SDK is installed and located in your path. Open a terminal, navigate to the root of the `service` folder (where this file is also located), and run:

`dart bin/service.dart`

At this point you should see an output similar to this:

```
[FINE] tcctool.router: Serving interfaces:
[FINE] tcctool.router: GET	->	/actor
[FINE] tcctool.router: GET	->	/actor/{id}
[FINE] tcctool.router: PUT	->	/actor/{id}
[FINE] tcctool.router: POST	->	/actor
[FINE] tcctool.router: DELETE	->	/actor/{id}
[FINE] tcctool.router: GET	->	/concept
[FINE] tcctool.router: GET	->	/concept/{id}
[FINE] tcctool.router: PUT	->	/concept/{id}
[FINE] tcctool.router: POST	->	/concept
[FINE] tcctool.router: DELETE	->	/concept/{id}
[FINE] tcctool.router: GET	->	/template
[FINE] tcctool.router: POST	->	/template
[FINE] tcctool.router: GET	->	/template/{tplid}
[FINE] tcctool.router: PUT	->	/template/{tplid}
[FINE] tcctool.router: GET	->	/usecase
[FINE] tcctool.router: GET	->	/usecase/{id}
[FINE] tcctool.router: PUT	->	/usecase/{id}
[FINE] tcctool.router: POST	->	/usecase
[FINE] tcctool.router: DELETE	->	/usecase/{id}
[FINE] tcctool.router: GET	->	/usecase/{id}/generate/{tplid}
[FINE] tcctool.router: POST	->	/test/{tid}/analyze
[FINE] tcctool.router: GET	->	/configuration
[FINE] tcctool.router: PUT	->	/configuration
```

This means that the service is up and running. By default, it listens on port 7777 on all interfaces.

When the server is running, the client may be built and started up.

