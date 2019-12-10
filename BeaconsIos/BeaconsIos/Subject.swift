//
//  Subject.swift
//  BeaconsIos
//
//  Created by Max Hennen on 10/12/2019.
//  Copyright © 2019 Max Hennen. All rights reserved.
//

import Foundation

protocol SubjectName {
    var name: String { get }
}

enum Subject: Int, SubjectName, CaseIterable{
    case Software = 1, Media, Technology, Business

    var name: String {
        switch self {
        case .Software: return "Software"
        case .Media: return "Media"
        case .Technology: return "Technology"
        case .Business: return "Business"
        default : return "null"
        }
    }
}
