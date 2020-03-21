//
//  SnipViewController.swift
//  Snip
//
//  Created by Rainer Selvet on 21/03/2020.
//  Copyright © 2020 Rainer Selvet. All rights reserved.
//

import Cocoa

class SnipViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textBox: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.font = NSFont(name: "Helvetica", size: 18)
        textBox.usesAdaptiveColorMappingForDarkAppearance = true
        self.textBox.textContainerInset = NSSize(width: 10, height: 10)
        // textBox.delegate = self;
    }

    /*
    func textDidChange(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        print(textView.string)
    }
    */
}

extension SnipViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> SnipViewController {
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    let identifier = NSStoryboard.SceneIdentifier("SnipViewController")
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? SnipViewController else {
      fatalError("Why cant i find SnipViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
