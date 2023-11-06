mongod
{"t":{"$date":"2023-10-26T19:24:05.287+02:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'"}                                                         
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}                    
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"I",  "c":"STORAGE",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":1487,"port":27017,"dbPath":"/data/db","architecture":"64-bit","host":"greibd"}}                                 
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"4.4.24","gitVersion":"0b86b9b7b42ad9970c5f818c527dd86c0634243a","openSSLVersion":"OpenSSL 1.1.1f  31 Mar 2020","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}                                                                                                                                 
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"Ubuntu","version":"20.04"}}}                                                                            
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{}}}                                                                                             
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"E",  "c":"NETWORK",  "id":23024,   "ctx":"initandlisten","msg":"Failed to unlink socket file","attr":{"path":"/tmp/mongodb-27017.sock","error":"Operation not permitted"}}                                      
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"F",  "c":"-",        "id":23091,   "ctx":"initandlisten","msg":"Fatal assertion","attr":{"msgid":40486,"file":"src/mongo/transport/transport_layer_asio.cpp","line":1048}}                                      
{"t":{"$date":"2023-10-26T19:24:05.300+02:00"},"s":"F",  "c":"-",        "id":23092,   "ctx":"initandlisten","msg":"\n\n***aborting after fassert() failure\n\n"} 

solution 

Does the file /tmp/mongodb-27017.sock exist? If so try to delete it, ie. 'sudo rm /tmp/mongodb-27017.sock'.


### OTHER ERROR 

 mongod
{"t":{"$date":"2023-10-26T19:25:37.040+02:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'"}                                                         
{"t":{"$date":"2023-10-26T19:25:37.040+02:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}                    
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"STORAGE",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":1511,"port":27017,"dbPath":"/data/db","architecture":"64-bit","host":"greibd"}}                                 
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"4.4.24","gitVersion":"0b86b9b7b42ad9970c5f818c527dd86c0634243a","openSSLVersion":"OpenSSL 1.1.1f  31 Mar 2020","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}                                                                                                                                 
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"Ubuntu","version":"20.04"}}}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{}}}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"E",  "c":"STORAGE",  "id":20568,   "ctx":"initandlisten","msg":"Error setting up listener","attr":{"error":{"code":9001,"codeName":"SocketException","errmsg":"Address already in use"}}}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"REPL",     "id":4784900, "ctx":"initandlisten","msg":"Stepping down the ReplicationCoordinator for shutdown","attr":{"waitTimeMillis":10000}}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"COMMAND",  "id":4784901, "ctx":"initandlisten","msg":"Shutting down the MirrorMaestro"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"SHARDING", "id":4784902, "ctx":"initandlisten","msg":"Shutting down the WaitForMajorityService"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"NETWORK",  "id":4784905, "ctx":"initandlisten","msg":"Shutting down the global connection pool"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"NETWORK",  "id":4784918, "ctx":"initandlisten","msg":"Shutting down the ReplicaSetMonitor"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"SHARDING", "id":4784921, "ctx":"initandlisten","msg":"Shutting down the MigrationUtilExecutor"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"CONTROL",  "id":4784925, "ctx":"initandlisten","msg":"Shutting down free monitoring"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"STORAGE",  "id":4784927, "ctx":"initandlisten","msg":"Shutting down the HealthLog"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"STORAGE",  "id":4784929, "ctx":"initandlisten","msg":"Acquiring the global lock for shutdown"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"-",        "id":4784931, "ctx":"initandlisten","msg":"Dropping the scope cache for shutdown"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"FTDC",     "id":4784926, "ctx":"initandlisten","msg":"Shutting down full-time data capture"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"CONTROL",  "id":20565,   "ctx":"initandlisten","msg":"Now exiting"}
{"t":{"$date":"2023-10-26T19:25:37.041+02:00"},"s":"I",  "c":"CONTROL",  "id":23138,   "ctx":"initandlisten","msg":"Shutting down","attr":{"exitCode":48}}



