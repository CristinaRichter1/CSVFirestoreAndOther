//
//  FirestoreViewControllerWithNumber.swift
//  CSV
//
//  Created by Cristina Richter on 12.01.2023.
//

import UIKit
import FirebaseFirestore

class FirestoreViewControllerWithNumber: UIViewController {
    
    var firestoreDB: Firestore!
    @IBOutlet weak var textFieldForFirestoreDataWithNumber: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        firestoreDB = Firestore.firestore() //initialize the variable
    }
    
    @IBAction func addDataToFirestoreWithNumber(_ sender: Any) {
        //CREATE WITH MERGE
        firestoreDB
            .collection("users")
            .document("admin")
            .setData(["firstName":"Cristina",
                      "lastName":"Richter",
                      "dobN":1978], merge:true){
                err in
                if let vErr = err {
                    print("Error: \(vErr)")
                }
                else {
                    print("document added")
                }
            }
        
        //UPDATE a user
        firestoreDB
            .collection("users")
            .document("admin")
            .updateData(["firstName":"Cristina",
                         "lastName":"Richter",
                         "dob":1987]){
                //completion handler
                err in
                if let vErr = err {
                    print("Error: \(vErr)")
                }
                else {
                    print("document added")
                }
            }
    }
    
    @IBAction func getDataToFirestoreWithNumber(_ sender: Any) {
        firestoreDB.collection("users").getDocuments { (querySnapshot, err) in
            if let oErr = err {
                print("Error: \(oErr.localizedDescription)")
            }
            else {
                for document in querySnapshot!.documents {
                    self.textFieldForFirestoreDataWithNumber.text.append(contentsOf: "\(document.documentID): \(document.data())\n\n")
                }
            }
        }
    }
    
    @IBAction func filterDataToFirestoreWithNumber(_ sender: Any) {
    }
}
