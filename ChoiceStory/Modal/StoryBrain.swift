//
//  QuizBrain.swift
//  Quizzer
//
//  Created by parag on 27/12/24.
//

import Foundation

enum ResultType {
    case QUIZETYPE(QUIZETYPE)
    case MutipleChoice(MutipleChoice)
}

struct StoryBrain  {
    var quizeType:QUIZETYPE = QUIZETYPE.MULTIPLE
    let quizeList:[Story] = [
            Story(
                title: "He nods slowly, unfazed by the question.",
                choice: [
                    "choice1": (option: "At least he's honest. I'll climb in.", destination: 1),
                    "choice2": (option: "Wait, I know how to change a tire.", destination: 2)
                ]
            ),
            Story(
                title: "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box.",
                choice: [
                    "choice1": (option: "I love Elton John! Hand him the cassette tape.", destination: 4),
                    "choice2": (option: "It's him or me! You take the knife and stab him.", destination: 3)
                ]
            ),
            Story(
                title: "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?",
                choice: [
                    "choice1": (option: "The", destination: 0),
                    "choice2": (option: "End", destination: 0)
                ]
            ),
            Story(
                title: "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in.",
                choice: [
                    "choice1": (option: "The", destination: 0),
                    "choice2": (option: "End", destination: 0)
                ]
            ),
            Story(
                title: "You bond with the murderer while crooning verses of 'Can you feel the love tonight'. He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: 'Try the pier.'",
                choice: [
                    "choice1": (option: "The", destination: 0),
                    "choice2": (option: "End", destination: 0)
                ]
            )
]
    
    let mutipleChoiseQ:[MutipleChoice] = [
        MutipleChoice(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine", "Brain"], correctAnswer: "Skin"),
        MutipleChoice(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        MutipleChoice(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        MutipleChoice(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        MutipleChoice(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch","Nothing"], correctAnswer: "Watch"),
        MutipleChoice(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        MutipleChoice(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue","Red"], correctAnswer: "Orange"),
        MutipleChoice(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin","Vodka"], correctAnswer: "Rum"),
        MutipleChoice(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile",], correctAnswer: "Gorilla"),
        MutipleChoice(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    var currentIndex = 0
    var totalScore = 0
    var isGameOver = false
    
   mutating func checkAnswer(_ choiceDestination:Int){
       let haptic = Utils()
//       guard let keyOfOption = choiceDestination else {
//           return;
//       }
//       currentIndex = quizeList[currentIndex].choice[keyOfOption]?.destination ?? 0
       currentIndex = choiceDestination
       haptic.triggerImpactFeeback(style: .light)
    
    }
    
    mutating func onReset(){
        isGameOver = false;
        currentIndex = 0;
    }
    
    func getNextQuestion() -> String {
         return quizeList[currentIndex].title
    }
    
    mutating func pickQuizeType(_ type:QUIZETYPE){
        switch type {
        case .MULTIPLE:
            quizeType = QUIZETYPE.MULTIPLE
            break;
        default:
            quizeType = QUIZETYPE.SINGLE
        }
    }
    
    func getOptions() -> options{
        let currentQ = quizeList[currentIndex]
        return currentQ.choice
    }
    
    func getQuizzListCount() -> Int {
       return quizeList.count
    }
    
    //return updated question index
    mutating func onAnswer(_ ans:Int) -> (isGameOver:Bool,currentIndex:Int){
        if(isGameOver){
            return (isGameOver,currentIndex)
        }
        if(currentIndex == getQuizzListCount() - 1){
            isGameOver = true;
            checkAnswer(ans)
            return (isGameOver,currentIndex)
        }
        checkAnswer(ans)
        currentIndex += 1
        return (isGameOver,currentIndex)
    }
}
