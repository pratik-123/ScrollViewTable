//
//  TableViewExVC.swift
//  Test
//
//  Created by Bunty on 16/03/17.
//  Copyright © 2017 Bunty. All rights reserved.
//

import UIKit

class TableViewExVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var cell = TableViewEXCell()
    
    let arrayList  = ["sdf","sadf" ,"sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf","sdf","sadf"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewEXCell
        
        cell.scrollView.delegate = self
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if (scrollView.contentOffset.x != 0)
        {
            cell.scrollView.contentOffset = scrollView.contentOffset
            
            let cellA = tableView.indexPathsForVisibleRows
            
            let startIndex : Int = (cellA?.first?.row)!
            let endIndex : Int = (cellA?.last?.row)!
            
            print("startIndex -> \(startIndex)")
            
            for i in startIndex..<endIndex
            {
                
                if (arrayList.count > 0) && ((arrayList.count > NSIndexPath(row: i, section: 0).row))
                {
                    
                    let cel : TableViewEXCell = tableView.cellForRow(at: NSIndexPath(row: i, section: 0) as IndexPath) as! TableViewEXCell
                   
                    cel.scrollView.contentOffset = scrollView.contentOffset
                }
            }
            
        }
        else
        {
            tableView.reloadData()
        }
        
    }


}
