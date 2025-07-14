//
//  PaymentMethodsTests.swift
//  YourProject
//
//  Created by IntrodexMini on 14/6/2568 BE.
//

import XCTest


final class PaymentMethodsTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_initWithDefaultConstructor() throws {
        // Arrange & Act
        let paymentMethods = PaymentMethods()
        
        // Assert
        XCTAssertNotNil(paymentMethods.lists)
        XCTAssertGreaterThanOrEqual(paymentMethods.count, 0)
        XCTAssertEqual(paymentMethods.count, paymentMethods.lists.count)
    }
    
    func test_initWithArray() throws {
        // Arrange
        let sampleMethods = createSamplePaymentMethods()
        
        // Act
        let paymentMethods = PaymentMethods(array: sampleMethods)
        
        // Assert
        XCTAssertEqual(paymentMethods.count, 3)
        XCTAssertEqual(paymentMethods.lists.count, 3)
        XCTAssertEqual(paymentMethods.lists[0].name, "Bank Transfer")
        XCTAssertEqual(paymentMethods.lists[1].name, "Credit Card")
        XCTAssertEqual(paymentMethods.lists[2].name, "Fin Tech")
        XCTAssertTrue(paymentMethods.lists[2].subMethods.count > 0)
    }
    
    func test_initWithEmptyArray() throws {
        // Arrange & Act
        let paymentMethods = PaymentMethods(array: [])
        
        // Assert
        XCTAssertEqual(paymentMethods.count, 0)
        XCTAssertTrue(paymentMethods.lists.isEmpty)
    }
    
    // MARK: - Properties Tests
    
    func test_countProperty() throws {
        // Arrange
        let sampleMethods = createSamplePaymentMethods()
        let paymentMethods = PaymentMethods(array: sampleMethods)
        
        // Act & Assert
        XCTAssertEqual(paymentMethods.count, sampleMethods.count)
        XCTAssertEqual(paymentMethods.count, paymentMethods.lists.count)
    }
    
    func test_listsProperty() throws {
        // Arrange
        let sampleMethods = createSamplePaymentMethods()
        let paymentMethods = PaymentMethods(array: sampleMethods)
        
        // Act & Assert
        XCTAssertEqual(paymentMethods.lists.count, 3)
        XCTAssertEqual(paymentMethods.lists[0].name, "Bank Transfer")
        XCTAssertEqual(paymentMethods.lists[1].name, "Credit Card")
        XCTAssertEqual(paymentMethods.lists[2].name, "Fin Tech")
    }
    
    // MARK: - PaymentMethod Nested Struct Tests
    
    func test_paymentMethodInit() throws {
        // Arrange & Act
        let subMethods = [
            PaymentMethods.PaymentMethod(name: "Alipay", subMethods: []),
            PaymentMethods.PaymentMethod(name: "Apple Pay", subMethods: [])
        ]
        let paymentMethod = PaymentMethods.PaymentMethod(name: "Fin Tech", subMethods: subMethods)
        
        // Assert
        XCTAssertEqual(paymentMethod.name, "Fin Tech")
        XCTAssertEqual(paymentMethod.subMethods.count, 2)
        XCTAssertEqual(paymentMethod.subMethods[0].name, "Alipay")
        XCTAssertEqual(paymentMethod.subMethods[1].name, "Apple Pay")
    }
    
    func test_paymentMethodWithEmptySubMethods() throws {
        // Arrange & Act
        let paymentMethod = PaymentMethods.PaymentMethod(name: "Cash", subMethods: [])
        
        // Assert
        XCTAssertEqual(paymentMethod.name, "Cash")
        XCTAssertTrue(paymentMethod.subMethods.isEmpty)
    }
    
    // MARK: - Codable Tests
    
    func test_paymentMethodDecodingFromJSON() throws {
        // Arrange
        let json = """
        {
            "name": "Fin Tech",
            "sub_methods": [
                {
                    "name": "Alipay",
                    "sub_methods": []
                },
                {
                    "name": "Apple Pay",
                    "sub_methods": []
                },
                {
                    "name": "Prompt pay",
                    "sub_methods": []
                }
            ]
        }
        """.data(using: .utf8)!
        
        // Act
        let paymentMethod = try JSONDecoder().decode(PaymentMethods.PaymentMethod.self, from: json)
        
        // Assert
        XCTAssertEqual(paymentMethod.name, "Fin Tech")
        XCTAssertEqual(paymentMethod.subMethods.count, 3)
        XCTAssertEqual(paymentMethod.subMethods[0].name, "Alipay")
        XCTAssertEqual(paymentMethod.subMethods[1].name, "Apple Pay")
        XCTAssertEqual(paymentMethod.subMethods[2].name, "Prompt pay")
        XCTAssertTrue(paymentMethod.subMethods[0].subMethods.isEmpty)
    }
    
    func test_paymentMethodArrayDecodingFromJSON() throws {
        // Arrange
        let json = """
        [
            {
                "name": "Bank Transfer",
                "sub_methods": []
            },
            {
                "name": "Cash",
                "sub_methods": []
            },
            {
                "name": "Fin Tech",
                "sub_methods": [
                    {
                        "name": "Alipay",
                        "sub_methods": []
                    },
                    {
                        "name": "Apple Pay",
                        "sub_methods": []
                    }
                ]
            }
        ]
        """.data(using: .utf8)!
        
        // Act
        let paymentMethods = try JSONDecoder().decode([PaymentMethods.PaymentMethod].self, from: json)
        
        // Assert
        XCTAssertEqual(paymentMethods.count, 3)
        XCTAssertEqual(paymentMethods[0].name, "Bank Transfer")
        XCTAssertTrue(paymentMethods[0].subMethods.isEmpty)
        XCTAssertEqual(paymentMethods[1].name, "Cash")
        XCTAssertTrue(paymentMethods[1].subMethods.isEmpty)
        XCTAssertEqual(paymentMethods[2].name, "Fin Tech")
        XCTAssertEqual(paymentMethods[2].subMethods.count, 2)
        XCTAssertEqual(paymentMethods[2].subMethods[0].name, "Alipay")
        XCTAssertEqual(paymentMethods[2].subMethods[1].name, "Apple Pay")
    }
    
    func test_paymentMethodDecodingWithMissingSubMethods() throws {
        // Arrange
        let json = """
        {
            "name": "Cash"
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(PaymentMethods.PaymentMethod.self, from: json)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    func test_paymentMethodDecodingWithInvalidJSON() throws {
        // Arrange
        let json = """
        {
            "invalid_key": "Invalid Value"
        }
        """.data(using: .utf8)!
        
        // Act & Assert
        XCTAssertThrowsError(try JSONDecoder().decode(PaymentMethods.PaymentMethod.self, from: json)) { error in
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    // MARK: - Edge Cases Tests
    
    func test_paymentMethodsWithNestedSubMethods() throws {
        // Arrange
        let deeplyNested = PaymentMethods.PaymentMethod(
            name: "Level 2",
            subMethods: [
                PaymentMethods.PaymentMethod(name: "Level 3", subMethods: [])
            ]
        )
        let topLevel = PaymentMethods.PaymentMethod(
            name: "Level 1",
            subMethods: [deeplyNested]
        )
        let paymentMethods = PaymentMethods(array: [topLevel])
        
        // Act & Assert
        XCTAssertEqual(paymentMethods.count, 1)
        XCTAssertEqual(paymentMethods.lists[0].name, "Level 1")
        XCTAssertEqual(paymentMethods.lists[0].subMethods.count, 1)
        XCTAssertEqual(paymentMethods.lists[0].subMethods[0].name, "Level 2")
        XCTAssertEqual(paymentMethods.lists[0].subMethods[0].subMethods.count, 1)
        XCTAssertEqual(paymentMethods.lists[0].subMethods[0].subMethods[0].name, "Level 3")
    }
    
    // MARK: - Helper Methods
    
    private func createSamplePaymentMethods() -> [PaymentMethods.PaymentMethod] {
        let bankTransfer = PaymentMethods.PaymentMethod(name: "Bank Transfer", subMethods: [])
        let creditCard = PaymentMethods.PaymentMethod(name: "Credit Card", subMethods: [])
        let finTechSubMethods = [
            PaymentMethods.PaymentMethod(name: "Alipay", subMethods: []),
            PaymentMethods.PaymentMethod(name: "Apple Pay", subMethods: []),
            PaymentMethods.PaymentMethod(name: "Prompt pay", subMethods: []),
            PaymentMethods.PaymentMethod(name: "Samsung Pay", subMethods: []),
            PaymentMethods.PaymentMethod(name: "WeChat Pay", subMethods: [])
        ]
        let finTech = PaymentMethods.PaymentMethod(name: "Fin Tech", subMethods: finTechSubMethods)
        
        return [bankTransfer, creditCard, finTech]
    }
    
    private func createCompletePaymentMethodsJSON() -> String {
        return """
        [
            {
                "name": "Bank Transfer",
                "sub_methods": []
            },
            {
                "name": "Cash",
                "sub_methods": []
            },
            {
                "name": "Cheque",
                "sub_methods": []
            },
            {
                "name": "Credit Card",
                "sub_methods": []
            },
            {
                "name": "Fin Tech",
                "sub_methods": [
                    {
                        "name": "Alipay",
                        "sub_methods": []
                    },
                    {
                        "name": "Apple Pay",
                        "sub_methods": []
                    },
                    {
                        "name": "Prompt pay",
                        "sub_methods": []
                    },
                    {
                        "name": "Samsung Pay",
                        "sub_methods": []
                    },
                    {
                        "name": "WeChat Pay",
                        "sub_methods": []
                    }
                ]
            },
            {
                "name": "OTA Transfer",
                "sub_methods": []
            },
            {
                "name": "Paypal",
                "sub_methods": []
            }
        ]
        """
    }
} 
