//
//  Keychain Manager.swift
//  KeyChain Demo
//
//  Created by Suraj Bhujbal on 10/01/24.
//

import Foundation
import Security


struct KeychainService{
    static let serviceName = "YourAppService"
}

class KeychainManager {
    class func savePassword(service: String, account: String, password: String) -> String {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecValueData as String: password.data(using: .utf8)!,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]

            let status = SecItemAdd(query as CFDictionary, nil)
            print(status == 0)
        if status == 0{
            print("saving password to keychain")
            return "saving password to keychain"
            
        }
            if status != errSecSuccess {
                print("Error saving password to keychain: \(status)")
                
                return "Error saving password to keychain: \(status)"
            }
        return ""
        }

        class func getPassword(service: String, account: String) -> String? {
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account,
                kSecMatchLimit as String: kSecMatchLimitOne,
                kSecReturnData as String: kCFBooleanTrue!,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]

            var dataTypeRef: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
            print(status)
            if status == errSecSuccess {
                
                if let data = dataTypeRef as? Data, let password = String(data: data, encoding: .utf8) {
                    
                    return password
                }
            } else {
                print("Error retrieving password from keychain: \(status)")
            }

            return nil
        }

        class func deletePassword(service: String, account: String) -> String{
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account
            ]

            let status = SecItemDelete(query as CFDictionary)
            if status == 0{
                print("Deleting password from keychain")
                return "Deleting password from keychain"
            }
            if status != errSecSuccess {
                print("Error deleting password from keychain: \(status)")
                return "Error deleting password from keychain: \(status)"
            }
            return ""
        }
    }
