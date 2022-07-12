Jenkins and CodeQL
=====

This repository serves as a simple example of how to configure CodeQL to run in a Jenkins pipeline.
For this exercise a singular EC2 instance was configured using Ubuntu 20.04 and the user-data.sh
shell script. This instance served as both the Jenkins master and agent, running the pipeline
defined in the Jenkinsfile against the code from the flask repo.

user-data.sh
----------

This script will set up Java as used by Jenkins, Jenkins itself, the CodeQL CLI, and Python as necessary
to run against a Python project such as flask. It will do so while logging output to /var/log/user-data.log
in the event there is an error during setup. Take note that this script does not finish running until some
time after the VM is provisioned for use. As such it is necessary to wait past the point where the VM becomes
available on AWS to actually use it.

Jenkinsfile
----------------

This Jenkinsfile defines a simple pipeline of two stages, each with one step, that executes a handful of shell
commands. The path is not configured to include /opt/codeql, and as such the full path to the binary is
specified when invoking it. It is configured to analyzise Javascript and Python code. This is done by
creating a database for each language, querying the database, and the uploading the results back to GitHub
using a personal access token. This does not need to be a PAT specifically, but simply a token with the
security_events write permission.

See also `this`_ project for a similar, if more elegant, implementation of CodeQL in Jenkins.

.. _this: https://github.com/mrparkers/spring-petclinic

Links
-----

-   CodeQL in CI: https://docs.github.com/en/enterprise-cloud@latest/code-security/code-scanning/using-codeql-code-scanning-with-your-existing-ci-system/about-codeql-code-scanning-in-your-ci-system
-   CodeQL Docs: https://codeql.github.com/docs/codeql-cli/manual/
