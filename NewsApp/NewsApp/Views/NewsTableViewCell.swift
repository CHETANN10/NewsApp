//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import UIKit
import SDWebImage

// NewsTableViewCellProtocol is used for update the UI of NewsTableViewCellProtocol
protocol NewsTableViewCellProtocol {
    func newsData(doc: NewsModel)
}

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.newsImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Loading the data to view
extension NewsTableViewCell: NewsTableViewCellProtocol{
    
    func newsData(doc: NewsModel) {
        self.publishedDateLabel.text = doc.date?.toMonthYearString()
        self.newsTitleLabel.text = doc.headLine
        self.newsDescriptionLabel.text = doc.description
        guard let imageLink = doc.imageUrl else { return }
        self.newsImageView.sd_setImage(with: URL(string: (ApiEndpoint.imageBaseUrl + imageLink))!)
    }
}
