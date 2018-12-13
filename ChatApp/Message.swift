//
//  Message.swift
//  ChatApp
//
//  Created by Yoshiaki Kato on 2018/11/04.
//  Copyright © 2018 Yoshiaki Kato. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    
    var sender: Sender
    var sentDate: Date
    var messageId: String
    var kind: MessageKind
    
}
