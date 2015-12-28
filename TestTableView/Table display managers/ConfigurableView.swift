//
//  ConfigurableView.swift
//  Realty.Search
//
//  Created by Ekaterina Korovkina on 21.11.15.
//  Copyright © 2015 Rambler. All rights reserved.
//

import Foundation

/*
Протокол конфигурации объектов, использующийся для ячеек/хэдеров/футеров таблицы
*/
protocol ConfigurableView {
    /*
    Метод для конфигурации вьюшки с помощью некоторого объекта, конкретный тип которого известен только самой вью
    */
    func configureViewWithObject(object : Any)
}