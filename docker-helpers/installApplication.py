AdminTask.changeFileRegistryAccountPassword('[-userId wsadmin -password wsadmin1]')
AdminApp.install('/work/docker-hellowebsphere-ear/target/docker-hellowebsphere-ear-0.0.1-SNAPSHOT.ear', '[-node DefaultNode01 -cell DefaultCell01 -server server1]')
AdminConfig.save()

