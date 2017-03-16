//
//  NewVC.swift
//  Test
//
//  Created by Bunty on 07/03/17.
//  Copyright © 2017 Bunty. All rights reserved.
//

import UIKit

class NewVC: UIViewController  , UITextFieldDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAdd: UITextField!
    
    
    @IBOutlet weak var topHight: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtAdd.delegate = self
        txtName.delegate = self
        
        //keyboard show hide notification============
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillOpen(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillClose(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //===============end notification=============
    
    
        globle(value: 0)
        globle(value: "abc")
        globle(value: true)
    }
    
    
    func globle<T>(value : T){
        
        print("value ->\(value)")
        
    }
    
    
    var isOpenKeyboard : Bool = false
    func keyBoardWillOpen(notification: NSNotification) {
    
        if !isOpenKeyboard
        {
            isOpenKeyboard = true
            topHight.constant = topHight.constant - 210
            bottom.constant =  bottom.constant + 210
        }
    }

    func keyBoardWillClose( notification: NSNotification )  {

        topHight.constant = topHight.constant + 210
        bottom.constant =  0
        isOpenKeyboard = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
