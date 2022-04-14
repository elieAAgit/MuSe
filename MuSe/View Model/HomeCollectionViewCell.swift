//
//  HomeCollectionViewCell.swift
//  MuSe
//
//  Created by Qattus on 14/04/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!

    let shape = CAShapeLayer()
    let trackShape = CAShapeLayer()
    var cellSelected = false

    let buttonColor = UIColor(named: "ButtonColor")!.cgColor
    let colorGrey = UIColor.lightGray.cgColor

    /// Name of the custom cell
    static let  nibName = "HomeCollectionViewCell"
    static let cellIdentifier = "homeCell"

    override func awakeFromNib() {
        super.awakeFromNib()

        config()
    }
    
    func getCategory(category: Category) {

        self.title.text = category.title
        self.image.image = UIImage(named: category.id)
    }

    override var isSelected: Bool {
        didSet {
            if cellSelected == false && isSelected == true {
                cellSelected = true
                trackShape.strokeColor = colorGrey
                animate(with: cellSelected)
                selectedCell(with: cellSelected)

            } else if cellSelected == true && isSelected == false {

            } else if cellSelected == true && isSelected == true {
                cellSelected = false
                trackShape.strokeColor = buttonColor
                animate(with: cellSelected)
                selectedCell(with: cellSelected)

            } else {
                cellSelected = false

            }
        }
    }

    private func config() {
        let cornerRadius = self.imageView.layer.frame.width / 2

        self.imageView.layer.cornerRadius = cornerRadius

        let centerPoint = CGPoint(x:self.imageView.bounds.midX, y: self.imageView.bounds.midY)

        let circlePath = UIBezierPath(arcCenter: centerPoint,
                                      radius: cornerRadius - 2,
                                      startAngle: -(.pi / 2),
                                      endAngle: .pi * 2,
                                      clockwise: true)

        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 2
        trackShape.strokeColor = colorGrey
        self.imageView.layer.addSublayer(trackShape)

        shape.path = circlePath.cgPath
        shape.lineWidth = 2
        shape.strokeColor = buttonColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        self.imageView.layer.addSublayer(shape)
    }
    
    private func selectedCell(with selected: Bool) {

        if selected == false {
            UIImageView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.transform = .identity
            }, completion: nil)

        } else {
            UIImageView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
                self.layer.zPosition = self.isSelected ? 1 : -1
                self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.2, y: 1.2) : CGAffineTransform.identity
            }, completion: nil)
        }
    }

    private func animate(with selected: Bool) {
        var circleColor: CGColor

        if selected == false {
            circleColor = colorGrey

        } else {
            circleColor = buttonColor
        }

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 0.5
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.strokeColor = circleColor
        shape.add(animation, forKey: "animation")
    }
}
