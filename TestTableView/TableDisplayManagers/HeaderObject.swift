//
//  HeaderObject.swift
//  Realty.Search
//
//  Created by Ekaterina Korovkina on 21.11.15.
//  Copyright © 2015 Rambler. All rights reserved.
//

import Foundation

/**
 *  Протокол объекта конфигурации хэдеров таблицы
 */
protocol HeaderObject {
    /*
    Метод получения идентификатора вьюшки, которая должна использоваться для отображения соответствующего хэдера
    */
    func headerReuseIdentifier() -> String
}

extension HeaderObject {
    
    /**
     Базовая реализация headerReuseIdentifier
     
     - returns: возвращается тип, реализующий протокол
     */
    func headerReuseIdentifier() -> String {
        return String(self.dynamicType)
    }
}