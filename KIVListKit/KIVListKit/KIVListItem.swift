//
//  KIVListItemInterface.swift
//  AddressService
//
//  Created by 程启帆 on 04/05/2018.
//  Copyright © 2018 Kivan. All rights reserved.
//

import UIKit

public enum KIVItemType {
    case item,section,other
}

public enum KIVItemCodeType{
    case code,nib,storyboard
}


public enum KIVItemActionType{
    case onAction
    case selected
}

open class KivBaseItem {
    
    private func illegalInvokLog(functionName:Any){
        print("row can not invok the function:\(functionName)");
    }
    
    //MARK: - Row Property
    
    private var childItems:NSMutableArray = NSMutableArray()
    
    public func add(_ childItem:KivBaseItem) -> Void{
        if self.itemType == .item {
            self.illegalInvokLog(functionName: #function)
            return;
        }
        childItems.add(childItem);
    }
    
    public func insert(item childItem:KivBaseItem, at index:Int) -> Void{
        if self.itemType == .item {
            self.illegalInvokLog(functionName: #function)
            return;
        }
        childItems.insert(childItem, at:index)
    }
    
    public func remove(item childItem:KivBaseItem) {
        if self.itemType == .item {
            self.illegalInvokLog(functionName: #function)
            return;
        }
        childItems.remove(childItem);
    }
    
    public func remove(at index:NSInteger){
        childItems.removeObject(at: index)
    }
    
    public func at(index:Int)->KivBaseItem?{
        if self.itemType == .item {
            self.illegalInvokLog(functionName: #function)
            return nil;
        }
        if (childItems.count) < index{
            return nil
        }
        return childItems.object(at: index) as? KivBaseItem
    }
    
    public func addFirst(childItem:KivBaseItem){
        if self.itemType == .item {
            self.illegalInvokLog(functionName: #function)
            return;
        }
        self.insert(item: childItem, at: 0)
    }
    
    public func addLast(childitem:KivBaseItem) -> Void {
        if self.itemType == .item {
            self.illegalInvokLog(functionName: #function)
            return;
        }
        self.add(childitem)
    }
    
    public var children:(Array<KivBaseItem>?){
        get{
            if self.itemType == .item {
                return nil
            }else{
                return self.childItems as? Array<KivBaseItem>;
            }
        }
    }
    
    public var count:Int{
        get{
            if self.itemType == .section {
                return self.childItems.count;
            }else{
                return 0;
            }
        }
    }
    
    public var itemType:KIVItemType{
        get{
            return KIVItemType.item
        }
    }
    
    
    
    public var codeType:KIVItemCodeType = .code
    
    //cell property
    public var height = 0.0
    public var width = 0.0  // tableView中无效
    public var color = UIColor.white
    public var data:(Any)? = nil //转载原始数据,也可以通过继承baseitem 添加自定义数据属性
    
    public var reusedIdentifier:String {
        get{
            return  "reusedIdentifier_\(String(describing: cellClassType!))"
        }
    }
    
    
    public var cellClassName:String{
        get{
            return String(describing: cellClassType!)
        }
    }
    public var cellClassType:AnyClass?
//    var cellClassName:String{
//        get{
//            //Radar:https://medium.com/ios-os-x-development/types-and-meta-types-in-swift-9cd59ba92295
//            let str = NSStringFromClass(type(of: self))
//            let subStrArray = NSMutableArray()
//            if str.contains(".") {
//                subStrArray.addObjects(from: str.split(separator: "."))
//            }
//            return subStrArray.lastObject as! String
//        }
//        set(newCount){
//            //do nothing
//        }
//    }

    
    //MARK:- Item Action
    public var itemAction:((_ actionType:KIVItemActionType,_ at:IndexPath,_ data:Any?)->Void)?
    
}

open class KivTableViewRow:KivBaseItem{
    public override init() {
        super.init()
    }
    
    override public var itemType: KIVItemType {
        get{
            return KIVItemType.item
        }
    }
    
}

public class KivTableViewSection:KivBaseItem{
    
    public override init() {
        super.init()
    }
    
    override public var itemType: KIVItemType {
        get{
            return KIVItemType.section
        }
    }
}

public class KivaCollectionViewItem:KivBaseItem{
    override public var itemType: KIVItemType {
        get{
            return KIVItemType.item
        }
    }
}

public class KivaCollectionViewSection:KivBaseItem{
    override public var itemType: KIVItemType {
        get{
            return KIVItemType.section
        }
    }
}


