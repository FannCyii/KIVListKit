//
//  KIVProxy.swift
//  AddressService
//
//  Created by 程启帆 on 05/05/2018.
//  Copyright © 2018 Kivan. All rights reserved.
//

import UIKit


public class KIVTableListDataSouce:NSObject,UITableViewDataSource,UITableViewDelegate{
    
    var sections:NSArray = [];
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return sections.count
    }
    
    //MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let kivSection:KivTableViewSection = sections.object(at: section) as! KivTableViewSection
        return kivSection.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let section:KivTableViewSection = sections.object(at: indexPath.section) as! KivTableViewSection
        let row = section.at(index: indexPath.row) as! KivTableViewRow
        var cell = tableView.dequeueReusableCell(withIdentifier: row.reusedIdentifier)
        if let kivCell = cell as? KivListBaseCellProtocol {
            kivCell.updateCell(data: row)
        }
        if cell == nil{
            cell = UITableViewCell()
        }
        return cell!
    }
    
    
    //MARK: - UITableViewDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightCache = tableView.cacheCellHeights;
        let catchKey = tableView.cellCatchkey(path: indexPath)
        if let tempHeight = heightCache.object(forKey: catchKey){
            return tempHeight as! CGFloat;
        }
        
        var cellHeight:CGFloat = 0;
        let section:KivTableViewSection = sections.object(at: indexPath.section) as! KivTableViewSection
        let row = section.at(index: indexPath.row) as! KivTableViewRow
        if let cellClass = row.cellClassType as? KivListBaseCellProtocol.Type{
            cellHeight = cellClass.cellHeight(data: row);
        }
        if cellHeight == 0.0 {
            cellHeight = CGFloat(row.height)
        }
        
        heightCache.setValue(cellHeight, forKey: catchKey)
        
        return cellHeight;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section:KivTableViewSection = sections.object(at: indexPath.section) as! KivTableViewSection
        let row = section.at(index: indexPath.row) as! KivTableViewRow
        if let itemAction = row.itemAction{
            itemAction(KIVItemActionType.selected,indexPath,row.data)
        }
    }

}

