//
//  TableViewDataSourceStructure.swift
//  Realty.Search
//
//  Created by Ekaterina Korovkina on 19.11.15.
//  Copyright © 2015 Rambler. All rights reserved.
//

import Foundation


class TableViewDataSourceStructure {
    
    var sectionsArray : [[CellObject]]
    var sectionsHeaders : [Int : HeaderObject]
    var sectionsFooters : [Int : FooterObject]
    
    init() {
        self.sectionsArray = Array()
        self.sectionsHeaders = Dictionary()
        self.sectionsFooters = Dictionary()
    }
    
    func cellObjectAtIndexPath(indexPath : NSIndexPath) -> CellObject? {
        
        //Проверка на то, что один из индексов выходит за границы имеющихся массивов
        if self.isIndexPathOutOfBounds(indexPath) {
            return nil
        }
        
        return self.sectionsArray[indexPath.section][indexPath.row]
    }
    
    func headerObjectForSection(section : Int) -> HeaderObject? {
        return self.sectionsHeaders[section]
    }
    
    func footerObjectForSection(section : Int) -> FooterObject? {
        return self.sectionsFooters[section]
    }
    
    func numberOfSections() -> Int {
        return self.sectionsArray.count
    }
    
    func numberOfObjectsAtSection(section : Int) -> Int {
        
        //В случае, если эта секция еще не существует, возвращаем 0
        if section >= self.sectionsArray.count {
            return 0
        }
        
        return self.sectionsArray[section].count
    }
    
    // MARK: - Методы для добавления секций
    
    /*
    Метод добавления в структуру таблицы новой пустой секции
    */
    func appendSection() {
        self.sectionsArray.append(Array())
    }
    
    /*
    Метод добавления в структуру таблицы новой секции с заданным хэдером
    */
    func appendSectionWithHeader(headerObject : HeaderObject) {
        self.appendSection()
        self.appendHeaderObject(headerObject)
    }
    
    /*
    Метод добавления в структуру таблицы новой секции с заданным массивом объектов для конфигурации ячеек
    */
    func appendSectionWithCellObjects(cellObjects : [CellObject]) {
        self.sectionsArray.append(cellObjects)
    }
    
    /*
    Метод добавления в структуру таблицы новой секции с заданным хэдером и массивом объектов для конфигурации ячеек
    */
    func appendSectionWithHeader(sectionHeader : HeaderObject?, cellObjects : [CellObject]) {
        self.appendSectionWithCellObjects(cellObjects)
        if sectionHeader != nil {
            self.appendHeaderObject(sectionHeader!)
        }
    }
    
    /*
    Добавить объект в текущую секцию
    */
    func appendCellObject(cellObject : CellObject) {
        
        var sectionContent = self.sectionsArray.last

        if sectionContent == nil {
            sectionContent = [cellObject]
            self.sectionsArray.append(sectionContent!)
        }
        else {
            sectionContent!.append(cellObject)
        }
        
        self.sectionsArray[self.sectionsArray.count - 1] = sectionContent!
    }
    
    /*
    Добавить хэдер к последней секции
    */
    func appendHeaderObject(headerObject : HeaderObject) {
        self.sectionsHeaders[self.sectionsArray.count - 1] = headerObject
    }
    
    /**
    Добавить футер к последней секции
    */
    func appendFooterObject(footerObject : FooterObject) {
        self.sectionsFooters[self.sectionsArray.count - 1] = footerObject
    }
    
    /*
    Добавить объект по заданному indexPath, если это возможно
    */
    func addCellObject(cellObject : CellObject, toIndexPath indexPath : NSIndexPath) {
        
        if indexPath.section < self.sectionsArray.count {
            
            var sectionContent = self.sectionsArray[indexPath.section]
            
            if indexPath.row <= sectionContent.count {
                sectionContent.insert(cellObject, atIndex: indexPath.row)
            }
            
            self.sectionsArray[self.sectionsArray.count - 1] = sectionContent
        }
        else if indexPath.section == self.sectionsArray.count && indexPath.row == 0 {
            self.appendSectionWithCellObjects([cellObject])
        }
    }
    
    /*
    Добавить хэдер к секции с заданным номером. Если такой секции не существует, то этот хэдер никогда не будет использован, однако, ошибки не произойдет
    */
    func addHeaderObject(headerObject : HeaderObject, toSection section : Int) {
        self.sectionsHeaders[section] = headerObject
    }
    
    /*
    Добавить футер к секции с заданным номером. Если такой секции не существует, то этот футер никогда не будет использован, однако, ошибки не произойдет
    */
    func addFooterObject(footerObject : FooterObject, toSection section : Int) {
        self.sectionsFooters[section] = footerObject
    }
    
    // MARK: - Вспомогательные методы
    
    /*
    Вспомогательная функция для определения, выходит ли заданный indexPath за границы существующей структуры
    */
    private func isIndexPathOutOfBounds(indexPath : NSIndexPath) -> Bool {
        
        if indexPath.section >= self.sectionsArray.count || indexPath.row >= self.sectionsArray[indexPath.section].count {
            return true
        }
        
        return false
    }
}