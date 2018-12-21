# Third Party Packages

This set of jenkins jobs build binaries for VFX Platform packages that are required to build ASWF packages.

All builds are based on a minimal VFX Platform compliant docker image.


### Jenkins Jobs

All jobs are named 3rdparty-X-vfx2018 where X is a third-party package for which we need binaries available.

Use the regular `jenkins-jobs update jjb/` script to upload the jobs to the jenkins sandbox.


### Local testing

In order to test these docker builds locally the `build_local.py` script can be used to build all 3rdparty packages in the right order
and with the right dependencies, the only requirement is a linux machine with docker installed.
