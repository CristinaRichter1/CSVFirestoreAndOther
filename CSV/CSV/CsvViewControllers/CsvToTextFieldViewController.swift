//
//  CsvToTextField.swift
//  CSV
//
//  Created by Cristina Richter on 14.01.2023.
//

import UIKit
import UniformTypeIdentifiers

class CsvToTextFieldViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var textFieldForCsv: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func importCsvToTextFieldBtn(_ sender: Any) {
        //specify the type of data that the app will be able to import
        let supportedFiles: [UTType] = [UTType.data] //import UniformTypeIdentifiers
        
        //open the view controller -> UIDocumentPickerDelegate
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: supportedFiles, asCopy: true)
        controller.delegate = self //UIDocumentPickerDelegate
        controller.allowsMultipleSelection = false
        present(controller, animated: true)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print("A file was selected")
        let rows = NSArray(contentsOfCSVURL: url, options: CHCSVParserOptions.sanitizesFields)!
        
        for row in rows {
            print(row)
            self.textFieldForCsv.text.append(contentsOf: "\(row)\n\n")
        }
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Message", message: "Success. The data is viewable in the output in xcode", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
}
