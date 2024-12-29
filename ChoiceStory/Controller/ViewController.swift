//
//  ViewController.swift
//  Quizzer
//
//  Created by parag on 25/12/24.
//

import UIKit


class ViewController: UIViewController {
    var storyBrain = StoryBrain()
    var mainview = MainView()
    

    
    var progressWidthConstrainr:NSLayoutConstraint?
    
    var WINDOW_WIDTH:CGFloat? = nil
    
    
    
    func onAnswer(type:Int){
        let result = storyBrain.onAnswer(type)
        
//        onStartTimer(result.currentIndex + 1 )
    
        
        if(result.isGameOver){
            mainview.questions.text = "Story End!"
//            UIView.animate(withDuration: 0.5, animations: {
//                self.view.layoutIfNeeded()
//            })
            return;
        }
        
        onPrepairQuizDashBoard()
    }
    
    
    
    func onStartTimer(_ currentIndex:Int){
        guard let windowSize = WINDOW_WIDTH else {
            return;
        }
        let totalLength = (windowSize - 40)/CGFloat(storyBrain.getQuizzListCount())
        
        let currentProgress = totalLength * CGFloat(currentIndex)
        
        progressWidthConstrainr?.constant = currentProgress
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func onRestGame(){
        storyBrain.onReset()
//        onStartTimer(0)

        onPrepairQuizDashBoard()
    }
//    
//    func onUpdateScoreConstraints(_ layoutType:LayouType){
//        switch layoutType {
//        case .CENTER:
//            NSLayoutConstraint.deactivate(scoreInitialLayout ?? []);
//            NSLayoutConstraint.activate(scoreCenterLayout ?? []);
//            self.mainview.score.font = UIFont.systemFont(ofSize: 32)
//            break;
//        default:
//            mainview.score.font = UIFont.systemFont(ofSize: 16)
//            NSLayoutConstraint.activate(scoreInitialLayout ?? []);
//            NSLayoutConstraint.deactivate(scoreCenterLayout ?? []);
//            
//        }
//    }
    
    func onPrepairQuizDashBoard(){
        //add next question
        mainview.questions.text = storyBrain.getNextQuestion()
        //first remove previous arranged view
        mainview.VStack.arrangedSubviews.forEach{$0.removeFromSuperview()}
        
        storyBrain.getOptions().forEach{ans in
            var backImg:String = ""
            if(ans.key == "choice1"){
                backImg = "choice1Background"
            }else {
                backImg =   "choice2Background"
            }
            mainview.VStack.addArrangedSubview(mainview.Button(
                title: ans.value.option,
                image: backImg,
                type:ans.value.destination){type in
                    self.onAnswer(type: type)
                })
                //callback:onAnswer
        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            WINDOW_WIDTH = view.frame.width
            
            view.addSubview(mainview.ContainerBackground)
            view.addSubview(mainview.questions);
            view.addSubview(mainview.VStack);
            view.addSubview(mainview.resetGame)
          
            NSLayoutConstraint.activate([
                mainview.ContainerBackground.topAnchor.constraint(equalTo: view.topAnchor),
                mainview.ContainerBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                mainview.ContainerBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                mainview.ContainerBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
            
            mainview.resetGame.translatesAutoresizingMaskIntoConstraints = false
            mainview.resetGame.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true;
            mainview.resetGame.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
            mainview.resetGame.setTitle("Restart", for: .normal)
            
            mainview.resetGame.addAction(UIAction {[weak self] _ in
                self?.onRestGame()
            }, for: .touchUpInside)
         
            mainview.questions.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
        
                mainview.questions.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mainview.questions.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                mainview.questions.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                mainview.questions.bottomAnchor.constraint(equalTo: mainview.VStack.topAnchor)
            ])
            
        
            
            NSLayoutConstraint.activate([
                mainview.VStack.widthAnchor.constraint(equalToConstant: view.frame.width - 20),
                mainview.VStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
                mainview.VStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
            ])
            
            
            mainview.questions.numberOfLines = 0
            mainview.questions.textColor = .white
            mainview.questions.textAlignment = .center
            
            onPrepairQuizDashBoard()
        }
        
    }

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}




#Preview{
    ViewController()
}
