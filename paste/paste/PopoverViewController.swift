//
//  PopoverViewController.swift
//  paste
//
//  Created by loki on 2020/8/16.
//  Copyright © 2020 loki. All rights reserved.
//

import Cocoa
import SwiftUI

class PopoverViewController: NSViewController {

    @IBOutlet weak var copyButton: NSButton?;
    @IBAction func copyClick(_ sender: Any) {
        print("copyClick")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        copyButton?.title="test"
        // Do view setup here.
    }
    func setButtonTitle(_ text: String) {
        print(text)
        copyButton?.title=text
    }
}
extension PopoverViewController {
    static func freshController() -> PopoverViewController {
        //获取对Main.storyboard的引用
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        // 为PopoverViewController创建一个标识符
        let identifier = NSStoryboard.SceneIdentifier("PopoverViewController")
        // 实例化PopoverViewController并返回
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? PopoverViewController else {
            fatalError("Something Wrong with Main.storyboard")
        }
        return viewcontroller
    }
}
