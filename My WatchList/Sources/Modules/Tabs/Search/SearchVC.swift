//
//  SearchVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 21/03/25.
//

import UIKit

class SearchVC: UIViewController {
    let contentView: SearchView
    weak var flowDelegate: TabBarFlowDelegate?
    
    init(contentView: SearchView, flowDelegate: TabBarFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

#Preview {
    SearchVC(contentView: SearchView())
}
