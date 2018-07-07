//
//  KIVList.swift
//  AddressService
//
//  Created by kivan on 05/05/2018.
//  Copyright © 2018 Kivan. All rights reserved.
//

import UIKit


extension UITableView{
    //添加section 并主持cell
    public func addSection(section:KivTableViewSection){
        self.sections.add(section);
        self.register(section: section)
    }
    
    public func addSections(newSections:Array<KivBaseItem>){
        for sec in newSections {
            self.addSection(section: sec as! KivTableViewSection)
        }
    }
    
    //更换section组
    public func exchangeSections(newSections:Array<KivBaseItem>){
        self.clearData()
        self.addSections(newSections: newSections)
    }
    
    //更换section 此时默认将所有sectios 更换为当前这个section
    public func exchange(newSection:KivTableViewSection){
        self.clearData()
        self.addSection(section: newSection);
    }
    
    public func insetSection(sections:Array<KivTableViewSection>){
        self.sections.addObjects(from: sections as [Any])
    }
    
    //MARK: - register cell  
    private func register(row:KivBaseItem) -> Void {
        if row.cellClassName.count == 0 {
            return
        }
        if self.registerCellList.contains(row.reusedIdentifier) {
            return;
        }
        
        if row.codeType == .nib {
            self.register(UINib.init(nibName: row.cellClassName, bundle: nil), forCellReuseIdentifier: row.reusedIdentifier)
        }else if row.codeType == .code{
//            self.register(NSClassFromString(row.cellClassName), forCellReuseIdentifier: row.reusedIdentifier)
            self.register(row.cellClassType, forCellReuseIdentifier: row.reusedIdentifier);
        }
        
        self.registerCellList.add(row.reusedIdentifier);
    }
    
    private func register(section:KivTableViewSection) -> Void {
        if section.cellClassType != nil {
            self.register(row: section as KivBaseItem)
        }
        
        if let tableviewrows:Array<KivBaseItem> = section.children{
            for tvRow in tableviewrows{
                let row = tvRow
                if row.cellClassType == nil && (section.cellClassType != nil){
                    row.cellClassType = section.cellClassType
                }
                self.register(row: row)
            }
        }
    }
    
    private func reigster(sections:Array<KivBaseItem>){
        if sections.count == 0 {
            return;
        }
        for sec in sections{
            self.register(section: sec as! KivTableViewSection)
        }
    }
    
    //MARK: - register datasouce and delegate
    func register(kivDatasouce:KIVTableListDataSouce) -> Void {
//        self.dataSource = kivDatasouce
//        self.delegate = kivDatasouce
        self.kiv_datasouce = kivDatasouce
        kivDatasouce.sections = self.sections
    }
    
    public func registerDefault(){
        self.dataSource = self.kiv_datasouce;
        self.delegate = self.kiv_datasouce;
        self.kiv_datasouce.sections = self.sections;
    }
    
    public func kiv_reloadData(){
        self.kiv_datasouce.sections = self.sections
        self.reloadData()
    }
}

//MARK: - UITableView 添加动态属性

//添加uitableview的存储属性结构体
private struct AssociatedStorageAttributes{
    static var tableViewSections:String = "associatedStorageAttributes.tableViewSections"
    static var tableViewDataSource:String = "associatedStorageAttributes.tableViewDataSource"
    static var tableViewRegisterCellList:String = "associatedStorageAttributes.registerCellList"
    static var tableViewCacheCellHeights:String = "associatedStorageAttributes.cache.cellheights"
}

extension UITableView{
    
    //MARK: 清除数据
    public func clearData(){
        self.sections = []
    }
    
    //MARK: add section storage attribute
    var sections:NSMutableArray{
        get{
            if self.associatedSection() == nil {
                self.associatedSection(sections: NSMutableArray())
            }
            return self.associatedSection()!
        }
        set{
            self.associatedSection(sections: newValue);
        }
    }
    
    private func associatedSection() -> NSMutableArray?{
        return getAttribute(keyName: &AssociatedStorageAttributes.tableViewSections) as? NSMutableArray ?? nil
    }
    private func associatedSection(sections:NSMutableArray){
        setAttribute(keyName: &AssociatedStorageAttributes.tableViewSections, value: sections, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    //MARK: add kiv_datasource storage attribute
    private var kiv_datasouce:KIVTableListDataSouce{
        get{
            if self.associatedDataSource() == nil {
                self.associatedDataSource(kivDataSource: KIVTableListDataSouce())
            }
            return self.associatedDataSource()!
        }
        set{
            self.delegate = newValue
            self.dataSource = newValue
            self.associatedDataSource(kivDataSource: newValue);
        }
    }
    
    private func associatedDataSource() -> KIVTableListDataSouce?{
        return getAttribute(keyName: &AssociatedStorageAttributes.tableViewDataSource) as? KIVTableListDataSouce ?? nil
    }
    private func associatedDataSource(kivDataSource:KIVTableListDataSouce){
        setAttribute(keyName: &AssociatedStorageAttributes.tableViewDataSource, value: kivDataSource, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    //MARK: add registerCellList storage attribute
    var registerCellList:NSMutableArray{
        get{
            if self.associatedRegisterCellList() == nil {
                self.associatedRegisterCellList(registerCellList: NSMutableArray())
            }
            return self.associatedRegisterCellList()!
        }
        set{
            self.associatedRegisterCellList(registerCellList: newValue);
        }
    }
    
    private func associatedRegisterCellList() -> NSMutableArray?{
        return getAttribute(keyName: &AssociatedStorageAttributes.tableViewRegisterCellList) as? NSMutableArray ?? nil
    }
    private func associatedRegisterCellList(registerCellList:NSMutableArray){
        setAttribute(keyName: &AssociatedStorageAttributes.tableViewRegisterCellList, value: registerCellList, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    //MARK: - height cache
    var cacheCellHeights:NSMutableDictionary{
        get{
            if self.associatedcacheCellHeights() == nil {
                self.associatedcacheCellHeights(cellHeights: NSMutableDictionary())
            }
            return self.associatedcacheCellHeights()!
        }
        set{
            self.associatedcacheCellHeights(cellHeights: newValue);
        }
    }
    
    private func associatedcacheCellHeights() -> NSMutableDictionary?{
        return getAttribute(keyName: &AssociatedStorageAttributes.tableViewCacheCellHeights) as? NSMutableDictionary ?? nil
    }
    
    private func associatedcacheCellHeights(cellHeights:NSMutableDictionary){
        setAttribute(keyName: &AssociatedStorageAttributes.tableViewCacheCellHeights, value: cellHeights, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func cellCatchkey(path:IndexPath)->String{
        return "key_\(path.section)_\(path.row)";
    }
    
    //MARK: Base
    private func getAttribute(keyName:inout String)->Any?{
        return AssociatedAttribute.associatedAttributs(object: self,keyAddress: &keyName)
    }
    
    private func setAttribute(keyName:inout String,value:Any,policy:objc_AssociationPolicy){
        AssociatedAttribute.associatedAttributs(object: self,keyAddress: &keyName, value:value, policy:policy)
    }
}


//动态添加 存储 属性
open class AssociatedAttribute{
    static  func associatedAttributs(object:Any, keyAddress:UnsafeRawPointer) ->Any?{
        return objc_getAssociatedObject(object, keyAddress)
    }
    
    static  func associatedAttributs(object:Any, keyAddress:UnsafeRawPointer,value:Any,policy:objc_AssociationPolicy){
        objc_setAssociatedObject(object, keyAddress, value, policy)
    }
}



