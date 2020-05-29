import UIKit
import SnapKit

final class RepositoriesViewController: UIViewController {
    
    // MARK: Views

    private var tablewView: UITableView = {
        let table = UITableView()
        table.headerView(forSection: .zero)
        table.separatorStyle = .none
        table.backgroundColor = .groupTableViewBackground
        table.rowHeight = UITableView.automaticDimension
        table.register(RepositoryCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "AlNile-Bold", size: 40)
        label.textAlignment = .left
        label.text = "Repositories"
        label.textColor = .white
        return label
    }()
    
    let viewModel: RepositoriesViewModelProtocol
    
    private lazy var repositories: [Item] = []
    
    //MARK: Init
    
    init(viewModel: RepositoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Cycle View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tablewView.dataSource = self
        tablewView.prefetchDataSource = self
        
        tablewView.refreshControl = UIRefreshControl()
        tablewView.refreshControl?.addTarget(self, action:
            #selector(handleRefreshControl),
                                             for: .valueChanged)
        view.backgroundColor = UIColor(red: 26/255, green: 92/255, blue: 246/255, alpha: 1)
        
        setupTableView()
        setupHeaderTitle()
        
        viewModel.loadRepositories()
        setupBinds()
    }
    
    //MARK: - Private Apis
    
    //MARK: Bind View
    
    private func setupBinds() {
        
        viewModel.repositories.bind { [weak self] repositories in
            guard let self = self, let repositories = repositories else { return }
            self.repositories = repositories
            self.tablewView.reloadData()
        }
        
        viewModel.error.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            self.presentAlert(error, title: "Ops!")
        }
    }
    
    //MARK: - Private Actions
    
    //MARK: Refresh Controlls

    @objc private func handleRefreshControl() {
        viewModel.loadRepositories()
        
        DispatchQueue.main.async {
            self.tablewView.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: Loading actions

    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.numberOfRows()
    }
}

//MARK: - TableView DataSource

extension RepositoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoryCell else { fatalError("Unexpected Table View Cell") }
        
        if isLoadingCell(for: indexPath) {
            let viewModel = RepositoryCellViewModel(repository: .none)
            cell.configure(viewModel: viewModel)
        } else {
            let repository = repositories[indexPath.row]
            let viewModel = RepositoryCellViewModel(repository: repository)
            cell.configure(viewModel: viewModel)
        }
        
        return cell
    }
    
}

//MARK: - TableView DataSource Prefetching

extension RepositoriesViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.loadRepositories()
        }
    }
}

//MARK: - Extension Contraints

private extension RepositoriesViewController {
    
    private func setupTableView() {
        view.addSubview(tablewView)
        
        tablewView.snp.makeConstraints {
            $0.top.equalTo(180)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupHeaderTitle() {
        view.addSubview(headerTitleLabel)
        
        headerTitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(tablewView.snp.top).offset(-10)
            $0.leading.equalTo(20)
        }
    }
}

