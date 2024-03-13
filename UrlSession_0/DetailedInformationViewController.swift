//
//  DetailedInformationViewController.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 10.03.2024.
//

import UIKit

class DetailedInformationViewController: UIViewController {
    
    @IBOutlet var detailedImage: UIImageView!
    @IBOutlet var titleArticle: UILabel!
    @IBOutlet var abstractArticle: UILabel!
    @IBOutlet var sourceArticle: UILabel!
    @IBOutlet var publishedDateArticle: UILabel!
    @IBOutlet var updatedArticle: UILabel!
    @IBOutlet var byLineArticle: UILabel!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleArticle.numberOfLines = 3
        abstractArticle.numberOfLines = 10
        
        publishedDateArticle.sizeToFit()
        
        titleArticle.text = article?.title
        abstractArticle.text = article?.abstract
        sourceArticle.text = article?.source
        publishedDateArticle.text = "Date of publication: \(article?.publishedDate ?? "")"
        updatedArticle.text = "Date of change: \(article?.updated ?? "no changes")"
        byLineArticle.text = article?.byline
        
        DispatchQueue.global().async {
            guard let urlImage = self.article?.media?.first?.mediaMetadata?.last?.url else { return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }
            
            DispatchQueue.main.async {
                self.detailedImage.image = UIImage(data: imageData)
            }
        }
    }
}