alumnogreibd@greibd:~$ sudo systemctl start mongod
alumnogreibd@greibd:~$ mongod
{"t":{"$date":"2023-10-26T19:27:42.239+02:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-10-26T19:27:42.240+02:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-10-26T19:27:42.240+02:00"},"s":"I",  "c":"STORAGE",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":1548,"port":27017,"dbPath":"/data/db","architecture":"64-bit","host":"greibd"}}
{"t":{"$date":"2023-10-26T19:27:42.240+02:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"4.4.24","gitVersion":"0b86b9b7b42ad9970c5f818c527dd86c0634243a","openSSLVersion":"OpenSSL 1.1.1f  31 Mar 2020","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-10-26T19:27:42.240+02:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"Ubuntu","version":"20.04"}}}
{"t":{"$date":"2023-10-26T19:27:42.240+02:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{}}}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"E",  "c":"STORAGE",  "id":20557,   "ctx":"initandlisten","msg":"DBException in initAndListen, terminating","attr":{"error":"NonExistentPath: Data directory /data/db not found. Create the missing directory or specify another path using (1) the --dbpath command line option, or (2) by adding the 'storage.dbPath' option in the configuration file."}}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"REPL",     "id":4784900, "ctx":"initandlisten","msg":"Stepping down the ReplicationCoordinator for shutdown","attr":{"waitTimeMillis":10000}}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"COMMAND",  "id":4784901, "ctx":"initandlisten","msg":"Shutting down the MirrorMaestro"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"SHARDING", "id":4784902, "ctx":"initandlisten","msg":"Shutting down the WaitForMajorityService"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"NETWORK",  "id":20562,   "ctx":"initandlisten","msg":"Shutdown: going to close listening sockets"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"NETWORK",  "id":4784905, "ctx":"initandlisten","msg":"Shutting down the global connection pool"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"STORAGE",  "id":4784906, "ctx":"initandlisten","msg":"Shutting down the FlowControlTicketholder"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"-",        "id":20520,   "ctx":"initandlisten","msg":"Stopping further Flow Control ticket acquisitions."}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"NETWORK",  "id":4784918, "ctx":"initandlisten","msg":"Shutting down the ReplicaSetMonitor"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"SHARDING", "id":4784921, "ctx":"initandlisten","msg":"Shutting down the MigrationUtilExecutor"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"CONTROL",  "id":4784925, "ctx":"initandlisten","msg":"Shutting down free monitoring"}
{"t":{"$date":"2023-10-26T19:27:42.250+02:00"},"s":"I",  "c":"STORAGE",  "id":4784927, "ctx":"initandlisten","msg":"Shutting down the HealthLog"}
{"t":{"$date":"2023-10-26T19:27:42.251+02:00"},"s":"I",  "c":"STORAGE",  "id":4784929, "ctx":"initandlisten","msg":"Acquiring the global lock for shutdown"}
{"t":{"$date":"2023-10-26T19:27:42.251+02:00"},"s":"I",  "c":"-",        "id":4784931, "ctx":"initandlisten","msg":"Dropping the scope cache for shutdown"}
{"t":{"$date":"2023-10-26T19:27:42.251+02:00"},"s":"I",  "c":"FTDC",     "id":4784926, "ctx":"initandlisten","msg":"Shutting down full-time data capture"}
{"t":{"$date":"2023-10-26T19:27:42.251+02:00"},"s":"I",  "c":"CONTROL",  "id":20565,   "ctx":"initandlisten","msg":"Now exiting"}
{"t":{"$date":"2023-10-26T19:27:42.251+02:00"},"s":"I",  "c":"CONTROL",  "id":23138,   "ctx":"initandlisten","msg":"Shutting down","attr":{"exitCode":100}}
alumnogreibd@greibd:~$ sudo rm /tmp/mongodb-27017.sock
alumnogreibd@greibd:~$ sudo systemctl stop mongod
alumnogreibd@greibd:~$ sudo systemctl start mongod
alumnogreibd@greibd:~$ mongod
{"t":{"$date":"2023-10-26T19:27:57.365+02:00"},"s":"I",  "c":"CONTROL",  "id":23285,   "ctx":"main","msg":"Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'"}
{"t":{"$date":"2023-10-26T19:27:57.366+02:00"},"s":"I",  "c":"NETWORK",  "id":4648601, "ctx":"main","msg":"Implicit TCP FastOpen unavailable. If TCP FastOpen is required, set tcpFastOpenServer, tcpFastOpenClient, and tcpFastOpenQueueSize."}
{"t":{"$date":"2023-10-26T19:27:57.366+02:00"},"s":"I",  "c":"STORAGE",  "id":4615611, "ctx":"initandlisten","msg":"MongoDB starting","attr":{"pid":1624,"port":27017,"dbPath":"/data/db","architecture":"64-bit","host":"greibd"}}
{"t":{"$date":"2023-10-26T19:27:57.366+02:00"},"s":"I",  "c":"CONTROL",  "id":23403,   "ctx":"initandlisten","msg":"Build Info","attr":{"buildInfo":{"version":"4.4.24","gitVersion":"0b86b9b7b42ad9970c5f818c527dd86c0634243a","openSSLVersion":"OpenSSL 1.1.1f  31 Mar 2020","modules":[],"allocator":"tcmalloc","environment":{"distmod":"ubuntu2004","distarch":"x86_64","target_arch":"x86_64"}}}}
{"t":{"$date":"2023-10-26T19:27:57.366+02:00"},"s":"I",  "c":"CONTROL",  "id":51765,   "ctx":"initandlisten","msg":"Operating System","attr":{"os":{"name":"Ubuntu","version":"20.04"}}}
{"t":{"$date":"2023-10-26T19:27:57.366+02:00"},"s":"I",  "c":"CONTROL",  "id":21951,   "ctx":"initandlisten","msg":"Options set by command line","attr":{"options":{}}}
{"t":{"$date":"2023-10-26T19:27:57.367+02:00"},"s":"E",  "c":"NETWORK",  "id":23024,   "ctx":"initandlisten","msg":"Failed to unlink socket file","attr":{"path":"/tmp/mongodb-27017.sock","error":"Operation not permitted"}}
{"t":{"$date":"2023-10-26T19:27:57.367+02:00"},"s":"F",  "c":"-",        "id":23091,   "ctx":"initandlisten","msg":"Fatal assertion","attr":{"msgid":40486,"file":"src/mongo/transport/transport_layer_asio.cpp","line":1048}}
{"t":{"$date":"2023-10-26T19:27:57.367+02:00"},"s":"F",  "c":"-",        "id":23092,   "ctx":"initandlisten","msg":"\n\n***aborting after fassert() failure\n\n"}

