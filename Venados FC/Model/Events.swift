//
//  Events.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/4/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation
import EventKit
import UIKit

class EventManager {
    static func createEvent(_ title: String, startDate: Date, endDate: Date, note: String? = "", view: UIViewController? = nil){
        let eventStore : EKEventStore = EKEventStore()
        
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = note
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
                
                if(view != nil){
                    view?.alert(message: "Este evento ha sido guardado exitosamente.", title: title + ".")
                }
            }
            else{
                print("failed to save event with error : \(error!) or access not granted")
            }
        }
    }
}
