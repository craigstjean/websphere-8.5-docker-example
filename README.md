websphere-8.5-docker-example
=================

What is this?
-----

**Goals:**

* Run WebSphere 8.5 for Developers in Docker
* Automated data source creation
* Automated project build, test, and packaging
* Automated application installation

**Decisions:**

* Use Maven for simplicity, however Ant, Gradle, etc. will work
* Assume a local Nexus Repository Manager is running to prevent hitting Maven Central too hard
* Build within the container to build in our "production" environment
* Demonstrate how to setup datasources, but leave commented out to make the example easier to run
* Demonstrate datasources with Oracle (make sure to copy ojdbc6.jar into docker-helpers)

How-To
-----

**Build Process:**

```
docker build -t craigstjean/hellowebsphere .
```

**Initial Run Process:**

```
docker run --name dev-hellowebsphere -h dev-hellowebsphere -p 9043:9043 -p 9443:9443 -p 9080:9080 -d craigstjean/hellowebsphere

docker logs -f dev-hellowebsphere
```

**Stop Process:**

```
docker stop dev-hellowebsphere
```

**Start Process:**

```
docker start dev-hellowebsphere
```

**Cleanup:**

```
docker rm $(docker ps -a -q)
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
```

