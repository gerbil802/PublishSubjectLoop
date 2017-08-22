//
//  ViewController.swift
//  Testing
//
//  Created by Tal Shrestha on 02/08/2017.
//  Copyright © 2017 None. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa

class ViewController: NSViewController, NSMenuDelegate {
    
    var vm = ViewModel()
    var bag = DisposeBag()
    
    @IBOutlet weak var endButton: NSButton!
    @IBOutlet weak var bButton: NSButton!
    @IBOutlet weak var aButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vm.appState
            .debug("AppState")
            .subscribe{ [unowned self] event in
                switch event.element! {
                case .A:
                    self.bButton.isEnabled = false
                    self.endButton.isEnabled = true
                case .B:
                    self.aButton.isEnabled = false
                    self.endButton.isEnabled = true
                case .idle:
                    self.bButton.isEnabled = true
                    self.aButton.isEnabled = true
                    self.endButton.isEnabled = false
                case .end:
                    print("----------------")
                    self.vm.appInput.onNext(.goToIdle)
                }
        }.disposed(by: bag)
        
    }

    @IBAction func A(_ sender: Any) {
        self.vm.appInput.onNext(.inputToA)
    }
    
    @IBAction func B(_ sender: Any) {
        self.vm.appInput.onNext(.inputToB)
    }
    
    @IBAction func returnToIdle(_ sender: Any) {
        self.vm.appInput.onNext(.end)
    }
    
}

