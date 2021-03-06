//
//  Event.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class Event<T> {
    
    typealias EventHandler = (T) -> ()
    
    // MARK: - Instance Properties
    
    var eventHandlers = [Invocable]()
    
    // MARK: - Instance Methods
    
    func raise(data: T) {
        self.eventHandlers.forEach { $0.invoke(data: data) }
    }
    
    func addHandler<U: AnyObject>(target: U, handler: @escaping EventHandler) -> Disposable {
        let wrapper = EventHandlerWrapper(target: target, handler: handler, event: self)
        
        self.eventHandlers.append(wrapper)
        
        return wrapper
    }
}
