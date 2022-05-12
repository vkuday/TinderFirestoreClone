//
//  RegistrationViewModel.swift
//  TinderFirestoreClone
//
//  Copyright © 2022 Volkan Kuday. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableIsRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false && bindableImage.value != nil
        bindableIsFormValid.value = isFormValid
    }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { [unowned self] result, err in
            if let err = err {
                completion(err)
                return
            }
            
            print("Successfully registered user:", result?.user.uid ?? "")
            self.saveImageToFirebase(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> ()) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(filename)")
        let imageData = bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil) { _, err in
            if let err = err {
                completion(err)
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    completion(err)
                    return
                }
                self.bindableIsRegistering.value = false
                
                let imageUrl = url?.absoluteString ?? ""
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
                completion(nil)
            }
        }
    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData: [String: Any] = ["fullName": fullName ?? "", "uid": uid, "imageUrl1": imageUrl, "age": 18, "minSeekingAge": SettingsController.defaultMinSeekingAge, "maxSeekingAge": SettingsController.defaultMaxSeekingAge]
        Firestore.firestore().collection("users").document(uid).setData(docData) { error in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    // Reactive Programming
}
