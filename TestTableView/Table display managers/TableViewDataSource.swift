//
//  TableViewDataSource.swift
//  Realty.Search
//
//  Created by Ekaterina Korovkina on 21.11.15.
//  Copyright © 2015 Rambler. All rights reserved.
//

import Foundation
import UIKit

/*
Класс, реализующий все методы, необходимые для конфигурации и работы с таблицей
*/
class TableViewDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    /*
    Структура данных для таблицы, исходя из которой выбирается тип/количество ячеек и хэдеров/футеров
    */
    var dataStruture : TableViewDataSourceStructure
    
    /*
    Делегат, которому, при его наличии, будет перенаправляться часть вызовов UITableViewDelegate
    */
    var delegate : UITableViewDelegate!
    
    init(withDataStructure dataStruct : TableViewDataSourceStructure) {
        dataStruture = dataStruct
        super.init()
    }
    
    init(withDataStructure dataStruct : TableViewDataSourceStructure, localDelegate : UITableViewDelegate) {
        delegate = localDelegate
        dataStruture = dataStruct
        super.init()
    }
    
    /**
     Настроить для работы с переданной таблицей
     
     - parameter tableView: таблица
     */
    func assignToTableView(tableView: UITableView) {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Здесь нет проверки на возврат nil потому как если внезапно для indexPath, который существует для таблицы, вернулся пустой cellObject, это наша явная проблема и надо упасть еще в моменте дебага
        
        let cellObject = self.dataStruture.cellObjectAtIndexPath(indexPath)!
        
        let reuseIdentifier = cellObject.cellReuseIdentifier()
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)
        
        if let configurableCell = cell as? ConfigurableView {
            configurableCell.configureViewWithObject(cellObject)
        }
        
        return cell!
        
    }


    //Методы написаны для того, чтобы в случае, когда хэдер или футер отстутсвуют, не создавались системные отступы
    func tableView(tableView : UITableView, estimatedHeightForFooterInSection section : Int) -> CGFloat {
        if self.dataStruture.footerObjectForSection(section) != nil {
            return tableView.estimatedSectionFooterHeight
        }
        return  0
    }

    func tableView(tableView : UITableView, estimatedHeightForHeaderInSection section : Int) -> CGFloat {
        if self.dataStruture.headerObjectForSection(section) != nil {
            return tableView.estimatedSectionHeaderHeight
        }
        return  0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataStruture.numberOfObjectsAtSection(section)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataStruture.numberOfSections()
    }
    
    // MARK: - UITableViewDelegate
    

    
    // MARK: - UITableViewDelegate
    
     func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerObject = self.dataStruture.headerObjectForSection(section)
        
        if let unwrapperdHeaderObject = headerObject {
            
            let identifier = unwrapperdHeaderObject.headerReuseIdentifier()
            let header = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifier)
            
            if let configurableHeader = header as? ConfigurableView {
                configurableHeader.configureViewWithObject(unwrapperdHeaderObject)
            }
            
            return header
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerObject = self.dataStruture.footerObjectForSection(section)
        
        if let unwrapperdFooterObject = footerObject {
            
            let identifier = unwrapperdFooterObject.footerReuseIdentifier()
            let footer = tableView.dequeueReusableHeaderFooterViewWithIdentifier(identifier)
            
            if let configurableFooter = footer as? ConfigurableView {
                configurableFooter.configureViewWithObject(unwrapperdFooterObject)
            }
            
            return footer
        }
        
        return nil
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.tableView?(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return delegate?.tableView?(tableView, willSelectRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        delegate?.tableView?(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    // MARK: - ScrollView
    func scrollViewDidScroll(scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll?(scrollView)
    }
}