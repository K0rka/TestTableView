//
//  CellObject.swift
//  Realty.Search
//
//  Created by Ivan Erasov on 20.11.15.
//  Copyright © 2015 Rambler. All rights reserved.
//

import Foundation
import UIKit

/**
 *  Протокол объекта конфигурации ячеек таблицы
 */
protocol CellObject  {
    /*
    Метод получения идентификатора ячейки, используемой для отображения данных объекта
    */
    func cellReuseIdentifier() -> String
}

extension CellObject {
    
    /**
     Базовая реализация cellReuseIdentifier
     
     - returns: возвращается тип, реализующий протокол
     */
    func cellReuseIdentifier() -> String {
        return String(self.dynamicType)
    }
}