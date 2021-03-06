//
//  config.swift
//  PerfectServer
//
//  Created by 徐非 on 17/2/7.
//
//

import Foundation

//MARK: JWT
let JWTSecret = "Leon Perfect"

//MARK: Web
#if os(Linux)
    let rootDirectory = "/home/wingaidServer/"
    let documentRoot = "/home/wingaidtServer/webroot"
#else
    let rootDirectory = NSHomeDirectory() + "/wingaidServer"
    let documentRoot = "./webroot"
#endif

let logDirectory = rootDirectory + "/log"
let logFile = logDirectory + "/serverLog.log"

//MAKR: MySql
#if os(Linux)
    let mySqlHost = "10.117.226.53"
#else
    let mySqlHost = "47.88.5.43"
#endif

let mySqlUserName = "root"

#if os (Linux)
  let mySqlPassword = "Wxgoogle123"
#else
    let mySqlPassword = "a123456"
#endif

let mySqlDatabase = "crm"
let mySqlPort = 3306
