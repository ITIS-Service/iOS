//
//  EventHandlerWrapper.swift
//  ITISService
//
//  Created by Timur Shafigullin on 18/12/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

class EventHandlerWrapper<T: AnyObject, U>: Invocable, Disposable {
    
    weak var target: T?
    let handler: Event<U>.EventHandler
    let event: Event<U>
    
    init(target: T?, handler: @escaping Event<U>.EventHandler, event: Event<U>) {
        self.target = target
        self.handler = handler
        self.event = event
    }
    
    func invoke(data: Any) {
        if self.target != nil {
            self.handler(data as! U)
        }
    }
    
    func dispose() {
        self.event.eventHandlers = self.event.eventHandlers.filter { $0 !== self }
    }
}
