//
//  GenreScreenViewController.swift
//  AwesomeSample
//
//  Created by Kap's on 20/06/20.
//  Copyright © 2020 Kapil. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreScreenViewController: UIViewController {
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer

    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBAction func genreButtonTapped(_ sender: UIButton) {
        
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.playGenre(genre: sender.currentTitle!)
                }
            } else if status == .denied {
                
                DispatchQueue.main.async {
                    let alertTitle = "Alert"
                    let alretMessage = "You should go now and give permission manually."
                    let alert = UIAlertController(title: alertTitle, message: alretMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        musicPlayer.stop()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        musicPlayer.skipToNextItem()    
    }
    
    func playGenre(genre: String) {
        
        musicPlayer.stop()
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        musicPlayer.shuffleMode = .songs
        musicPlayer.play()
    }
}
