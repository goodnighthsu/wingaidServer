//
//  Package.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 4/20/16.
//	Copyright (C) 2016 PerfectlySoft, Inc.
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

import PackageDescription

let package = Package(
	name: "WingaidServer",
	targets: [],
	dependencies: [
		.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
		.Package(url:"https://github.com/PerfectlySoft/Perfect-Session.git", majorVersion: 0, minor: 0),
		.Package(url:"https://github.com/goodnighthsu/JSONWebToken.swift.git", majorVersion:2),
        .Package(url:"https://github.com/PerfectlySoft/Perfect-RequestLogger.git", majorVersion:1),
        .Package(url:"https://github.com/SwiftORM/MySQL-StORM",  majorVersion:1)
    ]
)
