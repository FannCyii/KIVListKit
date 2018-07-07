//
//  ViewController.swift
//  Demo
//
//  Created by cheng on 2018/6/29.
//  Copyright © 2018年 cheng. All rights reserved.
//

import UIKit
import KIVListKit

class ViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.frame = self.view.frame
        tableView.tableFooterView = UIView()
        self.tableView.registerDefault()
        dataConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func dataConfig() {
        var sections = Array<KivTableViewSection>()
        
        let sec1 = KivTableViewSection()
        for i in 1...10 {
            let row = KivTableViewRow()
            row.cellClassType = Custom1TableViewCell.self
            row.codeType = .code
            row.height = 20.0*Double(i)
            row.data = "this is cell \(i)";
            sec1.add(row)
        }
        
        for _ in 1...10 {
            sections.append(sec1)
        }
        
        self.tableView.addSections(newSections: sections)
        self.tableView.kiv_reloadData()
        
    }

}

