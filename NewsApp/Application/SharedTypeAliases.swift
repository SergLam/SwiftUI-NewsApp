//
//  SharedTypeAliases.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 5/3/21.
//  Copyright © 2021 Serg Liamtsev. All rights reserved.
//

import UIKit

// typealias Localizable = R.string.localizable

typealias TypeClosure<T> = (T) -> Void

typealias VoidClosure = () -> Void
typealias VoidResultClosure = (Swift.Result<Void, Error>) -> Void

typealias TypeResult<T> = Swift.Result<T, Error>
typealias TypeResultClosure<T> = (Swift.Result<T, Error>) -> Void

public typealias DataUpdateInfo = [String: [String: Any]]
