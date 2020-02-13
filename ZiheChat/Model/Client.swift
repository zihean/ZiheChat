//
//  Client.swift
//  ZiheChat
//
//  Created by 安子和 on 2020/2/12.
//  Copyright © 2020 安子和. All rights reserved.
//

import AVFoundation
import LeanCloud

open class Client {
    static var current:IMClient!
    static let delegator = Client()
}

extension Client: IMClientDelegate {
    
    public func client(_ client: IMClient, event: IMClientEvent) {
        switch event {
        case .sessionDidOpen:
            print("sessionDidOpen")
            break
        default:
            break
        }
    }
    
    public func client(_ client: IMClient, conversation: IMConversation, event: IMConversationEvent) {
        switch event {
        case let .joined(byClientID: byClientID, at: atData):
            print(byClientID!)
            print(atData!)
            break
        case .message(event: let messageEvent):
            switch messageEvent {
            case .received(message: let message):
                print(message.content!)
                print(message.fromClientID!)
            default:
                break
            }
        default:
            break
        }
    }
}

func mainQueueExecuting(_ closure: @escaping () -> Void) {
    if Thread.isMainThread {
        closure()
    } else {
        DispatchQueue.main.async {
            closure()
        }
    }
}
