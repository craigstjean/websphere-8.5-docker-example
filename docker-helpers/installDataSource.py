AdminTask.changeFileRegistryAccountPassword('[-userId wsadmin -password wsadmin1]')

varName = "ORACLE_JDBC_DRIVER_PATH"
newVarValue = "/work"
node = AdminConfig.getid("/Node:DefaultNode01/")
varSubstitutions = AdminConfig.list("VariableSubstitutionEntry", node).split(java.lang.System.getProperty("line.separator"))

for varSubst in varSubstitutions:
   getVarName = AdminConfig.showAttribute(varSubst, "symbolicName")
   if getVarName == varName:
      AdminConfig.modify(varSubst, [["value", newVarValue]])
      break

AdminConfig.save()

AdminTask.createJDBCProvider('[-scope Node=DefaultNode01,Server=server1 -databaseType Oracle -providerType "Oracle JDBC Driver" -implementationType "Connection pool data source" -name "Oracle JDBC Driver" -description "Oracle JDBC Driver" -classpath [${ORACLE_JDBC_DRIVER_PATH}/ojdbc6.jar ] -nativePath "" ]')
AdminConfig.save()

AdminTask.createAuthDataEntry('[-alias dsuser -user dsuser -password dsuser1 -description ]')
AdminConfig.save()

oracleProvider = AdminConfig.getid('/Cell:DefaultCell01/Node:DefaultNode01/Server:server1/JDBCProvider:Oracle JDBC Driver/')
AdminTask.createDatasource(oracleProvider, '[-name DB_DS -jndiName jdbc/DB_DS -dataStoreHelperClassName com.ibm.websphere.rsadapter.Oracle11gDataStoreHelper -containerManagedPersistence true -componentManagedAuthenticationAlias DefaultNode01/spmremote -configureResourceProperties [[URL java.lang.String jdbc:oracle:thin:@host:1521/db]]]')
AdminConfig.save()

