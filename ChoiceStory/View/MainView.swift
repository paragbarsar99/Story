//
//  MainView.swift
//  Quizzer
//
//  Created by parag on 27/12/24.
//

import Foundation
import UIKit

class MainView {
    
    var container = UIView();
    var backgroundImage = UIImage();
    var backgorndImageContainer = UIImageView()
    var questions = UILabel();
    var score = UILabel();
    var resetGame = UIButton()
    func Button<T>(title:String,image:String,type:T,callback: @escaping (_ type:T) -> Void) -> UIButton{
        let btn = UIButton()
        let image = UIImage(named: image)

        btn.layer.cornerRadius = 6
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.contentMode = .scaleAspectFit
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setBackgroundImage(image, for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true;
        btn.addAction(UIAction {_ in
            callback(type)
        } , for: .touchUpInside)
        return btn
    }
    
    let VStack:UIStackView = {
        let stack = UIStackView();
        stack.axis = .vertical;
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let ContainerBackground:UIImageView = {
        let imgview = UIImageView();
        imgview.image = UIImage(named: "background");
        imgview.contentMode = .scaleAspectFill;
        imgview.translatesAutoresizingMaskIntoConstraints = false
        return imgview
    }()
    
    lazy var progressBar:UIView = {
        var view = UIView();
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true;
        view.backgroundColor = .yellow;
        view.layer.cornerRadius = 6
        return view
    }()
    
    
    
}

