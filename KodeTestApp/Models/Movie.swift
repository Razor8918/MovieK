//
//  Movie.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 08.02.2022.
//

import Foundation

struct Movie: Decodable {
    let imageData: Data?
    let title: String?
    let description: String?
}
