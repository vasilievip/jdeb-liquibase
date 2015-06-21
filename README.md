### Example demonstrating how to build ".deb" package from java program which will update and rollback db schema via liquibase.

#### External reading:

* http://askubuntu.com/a/102128
* http://www.liquibase.org/

#### Pre-requisites installation:

* http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html

#### Build:

```
mvn clean install
```

#### Project installation/upgrade on ubuntu:

```
﻿> sudo dpkg -i jdeb-liquibase_1.0~[.. hostname ..]_all.deb
```

#### Removal on ubuntu:

```
> sudo dpkg -P jdeb-liquibase
```