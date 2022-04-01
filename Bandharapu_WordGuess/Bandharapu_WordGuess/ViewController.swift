//
//  ViewController.swift
//  Bandharapu_WordGuess
//
//  Created by Bandharapu,Manish Goud on 3/31/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    
    @IBOutlet weak var wordsMissedLabel: UILabel!
    
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    
    @IBOutlet weak var totalWordsLabel: UILabel!
    
    @IBOutlet weak var userGuessLabel: UILabel!
    
    @IBOutlet weak var guessLetterField: UITextField!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var guessCountLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var guessLetterButtonPressed: UIButton!
    
    @IBOutlet weak var playAgainButtonPressed: UIButton!


    var words = [["LBNGR", "Smart Area"],["HYD","Best City"],["HUMAN", "Best Creature"],["RAJINI", "Synonym of style"],["INDIA", "Best Country"]]
             
        var images = ["Lbnagar","Hyderabad","Human","Rajinikanth","India","Tryagain"]
    
    let maxNumOfWrongGuesses = 10
    var numofRemainingGuess = 11
    var Wordsareguessed = ""
    var Countguessed = 0
    var wordsGuessed = 0
    var Guessedlettersinword = ""
    var SearchedIndex = 0
    var Hintw = ""
    var wordsMissed = 0

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    Wordsareguessed = words[SearchedIndex][0]
    Hintw = words[SearchedIndex][1]
    hintLabel.text = "HINT: " + Hintw
    totalWordsLabel.text = "Total number of words in game: \(words.count)"
    wordsRemainingLabel.text = "Total number of words remaining in game: \(words.count)"
    upFormWordField()
    guessLetterButtonPressed.isEnabled = false
    playAgainButtonPressed.isHidden = true
}
    
    func upFormWordField() {
        var M = ""
        Guessedlettersinword += guessLetterField.text!
        
        for l in Wordsareguessed {
            if Guessedlettersinword.contains(l) {
                M = M + " \(l)"
            } else {
                M += " _"
            }
        }
        M.removeFirst()
        userGuessLabel.text = M
    }
    func UIUpdate(){
    guessLetterField.resignFirstResponder()
    guessLetterField.text = ""
}

    func CountChange(){
        wordsMissedLabel.text = "Total number of words guessed wrongly: \(wordsMissed)"
        wordsGuessedLabel.text = "Total number of words guessed successfully: \(wordsGuessed)"
        wordsRemainingLabel.text = "Total number of words remaining in game: \(words.count - (wordsGuessed + wordsMissed))"
    }

func letterGuessed() {
    upFormWordField()
    Countguessed += 1
    numofRemainingGuess = numofRemainingGuess - 1
    let LetterGuessed = guessLetterField.text!
//        if !guessedWord.contains(currentLetterGuessed) {
//            numberOfRemainingGuesses = numberOfRemainingGuesses - 1
//        }
    let M = userGuessLabel.text!
    if numofRemainingGuess == 0 {
        playAgainButtonPressed.isHidden = false
        guessLetterField.isEnabled = false
        guessLetterButtonPressed.isEnabled = false
        guessCountLabel.text = "You have used all the available guesses, Please start again"
        wordsMissed += 1
        CountChange()
        upIma()
    } else if !M.contains("_") {
        playAgainButtonPressed.isHidden = false
        guessLetterField.isEnabled = false
        guessLetterButtonPressed.isEnabled = false
        guessCountLabel.text = "You won! It took you \(Countguessed) attempts to guess the word!"
        wordsGuessed += 1
        CountChange()
        upIma()
    } else {
        let h = ( Countguessed == 1 ? "Guess" : "Guesses")
        guessCountLabel.text = "You have made \(Countguessed) \(h)"
    }
    if (wordsGuessed + wordsMissed) == words.count {
        guessCountLabel.text = "Congratulations, You are done, Please start over again ?"
        upIma()
    }
}

@IBAction func guessLetterFieldChanged(_ sender: Any) {

    if let M = guessLetterField.text?.last {
        guessLetterField.text = "\(M)"
        guessLetterButtonPressed.isEnabled = true
    } else {
        
        guessLetterButtonPressed.isEnabled = false
    }
}


@IBAction func guessLetterButtonPressed(_ sender: Any) {
    letterGuessed()
    UIUpdate()
    let y = guessLetterField.text
    if y?.isEmpty == true{
        guessLetterButtonPressed.isEnabled = false
    }
    else{
        
        guessLetterButtonPressed.isEnabled = true
    }
}


@IBAction func playAgainButtonPressed(_ sender: Any) {
    imageView.isHidden = true
    SearchedIndex += 1
    if SearchedIndex == words.count {
        SearchedIndex = 0
        wordsGuessed = 0
        wordsMissed = 0
        CountChange()
    }
    Wordsareguessed = words[SearchedIndex][0]
    Hintw = words[SearchedIndex][1]
    hintLabel.text = "HINT: " + Hintw
    playAgainButtonPressed.isHidden = true
    guessLetterField.isEnabled = true
    guessLetterButtonPressed.isEnabled = false
    numofRemainingGuess = maxNumOfWrongGuesses + 1
    Guessedlettersinword = ""
    upFormWordField()
    guessCountLabel.text = "You have Made Zero Guessess"
    Countguessed = 0
}
func upIma(){
    if(numofRemainingGuess == 0){
        imageView.isHidden = false
        imageView.image = UIImage(named: images[5])
        let b = imageView.frame
        let n: CGFloat = 10
        let g: CGFloat = 10
        let r = CGRect(
        x: imageView.frame.origin.x + n,
        y: imageView.frame.origin.y + g,
        width: imageView.frame.width - n,
        height: imageView.frame.height - g)
        imageView.frame = r
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 11.0,  animations: {
                        self.imageView.frame = b
                    })
    }
    else{
        imageView.isHidden = false
        imageView.image = UIImage(named: images[SearchedIndex])
        let b = imageView.frame
        let n: CGFloat = 10
        let g: CGFloat = 10
        let r = CGRect(
        x: imageView.frame.origin.x + n,
        y: imageView.frame.origin.y + g,
        width: imageView.frame.width - n,
        height: imageView.frame.height - g)
        imageView.frame = r
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 11.0,  animations: {
                        self.imageView.frame = b
                    })
    }
}



}

