//
//  CWSLViewControllerRepresenter.swift
//  Olympic
//
//  Created by Kentaro Kawai on 2022/09/03.
//

import SwiftUI

struct CWSLViewControllerRepresenter: UIViewControllerRepresentable {

    var viewController: UIViewController

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func makeUIViewController(context: Self.Context) -> UIViewController {
        return self.viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Self.Context) {

    }
}
