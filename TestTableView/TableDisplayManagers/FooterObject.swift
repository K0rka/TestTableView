//
//  FooterObject.swift
//  Realty.Search
//
//  Created by Ekaterina Korovkina on 21.11.15.
//  Copyright © 2015 Rambler. All rights reserved.
//

import Foundation

/**
 *  Протокол объекта конфигурации футеров секций таблицы 
 */
protocol FooterObject {
    /*
    Метод получения идентификатора вьюшки, которая должна использоваться для отображения соответствующего футера
    */
    func footerReuseIdentifier() -> String
}

extension FooterObject {
    
    /**
     Базовая реализация footerReuseIdentifier
     
     - returns: возвращается тип, реализующий протокол
     */
    func footerReuseIdentifier() -> String {
        return String(self.dynamicType)
    }
}