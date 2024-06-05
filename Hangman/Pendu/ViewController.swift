//
//  ViewController.swift
//  Pendu
//
//  Created by Serge Miguet on 19/03/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print ("Un bouton a été cliqué")
        let pvc = segue.destination as! PenduViewController
        let b = sender as! UIButton // le bouton qui a été cliqué
        pvc.niveau = b.tag // le niveau de jeu est égal au tag du bouton
    }

}

