# Third Party Packages

This set of jenkins jobs build binaries for VFX Platform packages that are required to build ASWF packages.

All builds are based on a minimal VFX Platform compliant docker image.

## Package Layout

The layout of installed packages looks like this:
```
/opt/aswf/
`-- vfx2018
    |-- boost
    |   |-- include
    |   `-- lib
    |-- ilmbase
    |   |-- include
    |   `-- lib
    |-- openexr
    |   |-- bin
    |   |-- include
    |   |-- lib
    |   `-- share
    |-- pyilmbase
    |   |-- include
    |   |-- lib
    |   |-- lib64
    |   `-- share
    `-- tbb
        |-- include
        `-- lib
```
When building or using these packages the `LD_LIBRARY_PATH` and `PYTHONPATH` environment variables must be set accordingly, see the `all/Dockerfile` file for an example.

## Jenkins Jobs

All jobs are named 3rdparty-X-vfx2018 where X is a third-party package for which we need binaries available.

Use the regular `jenkins-jobs update jjb/` script to upload the jobs to the jenkins sandbox.


## Local testing

In order to test these docker builds locally the `build_local.py` script can be used to build all 3rdparty packages in the right order
and with the right dependencies, the only requirement is a linux machine with docker installed.

When running locally, an extra docker image is built called `all` that brings in all previously built packages. This allows local inspection of 
the built artifacts in a working environment and easier debugging.
To inspect the all-builder image run this `docker run -it --rm --entrypoint bash all-builder`.
