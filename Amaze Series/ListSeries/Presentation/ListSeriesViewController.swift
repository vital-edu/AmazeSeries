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

class ListSeriesViewController: UITableViewController {
    var presenter: ListSeriesPresenterType
    private var dataSource: [Series]

    init(presenter: ListSeriesPresenterType) {
        self.presenter = presenter
        self.dataSource = []
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            SeriesTableViewCell.self,
            forCellReuseIdentifier: SeriesTableViewCell.identifier
        )

        presenter.onListSeriesPresented(on: self)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SeriesTableViewCell.identifier,
            for: indexPath
        )

        return cell
    }
}

extension ListSeriesViewController: ListSeriesViewControllerType {
    func onSeriesFetched(series: [Series]) {
        dataSource = series
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
