//
//  ViewController.swift
//  SZTimerManager
//
//  Created by 何松泽 on 2020/5/22.
//  Copyright © 2020 HSZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var taskIndex:Int = 0
    
    lazy var addTaskBtn:UIButton = {
        let addTaskBtn = UIButton.init(type: .custom)
        addTaskBtn.frame = CGRect.init(origin: CGPoint.init(x: 100, y: 100), size: CGSize.init(width: 100, height: 100))
        addTaskBtn.setTitle("Add Task", for: .normal)
        addTaskBtn.backgroundColor = .blue
        addTaskBtn.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        return addTaskBtn
    }()
    
    lazy var cancelTaskBtn:UIButton = {
        let cancelTaskBtn = UIButton.init(type: .custom)
        cancelTaskBtn.frame = CGRect.init(origin: CGPoint.init(x: 100, y: 300), size: CGSize.init(width: 100, height: 100))
        cancelTaskBtn.setTitle("Cancel Task", for: .normal)
        cancelTaskBtn.backgroundColor = .red
        cancelTaskBtn.addTarget(self, action: #selector(cancelTask), for: .touchUpInside)
        return cancelTaskBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(addTaskBtn)
        self.view.addSubview(cancelTaskBtn)
        
        let taskID = "\(taskIndex)"
        let task = SZTimerTask.init(timeI: 60, event: {
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss.SSS"
            let currentTimrStr = timeFormatter.string(from: date)
            print("当前任务个数:",self.taskIndex,"任务ID:",taskID,currentTimrStr)
        }, ID: taskID)
        SZTimerManager.sharedInstance.runTask(task: task)
    }

    @objc func addTask()
    {
        taskIndex += 1
        let taskID = "\(taskIndex)"
        let task = SZTimerTask.init(timeI: 60, event: {
            let date = Date()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss.SSS"
            let currentTimrStr = timeFormatter.string(from: date)
            print("当前任务个数:",self.taskIndex,"任务ID:",taskID,currentTimrStr)
        }, ID: taskID)
        SZTimerManager.sharedInstance.runTask(task: task)
    }

    @objc func cancelTask()
    {
        SZTimerManager.sharedInstance.cancelTask(with: "\(taskIndex)")
        taskIndex -= 1
    }
}

