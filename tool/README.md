Use case structuring and test generation tool
=============================================

This folder contains the three components that make up the use case structuring and test generation tool built as part og my masters thesis.
 
  - The shared model, generation and service interface code (libtcc folder).
  - The server which handles persistent storage across sessions, test generation and analysis (service folder).
  - The web client that connects to the server, makes changes to use cases and requests (re)generation of tests (client folder).

Each folder is a separate Dart project, and may be opened separately as well. However, the root folder (this folder) may be opened to get an overview of all three projects at the same time.


Opening the project
-------------------

The best way of opening the source code projects located in this folder is the Dart Editor[1]. Unfortunately, this editor has been deprecated recently - so you may run into some issues in using this.

Building
--------

See the README.md in every folder for instructions on how to build.


-------

[1] https://www.dartlang.org/tools/editor/