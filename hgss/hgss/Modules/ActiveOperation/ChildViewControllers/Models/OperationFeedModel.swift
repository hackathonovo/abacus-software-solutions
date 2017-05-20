//
//  OperationFeedModel.swift
//  hgss
//
//  Created by Igor Mandić on 20/05/2017.
//  Copyright © 2017 Abacus Software Solutions. All rights reserved.
//

import Foundation
import Unbox


struct OperationUpdatesFeed {
    let feedUpdates:Array<SingleFeedUpdate>
}

extension OperationUpdatesFeed: Unboxable {
    init(unboxer:Unboxer) throws {
        self.feedUpdates = try unboxer.unbox(key: "data")
    }
}


struct SingleFeedUpdate {
    let id: Int
    let rescueId: Int
    let text:String
    let author:String
    let createdAt:Date
    let updatedAt:Date
}

extension SingleFeedUpdate: Unboxable {
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.rescueId = try unboxer.unbox(key: "rescue_action_id")
        self.text = try unboxer.unbox(key: "text")
        self.author = try unboxer.unbox(key: "author")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        
        self.createdAt = try unboxer.unbox(key: "created_at", formatter: dateFormatter)
        self.updatedAt = try unboxer.unbox(key: "updated_at", formatter: dateFormatter)
    }
}
