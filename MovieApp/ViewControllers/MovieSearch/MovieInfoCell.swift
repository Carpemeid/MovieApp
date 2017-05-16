//
//  MovieInfoCell.swift
//  MovieApp
//
//  Created by Dan Andoni on 16.05.17.
//  Copyright © 2017 Dan Andoni. All rights reserved.
//

import UIKit
import SDWebImage

class MovieInfoCell: UITableViewCell {
  static let identifier = "movieInfoCell"
  
  //MARK:- Outlets
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var movieNameLabel: UILabel!
  @IBOutlet weak var movieReleaseDateLabel: UILabel!
  @IBOutlet weak var movieOverviewLabel: UILabel!
  
  func configure(with movieInfo: MovieInfo) {
    movieNameLabel.text = movieInfo.title
    movieOverviewLabel.text = movieInfo.overview
    
    if let urlString = movieInfo.fullPosterPath,
      let url = URL(string: urlString) {
      posterImageView.sd_setImage(with: url)
    } else {
      //resetting the imageview in case the cell is recycled and no valid url is available
      posterImageView.image = nil
    }
    
    if let releaseDate = movieInfo.releaseDate {
      movieReleaseDateLabel.text = String(date: releaseDate, format: DateFormatter.movieInfoDisplayFormat)
    }
  }
}
