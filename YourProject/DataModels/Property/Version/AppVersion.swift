//
//  AppVersion.swift
//  HomemadeStay
//
//  Created by Introdex on 15/10/2563 BE.
//  Copyright © 2563 Fire One One Co., Ltd. All rights reserved.
//

import Foundation

struct AppVersion {
    
    //appVersion
    var versionString: String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var version: Version? {
        guard
            let _versionString = versionString
        else { return nil }
        
        return Version(string: _versionString)
    }
    
    // build number
    var buildNumberString: String? {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}
