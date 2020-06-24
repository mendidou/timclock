//
//  CalendarViewController.swift
//  point
//
//  Created by mendy aouizerat  on 23/06/2020.
//  Copyright © 2020 mendy aouizerat . All rights reserved.
import FSCalendar
import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarRecap: FSCalendar!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarRecap.delegate = self
    }

}
extension CalendarViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
       // MARK: display entry time with action sheet
       // FirebaseModal.readDateFromFireBase(at: date, from: FirebaseModal.currentAuthName!, dateFormatter: DateFormatter(), inOrOut: "in") { (month, day, Time) in
        //    print(month)
         //   print(day)
         //   print(Time)
        //  }
        
    }
    
}
