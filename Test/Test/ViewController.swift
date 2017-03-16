//
//  ViewController.swift
//  Test
//
//  Created by Bunty on 02/03/17.
//  Copyright © 2017 Bunty. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    
    @IBOutlet weak var tableView: UITableView!
    
    var text : [String] = ["Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ..." , "Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ..." , "Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ... " , "Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ..." , "Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ..." , "Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ... Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ...Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ..." , "Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ...Mar 22, 2016 - Tips and techniques for iOS and Mac development - Weekday mornings at 9:42 AM. The goal of each of these 'bites' is to give the reader a brief overview or ... #217: Growing Height Text Views with NextGrowingTextView ... More info about NextGrowingTextView can be found at git.io/growingtextview ..."]
    
    var numOfLine : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
     
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        tableView.separatorColor = UIColor.red
        tableView.tableFooterView = UIView()
        
        for _ in 0..<text.count
        {
           numOfLine.append(2)
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return text.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let lbl = cell.viewWithTag(1) as! UILabel
        lbl.text = text[indexPath.row]
        lbl.numberOfLines = numOfLine[indexPath.row]
        
        let btn = cell.viewWithTag(2) as! UIButton
        if numOfLine[indexPath.row] == 0
        {
            btn.isHidden = true
        }
        else
        {
            btn.isHidden = false
        }
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if numOfLine[indexPath.row] == 0
        {
            numOfLine[indexPath.row] = 1
        }
        else
        {
            numOfLine[indexPath.row] = 0
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        let alret : FCAlertView = FCAlertView()
        alret.showAlert(inView: self, withTitle: "title", withSubtitle: "subtitle text", withCustomImage: #imageLiteral(resourceName: "close-round.png"), withDoneButtonTitle: "OK", andButtons: nil)
        alret.tintColor = UIColor.black
        
    }
    
    @IBAction func btnClick(_ sender: Any) {
        
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)!

        
        if numOfLine[indexPath.row] == 0
        {
            numOfLine[indexPath.row] = 1
        }
        else
        {
            numOfLine[indexPath.row] = 0
        }
        
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

