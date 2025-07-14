//
//  String+Validator.swift
//  HomemadeStayTests
//
//  Created by Introdex on 12/12/2562 BE.
//  Copyright © 2562 Fire One One Co., Ltd. All rights reserved.
//

import Foundation
//import ValidatorCore
//
//extension String {
//    func isPassportId() -> Bool {
//        let validator = Validator()
//        
//        enum ValidationErrors: String, IValidationError {
//            case dataInvalid    = "Invalid data"
//            
//            var message : String { return self.rawValue }
//        }
//        
//        let passportRule = RegexValidationRule(pattern: "[A-Za-z0-9]{7,9}",
//                                             error: ValidationErrors.dataInvalid)
//        let result = validator.validate(input: self,
//                                        rule: passportRule)
//        return result == .valid
//    }
//    
//    func isCitizenId() -> Bool {
//        let validator = Validator()
//        
//        enum ValidationErrors: String, IValidationError {
//            case dataInvalid    = "Invalid data"
//            
//            var message : String { return self.rawValue }
//        }
//        
//        let citizenIdRule = RegexValidationRule(pattern: "[0-9]{13}",
//                                              error: ValidationErrors.dataInvalid)
//        let result = validator.validate(input: self,
//                                        rule: citizenIdRule)
//        return result == .valid
//    }
//}
