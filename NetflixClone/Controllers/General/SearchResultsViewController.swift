//
//  SearchResultsViewController.swift
//  NetflixClone
//
//  Created by Alisher Djuraev on 14/07/22.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func SearchResultsViewControllerDidTapItem(_ viewModel: TitlePreviewViewModel)
}

class SearchResultsViewController: UIViewController {
    
    public var titles: [Title] = [Title]()
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultsColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width / 3) - 10
        layout.itemSize = CGSize(width: width, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(searchResultsColletionView)
        collectionConfiguration()
    }
    
    private func collectionConfiguration() {
        searchResultsColletionView.delegate = self
        searchResultsColletionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsColletionView.frame = view.bounds
    }
    
}

// MARK: - Collection View Configration, cells, rows and so ...

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        let titleOverview = title.overview ?? ""
        APICaller.shared.getMovie(with:titleName) { [weak self] result in
            switch result {
            case .success(let video):
                self?.delegate?.SearchResultsViewControllerDidTapItem(TitlePreviewViewModel(title: titleName, youtubeView: video, titleOverview: titleOverview))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
