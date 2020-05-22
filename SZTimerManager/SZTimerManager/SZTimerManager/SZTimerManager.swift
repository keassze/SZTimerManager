//
//  SZTimerManager.swift
//  SZTimerManager
//
//  Created by 何松泽 on 2020/5/22.
//  Copyright © 2020 HSZ. All rights reserved.
//

import UIKit

class SZTimerManager: NSObject {
    static let sharedInstance = SZTimerManager()
    
    /** 公开的类方法 */
    class func defaultManager() -> SZTimerManager
    {
        return sharedInstance
    }
    
    /** 私有化构造器方法，防止外部随意创建 */
    private override init()
    {
        super.init()
        RunLoop.main.add(self.timer, forMode: .common)
    }
    
    /** 执行任务 */
    func runTask(task:SZTimerTask)
    {
        /** 如果计时器没被激活 */
        if self.tasksArr.count <= 0 {
            self.timer.fire()
            self.timer.fireDate = NSDate.init() as Date
            self.timer.fireDate = Date.distantPast
        }
        
        for t in self.tasksArr {
            if t.taskID == task.taskID {
                return
            }
        }
        self.tasksArr.append(task)
    }
    
    /** 取消任务 */
    func cancelTask(with taskID:String)
    {
        for i in 0..<self.tasksArr.count {
            if self.tasksArr[i].taskID == taskID {
                self.tasksArr.remove(at: i)
                break;
            }
        }
        
        /**
            如果没有任务，将计时器暂停
            P.S.不要注销，注销是永久关闭的操作
         */
        if self.tasksArr.count == 0 {
            self.timer.fireDate = Date.distantFuture
        }
    }
    
    /** Lazy-Load  */
    /** 任务列表 */
    lazy private var tasksArr:[SZTimerTask] = {
        return []
    }()
    
    /** 计时器 */
    lazy private var timer:Timer = {
        var index:Int = 0
        // 公倍数
        var leastCommonMultiple:Int = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 1/60.0, repeats: true) { (t) in
            if index == 59 {
                index = 0
            }
            for task in self.tasksArr {
                if index%task.timeInterval == 0 {
                    task.taskEvent()
                }
            }
            index += 1
        }
        return timer
    }()
    
}
