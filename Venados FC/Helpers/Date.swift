//
//  Date.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

extension Date {
    
    var months: [String] {
        return [
            "Enero",
            "Febrero",
            "Marzo",
            "Abril",
            "Mayo",
            "Junio",
            "Julio",
            "Agosto",
            "Septiembre",
            "Octubre",
            "Noviembre",
            "Diciembre"
        ]
    }
    
    var monthInt: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    var month: String {
        return self.months[self.monthInt]
    }
        
    func getProfessionalString()-> String{
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    func getDisplayDate()-> String{
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YY"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    func dayOfTheWeek() -> String? {
        let weekdays = [
            "Domingo",
            "Lunes",
            "Martes",
            "Miércoles",
            "Jueves",
            "Viernes",
            "Sábado"
        ]

        return weekdays[self.getIntOfTheWeak() - 1]
    }
    
    func getIntOfTheWeak() -> Int! {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: self)
        return weekDay
    }
    
    func getVenadosDate()-> String{
        var str = ""
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        
        formatter.dateFormat = "dd"
        
        str = formatter.string(from: self)
        str += " \n"
        str += self.dayOfTheWeek()!
        
        return str
    }
    
    func dayOfTheWeekOld() -> String? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    func RFC3339()-> String{
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    static func getFromProfessional(str: String!)-> Date{
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter.date(from: str)!
    }
    
}
