//
//  NetStatus.swift
//  DuelDice
//
//  Created by kyuhkim on 2021/12/30.
//

import Foundation
import Alamofire

class NetStatus {
    
    func dispose(closure: (String) -> ()) {
        if Alamofire.NetworkReachabilityManager() == nil {
            closure("--- [AF RMAN ERR] ---")
//            DEBUG_LABEL_TEXT(content: "--- [AF RMAN ERR] ---")
            print("--- [AF RMAN ERR] ---")
        }
        else if Alamofire.NetworkReachabilityManager()!.isReachable {
//            DEBUG_LABEL_TEXT(content: "--- [TIME OUT] ---")
            closure("--- [TIME OUT] ---")
            print("--- [TIME OUT] ---")
        }
        else {
//            DEBUG_LABEL_TEXT(content: "--- [NET ERR] ---")
            closure("--- [NETWORK ERROR] ---")
            print("--- [NETWORK ERROR] ---")
        }
    }

    func isReachable() -> Bool {
        return Alamofire.NetworkReachabilityManager()?.isReachable ?? false
    }
}
