//
//  Firestore.swift
//  CSV
//
//  Created by Cristina Richter on 11.01.2023.
//

import UIKit
import FirebaseFirestore

class FirestoreViewController: UIViewController {
    
    var firestoreDB: Firestore!
    @IBOutlet weak var textFieldForFirestoreData: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        firestoreDB = Firestore.firestore() //initialize the variable
    }
    
    @IBAction func getFirestoreDataBtn(_ sender: Any) {
        firestoreDB.collection("users").getDocuments() { (querySnapshot, err) in
            if let oErr = err {
                print("Error: \(oErr.localizedDescription)")
            }
            else {
                //we have a hierarchy (trebuie sa trecem prin fiecare document ca sa luam datele din fiecare pe rand.
                for document in querySnapshot!.documents {
                    //we iterate through the document
                    self.textFieldForFirestoreData.text.append(contentsOf: "\(document.documentID): \(document.data())\n\n")
                }
            }
        }
    }
    
    @IBAction func filterFirestoreDataBtn(_ sender: Any) {
        firestoreDB.collection("users").whereField("dob", isNotEqualTo: "1983").getDocuments(){(querySnapshot, err) in
            if let oErr = err{
                print("Error: \(oErr.localizedDescription)")
            }
            else {
                self.textFieldForFirestoreData.text = "" //sterg valorile de la rularea precedenta
                for document in querySnapshot!.documents {
                    self.textFieldForFirestoreData.text.append(contentsOf: "\(document.documentID): \(document.data())\n\n")
                }
            }
        }
    }
    
    @IBAction func addFirestoreDataBtn(_ sender: Any) {
        
        //CREATE WITH MERGE
        firestoreDB
            .collection("users")
            .document("admin")
            .setData(["firstName":"Cristina",
                      "lastName":"Richter",
                      "dob":"1978"], merge: true){
                //completion handler
                err in
                if let vErr = err {
                    print("Error: \(vErr)")
                }
                else {
                    print("document added")
                }
            }
        
        //fara MERGE
//        firestoreDB
//            .collection("users")
//            .document("admin")
//            .setData(["firstName":"Cristina",
//                      "lastName":"Richter",
//                      "dob":"1978"]){
//                //completion handler
//                err in
//                if let vErr = err {
//                    print("Error: \(vErr)")
//                }
//                else {
//                    print("document added")
//                }
//            }
        
//        //to get a randomized document number instead of "admin"
//        firestoreDB
//            .collection("users")
//            .addDocument(data:
//            ["firstName":"Helga",
//             "lastName":"Richter Love",
//             "dob":"1983"]) {
//                //completion handler
//                err in
//                if let vErr = err {
//                    print("Error: \(vErr)")
//                }
//                else {
//                    print("document added")
//                }
//            }
        //UPDATE a user
        firestoreDB
            .collection("users")
            .document("admin")
            .updateData(["firstName":"Cristina",
                         "lastName":"Richter",
                         "dob":"1987"]){
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
}
