//
//  ViewController.swift
//  GradientAndShadow
//
//  Created by Margarita Slesareva on 01.02.2024.
//

import UIKit

private enum Constants {
    static let mainSize: CGFloat = 100
    static let cornerRadius: CGFloat = 15
    static let shadowRadius: CGFloat = 10
    static let shadowOffset: CGSize = .init(width: .zero, height: 10)
    static let shadowOpacity: Float =  0.8
    static let gradientStartPoint: CGPoint = .init(x: 0, y: 0)
    static let gradientEndPoint: CGPoint = .init(x: 0.7, y: 0.4)
    
    enum Colors {
        static let backgroundColor: UIColor = .white
        static let shadowColor: UIColor = .gray
    }
}

final class ViewController: UIViewController {
    
    private let squareView = UIView()
    private var viewIsLayedOutFirstTime = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     
        setupSubviewsIfNeeded()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        view.addSubview(squareView)
        
        squareView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            squareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.mainSize),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            squareView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: Constants.mainSize),
            squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor),
            squareView.heightAnchor.constraint(equalToConstant: Constants.mainSize)
        ])
        
        squareView.layer.cornerRadius = Constants.cornerRadius
    }
    
    private func setupSubviewsIfNeeded() {
        guard !viewIsLayedOutFirstTime else {
            return
        }
        
        setGradientBackground(from: .systemBlue, to: .systemRed)
        setShadow()
        
        viewIsLayedOutFirstTime = true
    }
    
    private func setGradientBackground(from startColor: UIColor, to endColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = Constants.gradientStartPoint
        gradientLayer.endPoint = Constants.gradientEndPoint
        gradientLayer.frame = squareView.bounds
        gradientLayer.cornerRadius = squareView.layer.cornerRadius
        
        squareView.layer.addSublayer(gradientLayer)
    }
    
    private func setShadow() {
        squareView.layer.shadowColor = Constants.Colors.shadowColor.cgColor
        squareView.layer.shadowOpacity = Constants.shadowOpacity
        squareView.layer.shadowOffset = Constants.shadowOffset
        squareView.layer.shadowRadius = Constants.shadowRadius
    }
}
