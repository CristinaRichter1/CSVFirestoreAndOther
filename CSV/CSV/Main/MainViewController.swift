//
//  ViewController.swift
//  CSV
//
//  Created by Cristina Richter on 11.01.2023.
//  Using a library from Github to export the data into an .csv file

import UIKit
import UniformTypeIdentifiers
///import FirebaseFirestore

class MainViewController: UIViewController,UIDocumentPickerDelegate {
    
    ///var firestoreDB: Firestore!
    @IBAction func unwindToHomeVC(sender : UIStoryboardSegue){ }

    override func viewDidLoad() {
        super.viewDidLoad()
        ///firestoreDB = Firestore.firestore() //initialize the variable
    }

    @IBAction func GenerateCSVFile(_ sender: Any) {
        //FILE NAME
        let sFileName = "test.csv"
        //DIRECTORY PATH
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String //[0] first index
        let documentURL = URL(fileURLWithPath: documentDirectoryPath).appendingPathComponent(sFileName)
        let output = OutputStream.toMemory()
        
        let csvWriter = CHCSVWriter(outputStream: output, encoding: String.Encoding.utf8.rawValue, delimiter: ",".utf16.first!)
        
        //MARK: create a csv file. The file will look like a table so we put rows and columns. We will create an employee record that will have an employee id, employee name, age, designation.
        
        //HEADER FOR THE CSV FILE
        csvWriter?.writeField("EMPLOYEE_ID")
        csvWriter?.writeField("EMPLOYEE_NAME")
        csvWriter?.writeField("EMPLOYEE_AGE")
        csvWriter?.writeField("EMPLOYEE_DESIGNATION")
        csvWriter?.finishLine() //we go to the next line \n
        
        //CREATE AN ARRAY AND PUT IN THE RECORDS array of Employees
        var arrayOfEmployeeData = [[String]]() //empty array of arrays of Strings
        
        // ADD RECORDS INTO THE ARRAY
        arrayOfEmployeeData.append(["123","John Doe","30","Sys Analyst"])
        arrayOfEmployeeData.append(["234","Jane Doe","44","HR"])
        arrayOfEmployeeData.append(["567","John Appleseed","40","Engineer"])
        
        //TAKE THE RECORDS WITHIN THE ARRAY INTO A CSV FILE
        for(elements) in arrayOfEmployeeData.enumerated(){
            csvWriter?.writeField(elements.element[0]) //added the employee ID
            csvWriter?.writeField(elements.element[1]) //added the employee name
            csvWriter?.writeField(elements.element[2]) //added the employee age
            csvWriter?.writeField(elements.element[3]) //added the employee designation
            csvWriter?.finishLine()
        }
        csvWriter?.closeStream()
        
        //WRITE THE DATA
        ///declare the buffer variable
        let buffer = (output.property(forKey: .dataWrittenToMemoryStreamKey) as? Data)!
        ///save the file somewhere
        do{
            try buffer.write(to: documentURL)
            showAlert()
        }
        catch {
            
        }
        
        func showAlert() {
            let alert = UIAlertController(title: "Message", message: "File created. It can be found in the Files folder on your phone", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
    }
    
    
    @IBAction func importCSV(_ sender: Any) {
        //mutat in CsvToTextField
    }
     
}

