//
//  RecordSoundsViewController.swift
//  project1
//
//  Created by Osiem Teo on 18/02/1440 AH.
//  Copyright © 1440 Asma. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {
    var audioRecorder : AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var StopRecordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StopRecordButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func RecordButton(_ sender: Any) {
        recordingLabel.text = "recording in progress"
            StopRecordButton.isEnabled = true
            RecordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, mode: .default,options: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
   
    @IBAction func StopRecording(_ sender: Any) {
       
            RecordButton.isEnabled = true
            StopRecordButton.isEnabled = false
            recordingLabel.text = "tab to record"
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setActive(false)
        }
    
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            
        performSegue(withIdentifier: "StopRecording" , sender: audioRecorder.url )
    }
        else{
            print("RECORDING WASN'T SUCCESFULL")
        }
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL 
        }
        
    }
    
}
