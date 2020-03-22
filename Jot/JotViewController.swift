//
//  JotViewController.swift
//  Jot
//
//  Created by Rainer Selvet on 21/03/2020.
//

import Cocoa

class JotViewController: NSViewController, NSTextViewDelegate {
    
    @IBOutlet var textBox: NSTextView!
    
    let defaults = UserDefaults.standard
    
    struct defaultsKeys {
        static let textContent = ""
    }

    override func viewDidAppear() {
        super.viewDidLoad()
        textBox.font = NSFont(name: "Helvetica", size: 14)
        textBox.usesAdaptiveColorMappingForDarkAppearance = true
        textBox.textContainerInset = NSSize(width: 10, height: 10)
        textBox.delegate = self;
        
        if let textContent = defaults.string(forKey: defaultsKeys.textContent) {
            textBox.string = textContent
        } else {
            textBox.string = ""
        }
   }
    
    func textDidChange(_ notification: Notification) {
        guard let textView = notification.object as? NSTextView else { return }
        defaults.set(textView.string, forKey: defaultsKeys.textContent)
    }
    
}

extension JotViewController {
  static func freshController() -> JotViewController {
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    let identifier = NSStoryboard.SceneIdentifier("JotViewController")
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? JotViewController else {
      fatalError("Cannot find JotViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
