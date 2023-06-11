//
//  String+Ext.swift
//  MyPlanner
//
//  Created by Furkan Sarı on 11.06.2023.
//

import Foundation

extension String {

    func toDate()-> Date? {
        
        let dateFormatter = DateFormatter()
        //dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "dd MMM EEEE, yyyy HH:mm"
        let date = dateFormatter.date(from: self)
        print("Extension:\(String(describing: date))")
        return date

    }
}
