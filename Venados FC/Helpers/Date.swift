//
//  Date.swift
//  Venados FC
//
//  Created by Juan Carlos Estevez on 5/2/19.
//  Copyright © 2019 Juan Carlos Estevez. All rights reserved.
//

import Foundation

extension Date {
    
    /// Meses del año
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
    
    /// Valor Entero del mes de la fecha del objeto.
    var monthInt: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    /// String del mes de la fecha del objeto.
    var month: String {
        return self.months[self.monthInt]
    }
        
    /// Regresa un String con el formato "yyyy-MM-dd'T'HH:mm:ssZ" de la fecha del objeto.
    ///
    /// - Returns: String
    func getProfessionalString()-> String{
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    /// Regresa un String con el formato "dd MMMM YY" de la fecha del objeto.
    ///
    /// - Returns: String
    func getDisplayDate()-> String{
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YY"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    /// Regresa en día de la semana EEEE en Español.
    ///
    /// - Returns: String.
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
    
    /// Regresa el valor Entero del dia de la Semana.
    ///
    /// - Returns: Int.
    func getIntOfTheWeak() -> Int! {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: self)
        return weekDay
    }
    
    /// Regresa un String con el formato "dd \n EEEE" de la fecha del objeto.
    ///
    /// - Returns: String.
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
    
    /// Regresa un String con el formato "EEEE" de la fecha del objeto.
    ///
    /// - Returns: String.
    func dayOfTheWeekOld() -> String? {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        return formatter.string(from: self)
    }
    
    
    /// Regresa un Objeto Date de una cadena con formato "yyyy-MM-dd'T'HH:mm:ssZ".
    ///
    /// - Parameter str: String
    /// - Returns: Date
    static func getFromProfessional(str: String!)-> Date{
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter.date(from: str)!
    }
    
}
