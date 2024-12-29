//
//  Types.swift
//  Quizzer
//
//  Created by parag on 27/12/24.
//

import Foundation

protocol ANSWERS  {
    var TRUE:Bool {get};
    var FALSE:Bool {get};

}

typealias options = [String:(option:String,destination:Int)]

struct Story {
    let title:String;
    var choice:options
}

struct MutipleChoice {
    let q:String;
    let a:[String]
    let correctAnswer:String
}

enum QUIZETYPE {
    case SINGLE
    case MULTIPLE
}

enum LayouType {
    case INITIAL
    case CENTER
}

enum COLORS:String{
     case PRIMARY = "#4B0082"
}

