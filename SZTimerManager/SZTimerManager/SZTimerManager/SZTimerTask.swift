//
//  SZTimerTask.swift
//  SZTimerManager
//
//  Created by 何松泽 on 2020/5/22.
//  Copyright © 2020 HSZ. All rights reserved.
//

import UIKit

class SZTimerTask: NSObject {
    /** 事件闭包 */
    typealias SZTimerTaskEvent = ()->()
    
    /** 毫秒间隔（不能大于60毫秒即1秒） */
    var timeInterval:Int = 0
    /** 任务标识 */
    var taskID:String = ""
    /** 事件 */
    var taskEvent:SZTimerTaskEvent
    
    init(timeI:Int,event:@escaping SZTimerTaskEvent,ID:String) {
        self.taskEvent = event
        self.timeInterval = timeI
        self.taskID = ID
    }
}
