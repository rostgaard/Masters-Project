Use case structuring and test generation client
===============================================

This folder contains the web client which serves as the user interface for the use case structuring and test generation tool.

Building
--------

This application may be pre-compiled before running. But before being able to do either, the `pub` tool needs to resolve and download dependencies for the application. Open a terminal and run:

`pub get`

Once the packages have been downloaded, the application may be built and served from a web server by running

`pub build`

This will produce a `build` folder which may be served from the web server. The only requirement to this webserver is that it needs to able to serve files from the filesystem.

Running
-------

The application may also be served directly via the `pub` tool. Run the following from a terminal:

`pub serve`

And an output similar to the following will appear.

```
Loading source assets... 
Serving tcc_web web on http://localhost:8080
Build completed successfully
```

Now you can open up a browser and navigate it to ` http://localhost:8080` to use the application. The first time accessing the page will be quite slow (30-60s) , as it needs to compile all the sources before starting.