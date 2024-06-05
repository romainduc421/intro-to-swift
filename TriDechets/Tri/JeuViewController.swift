//
//  JeuViewController.swift
//  Tri
//
//  Created by Serge Miguet on 05/03/2024.
//

import UIKit

class JeuViewController: UIViewController {

    var objetTouch : Int = -1
    var poubelleSurvol : Int = -1
    var pointDeDepart : CGPoint = CGPoint(x:0,y:0) // coordonnées de l'objet au début du déplacement
    
    @IBOutlet var dechets: [UIImageView]!
    
    @IBOutlet var poubelles: [UIImageView]!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.randomElement()!
        let p = t.location(in: view)
        print("Vous avez touché l'écran en \(p.x), \(p.y)")
        var i = 0
        for d in dechets {
            if d.frame.contains(p) {
                print("Vous avez touché l'objet \(i)")
                objetTouch = i // on mémorise le numéro de l'objet touché
                pointDeDepart = d.center // on mémorise sa position
                return
            }
            i += 1
        }
        objetTouch = -1 // le doigt n'est pas dans un objet
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let t = touches.randomElement()!
        let p = t.location(in: view)
        if objetTouch != -1 {
            dechets[objetTouch].center = p // on place l'objet touché aux coordonnées du doigt
            for g in poubelles {
                if g.frame.contains(p) {
                    g.isHighlighted = true // on "illumine" la poubelle prête à recevoir un objet
                    poubelleSurvol = g.tag // on mémorise le numéro de la poubelle suvolée
                    return
                } else {
                    g.isHighlighted = false // on "éteint" la poubelle si le doigt n'est pas dedans
                    poubelleSurvol = -1 // poubelle pas survolée
                }
            }
        }
    }
    
    func retourAuDepart () {
        dechets[objetTouch].center = pointDeDepart
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        if objetTouch == -1 {
            return
        }
        if poubelleSurvol == -1 {
            retourAuDepart ()
            return
        }

        if dechets[objetTouch].tag == poubelles[poubelleSurvol].tag {
            dechets[objetTouch].isHidden = true
        } else {
            retourAuDepart ()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
