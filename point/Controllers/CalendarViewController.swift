    //
    //  CalendarViewController.swift
    //  point
    //
    //  Created by mendy aouizerat  on 23/06/2020.
    //  Copyright © 2020 mendy aouizerat . All rights reserved.
    import FSCalendar
    import UIKit
    import FirebaseAuth
    import FirebaseDatabase


    class CalendarViewController: UIViewController {

        @IBOutlet weak var calendarRecap: FSCalendar!
        override func viewDidLoad() {
            super.viewDidLoad()
            calendarRecap.delegate = self
            
           
        }

    }

    extension CalendarViewController: FSCalendarDelegate{
        
        // run when the user click on a date on FSCalendar
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            let  formater = DateFormatter()
            formater.dateFormat = "LLLL"
           let nameOfMonth =  formater.string(from: date)
            performSegue(withIdentifier: "resumeSegue", sender: nameOfMonth)
            print(date)
        }
        // prepare for the segue 
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "resumeSegue" {
                if let dest = segue.destination as? ResumeDateTableViewController{
                    dest.actualleMonth = sender as? String
                }
            }

    }
     
    }
