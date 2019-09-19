//
//  ViewController.swift
//  MegaSena
//
//  Created by Usuário Convidado on 18/09/19.
//  Copyright © 2019 Usuário Convidado. All rights reserved.
//

import UIKit
import Intents
import IntentsUI
import CoreServices
import CoreSpotlight

struct UserActivityType {
    static let GenerateMegaSenaNumbers = "com.dynararico.MegaSena.GenerateNumber"
}
class ViewController: UIViewController {

    @IBOutlet var balls: [UIButton]!
    
    lazy var activity: NSUserActivity = {
        let activity = NSUserActivity(activityType: UserActivityType.GenerateMegaSenaNumbers)
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.contentDescription = "Gerador de números da MegaSena"
        attributes.thumbnailData = UIImage(named: "ball")?.jpegData(compressionQuality: 1.0)
        activity.contentAttributeSet = attributes
        activity.title = "Gerador MegaSena"
        activity.isEligibleForSearch = true
        activity.isEligibleForPrediction = true
        activity.persistentIdentifier = UserActivityType.GenerateMegaSenaNumbers
        activity.suggestedInvocationPhrase = "Gerar número MegaSena"
        return activity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateNumbers()
    }

    @IBAction func generate(_ sender: UIButton) {
        generateNumbers()
    }
    
    func generateNumbers() {
        var numbers: [Int] = []
        while numbers.count < 6 {
            let number = Int.random(in: 1...60)
            if !numbers.contains(number) {
                numbers.append(number)
            }
        }
        
        numbers.sort()
        
        for (index, number) in numbers.enumerated() {
            balls[index].setTitle("\(number)", for: .normal)
        }
        
        userActivity = activity
        userActivity?.becomeCurrent()
    }
    
    @IBAction func addShortcut(_ sender: UIButton) {
        let shortcut = INShortcut(userActivity: activity)
        let vc = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}
