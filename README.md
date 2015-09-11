# general Makefile template

The proposed Makefile is a general and easy template that will be enough for small and medium projects. Specifically it:

Compiles all files inside in the same directory as the Makefile.
Auto generates and keep updated dependencies among all files (#include).
Keeps object and dependency files in separate directories.
Gives the infrastructure to customize a building process by defining compilation-time variables.
