//
//  MWLSegmentedFilter.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

class MWLSegmentedFilter: UIView {
    private let filters: [String]
    
    private var chips: [UIButton] = []
    
    
    
    weak var delegate: MWLSegmentedFilterDelegate?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .mwlGray.withAlphaComponent(0)
        stackView.layer.cornerRadius = 16
        stackView.layer.masksToBounds = true
        stackView.spacing = 12
        
        addBlueEffect(to: stackView)
        return stackView
    }()
    
    init(filters: [String]){
        self.filters = filters
        super.init(frame: .zero)
        setupUI()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createButton(_ text: String) -> UIButton {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false

        if let index = filters.firstIndex(of: text) {
            button.tag = index
        }

        button.configuration = .filled()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)

        button.configuration?.baseBackgroundColor = .clear

        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let atributedString = AttributedString(text, attributes: container)
        button.configuration?.attributedTitle = atributedString

        button.layer.cornerRadius = 13
        button.layer.masksToBounds = true

        return button
    }

    private func setupUI() {
        filters.forEach {
            chips.append(createButton($0))
        }
        setupHierarchy()
        setupConstraints()
        chips.forEach {
            addGestureDetector(to: $0)
        }
    }

    @objc
    func didTapFilter(_ button: UIButton) {
        setSelected(at: button.tag)
        delegate?.didTap(index: button.tag, name: filters[button.tag])
    }

    private func setButtonTitleColor(color: UIColor, to button: UIButton) {
        guard let text = button.configuration?.title, button.configuration != nil else {
            return
        }
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        container.foregroundColor = color

        button.configuration?.attributedTitle = AttributedString(
            text,
            attributes: container
        )
    }

    private func setSelected(at index: Int) {
        chips.forEach {
            $0.isSelected = false
            $0.configuration?.baseBackgroundColor = .clear
            setButtonTitleColor(color: .white, to: $0)
        }

        chips[index].isSelected = true
        chips[index].configuration?.baseBackgroundColor = .white

        setButtonTitleColor(color: .mwlGray, to: chips[index])

    }

    private func addGestureDetector(to button: UIButton) {
        button.addTarget(
            self,
            action: #selector(didTapFilter(_:)),
            for: .touchUpInside
        )
    }

    private func setupHierarchy() {
        addSubview(stackView)
        chips.forEach { stackView.addArrangedSubview($0) }
        setSelected(at: 0)
    }

    private func setupConstraints() {
        
        chips.forEach { 
            $0.heightAnchor.constraint(equalToConstant: 47).isActive = true
        }
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 47),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    private func addBlueEffect(to view: UIView) {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurView)
    }
}

protocol MWLSegmentedFilterDelegate: AnyObject {
    func didTap(index: Int, name: String)
}

#Preview {
    HomeVC(contentView: HomeView(),previousIndex: 1)
}
