//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectSession
import PerfectRequestLogger
import StORM
import MySQLStORM


// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(data: [String:Any]) throws -> RequestHandler {
	return {
		request, response in
		// Respond with a simple message.
		response.setHeader(.contentType, value: "text/html")
		response.appendBody(string: "<html><title>Hello, leon world!</title><body>Hello, world!</body></html>")
		// Ensure that response.completed() is called when your processing is done.
		response.completed()
	}
}

// Configuration data for two example servers.
// This example configuration shows how to launch one or more servers 
// using a configuration dictionary.

let port1 = 8080, port2 = 8181

let confData = [
	"servers": [
		// Configuration data for one server which:
		//	* Serves the hello world message at <host>:<port>/
		//	* Serves static files out of the "./webroot"
		//		directory (which must be located in the current working directory).
		//	* Performs content compression on outgoing data when appropriate.
		[
			"name":"localhost",
			"port":port1,
			"routes":[
				["method":"get", "uri":"/", "handler":handler],
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
				 "documentRoot":"./webroot",
				 "allowResponseFilters":true]
			],
			"filters":[
				[
				"type":"response",
				"priority":"high",
				"name":PerfectHTTPServer.HTTPFilter.contentCompression,
				]
			]
		],
		// Configuration data for another server which:
		//	* Redirects all traffic back to the first server.
		[
			"name":"localhost",
			"port":port2,
			"routes":[
				["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.redirect,
				 "base":"http://localhost:\(port1)"]
			]
		]
	]
]

/*
//MARK: Session
SessionConfig.name = "PerfectSession"
SessionConfig.idle = 60*60*24
let sessionDriver = SessionMemoryDriver()
 */

//MARK: Log
let httpLogger = RequestLogger()

let fileManager = FileManager.default

if !fileManager.fileExists(atPath: logFile) {
    do{
        try fileManager.createDirectory(atPath: logDirectory, withIntermediateDirectories: true, attributes: nil)
        RequestLogFile.location = logFile
        print(logFile)
    }catch{
        NSLog("Error: create log file \(error.localizedDescription)")
    }
}

//MARK: Mysql
func initMysql(){
    MySQLConnector.host = mySqlHost
    MySQLConnector.username = mySqlUserName
    MySQLConnector.password = mySqlPassword
    MySQLConnector.database = mySqlDatabase
    MySQLConnector.port = mySqlPort
}

initMysql()

//MARK: Server
do {
	// Launch the servers based on the configuration data.
	//let server = try HTTPServer.launch(configurationData: confData)
    let server = HTTPServer()
    server.serverPort = 8080
    //Static File
    server.documentRoot = documentRoot
    //不使用Session
    //server.setRequestFilters([sessionDriver.requestFilter])
    //server.setResponseFilters([(Filter.filter404(), .high), sessionDriver.responseFilter])
    server.setResponseFilters([(Filter.filter404(), .high)])
    //
    server.setRequestFilters([(httpLogger, .high)])
    server.setResponseFilters([(httpLogger, .high)])
    //
    server.addRoutes(CustomRoutes.createRoutes())

    
    
    try server.start()
    

} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

