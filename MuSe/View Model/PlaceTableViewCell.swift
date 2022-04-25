//
//  PlaceTableViewCell.swift
//  MuSe
//
//  Created by Qattus on 13/04/2022.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var category: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!

    /// Name of the custom cell
    static let  nibName = "PlaceTableViewCell"
    static let cellIdentifier = "placeCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getInfo(place: Place) {
        self.category?.image = UIImage(named: place.category?.id ?? Images.defaultImage.rawValue)
        self.title.text = place.title
        self.detail.text = place.category?.title
    }
}
