//
//  ListSeriesViewController.swift
//  Amaze Series
//
//  Created by Eduardo Vital Alencar Cunha on 28/12/2021.
//

import UIKit

protocol ListSeriesViewControllerType: AnyObject {
    var presenter: ListSeriesPresenterType { get }

    func onSeriesFetched(series: [Series])
}

class ListSeriesViewController: UIViewController {
    private struct ViewMetrics {
        static let cellSize = CGSize(width: 170, height: 239)
        static let sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        static let minimumLineSpacing = 5.0
        static let minimumInteritemSpacing = 5.0
        static let remainingItensBeforeLoading = 10
    }

    var presenter: ListSeriesPresenterType
    private var dataSource: [Series]
    private var canLoadNextPage = true

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = ViewMetrics.cellSize
        flowLayout.minimumInteritemSpacing = ViewMetrics.minimumInteritemSpacing
        flowLayout.minimumLineSpacing = ViewMetrics.minimumLineSpacing
        flowLayout.sectionInset = ViewMetrics.sectionInset

        let collectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: flowLayout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    init(presenter: ListSeriesPresenterType) {
        self.presenter = presenter
        self.dataSource = []
        super.init(nibName: nil, bundle: nil)

        buildLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(
            SeriesViewCell.self,
            forCellWithReuseIdentifier: SeriesViewCell.identifier
        )

        presenter.onListSeriesPresented(on: self)
    }
}

extension ListSeriesViewController: ListSeriesViewControllerType {
    func onSeriesFetched(series: [Series]) {
        dataSource = series
        collectionView.reloadData()
        canLoadNextPage = true
    }
}

extension ListSeriesViewController: ViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ListSeriesViewController: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
}

extension ListSeriesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SeriesViewCell.identifier,
            for: indexPath
        ) as? SeriesViewCell else {
            return UICollectionViewCell()
        }

        cell.setup(with: dataSource[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard canLoadNextPage else { return }

        if indexPath.item >= (dataSource.count - ViewMetrics.remainingItensBeforeLoading) {
            canLoadNextPage = false
            self.presenter.loadNextPage()
        }
    }
}
