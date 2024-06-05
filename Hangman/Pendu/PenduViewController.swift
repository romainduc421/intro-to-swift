//
//  PenduViewController.swift
//  Pendu
//
//  Created by Serge Miguet on 19/03/2024.
//

import UIKit

class PenduViewController: UIViewController {
    var first = 0, last = 0
    var lettresADeviner = 0
    var etape = 0
    
    var mots = [
        "AVION",
        "BANANE",
        "PROGRAMME",
        "CODER",
        "BUT"
    ]
    
    var secret : String = ""
    
    @IBOutlet weak var vignette: UIImageView!
    @IBOutlet weak var mot: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet var boutons: [UIButton]!
    
    func finPartie(_ chaine  : String) {
        message.text = chaine
        for b in boutons {
            b.isEnabled = false
        }
    }
    
    @IBAction func clic(_ sender: UIButton) {
        var trouve : Bool = false
        let lettre = sender.titleLabel!.text!
        print("Vous avez cliqué sur le bouton \(lettre)")
        sender.isEnabled = false // désactive le bouton
        var motCache : [Character] = [] // tableau vide
        for l in mot.text! {   // on recopie dans le tableau
            motCache.append(l) // tous les caractères du mot cache
        }
        var i = 0
        for l in secret {
            if i >= first && i <= last {
                if lettre == String(l) { // si la lettre correspond
                    trouve = true
                    motCache[i] = l // on dévoile la ième lettre du mot caché
                    lettresADeviner -= 1 // on décrémente le nombre de lettres à deviner
                    if lettresADeviner == 0 {
                        finPartie("Gagné !")
                    }
                }
            }
            i += 1
        }
        if !trouve { // si on n'a trouvé aucune occurence de lettre
            etape += 1 // on passe à l'étape suivante du gibet de potence
            print("On passe à l'étape \(etape) du gibet")
            vignette.image = UIImage(named: "pendu\(etape)")
            if etape == 11 {
                finPartie("Perdu !")
            }
        }
        mot.text = ""
        for l in motCache { // on recopie le tableau dans la chaîne
            mot.text! += String(l)
        }
    }
    
    var niveau : Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Nous sommes au niveau \(niveau)")
        secret = mots.randomElement()!
        print("Le mot à deviner est \(secret)")
        switch niveau {
        case 1: first = 1 ; last = secret.count - 2
        case 2: first = 1 ; last = secret.count - 1
        case 3: first = 0 ; last = secret.count - 1
        default: break
        }
        lettresADeviner = last - first + 1
        print ("Lettres à deviner : \(lettresADeviner)")
        mot.text = ""
        var i = 0 // numéro du caractère courant
        for l in secret {
            if i >= first && i <= last {
                mot.text! += "-"
            } else {
                mot.text! += String(l)
            }
            i += 1
        }
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
