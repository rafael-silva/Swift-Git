import UIKit
//import CommonStack

final class RepositoryCell: UITableViewCell {
    
    private var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private var repositoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "-"
        label.textColor = UIColor(red: 26/255, green: 92/255, blue: 246/255, alpha: 1)
        return label
    }()
    
    private var repositoryStarsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "-"
        label.textColor = .darkGray
        return label
    }()
    
    private var repositoryIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var repositoryStarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "-"
        label.textColor = .darkGray
        return label
    }()
    
    private var ownerAvatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    private var viewModel: RepositoryCellViewModelProtocol?
    
    //MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        setupContainerView()
        setupIconImage()
        setupRepositoryTitleLabel()
        setupOwnerAvatarImage()
        setupOwnerNameLabel()
        setupRepositoryStarsImage()
        setupRepositoryStarsLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Override Apis
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        repositoryIconImage.image = nil
        repositoryStarsLabel.text = nil
        ownerNameLabel.text = nil
        repositoryIconImage.image = nil

        ownerAvatarImage.cancelImageLoad()
    }
    
    //MARK: Public Apis
    
    func configure(viewModel: RepositoryCellViewModelProtocol) {
        self.viewModel = viewModel
        setupBinds()
    }
    
    //MARK: Private Apis
    
    private func setupBinds() {
        
        viewModel?.repositoryTitle.bindAndFire { [weak self] title in
            guard let self = self else { return }
            self.repositoryTitleLabel.text = title
        }
        
        viewModel?.repositoryIcon.bindAndFire { [weak self] image in
            guard let self = self else { return }
            self.repositoryIconImage.image = image
        }
        
        viewModel?.ownerName.bindAndFire { [weak self] name in
            guard let self = self else { return }
            self.ownerNameLabel.text = name
        }
        
        viewModel?.ownerAvatar.bindAndFire { [weak self] imageUrl in
            guard let self = self, let imageUrl = imageUrl else { return }
            self.ownerAvatarImage.loadImage(at: imageUrl)
        }
        
        viewModel?.repositoryStars.bindAndFire { [weak self] starsCount in
            guard let self = self else { return }
            self.repositoryStarsLabel.text = String(format: "%.01f", locale: Locale.current, starsCount ?? 0)
        }
        
        viewModel?.repositoryStars.bindAndFire { [weak self] starsCount in
            guard let self = self else { return }
            self.repositoryStarsLabel.text = String(format: "%.01f", locale: Locale.current, starsCount ?? 0)
        }
        
        viewModel?.repositoryStar.bindAndFire { [weak self] image in
            guard let self = self else { return }
            self.repositoryStarImage.image = image
        }
            
    }
}

//MARK: - Extension Contraints

extension RepositoryCell {
    
    private func setupContainerView() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupIconImage() {
        containerView.addSubview(repositoryIconImage)
        
        repositoryIconImage.snp.makeConstraints {
            $0.top.equalTo(30)
            $0.leading.equalTo(15)
            $0.bottom.equalTo(-120)
        }
    }
    
    private func setupRepositoryTitleLabel() {
        containerView.addSubview(repositoryTitleLabel)
        
        repositoryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(18)
            $0.leading.equalTo(repositoryIconImage.snp.trailing).offset(10)
            $0.trailing.equalTo(-15)
        }
    }
    
    private func setupRepositoryStarsImage() {
        containerView.addSubview(repositoryStarImage)
        
        repositoryStarImage.snp.makeConstraints {
            $0.leading.equalTo(ownerNameLabel.snp.trailing).offset(25)
            $0.centerY.equalTo(ownerNameLabel)
            $0.height.width.equalTo(13)
        }
    }
    
    private func setupRepositoryStarsLabel() {
        containerView.addSubview(repositoryStarsLabel)
        
        repositoryStarsLabel.snp.makeConstraints {
            $0.leading.equalTo(repositoryStarImage.snp.trailing).offset(5)
            $0.centerY.equalTo(repositoryStarImage)
        }
    }
    
    private func setupOwnerNameLabel() {
        containerView.addSubview(ownerNameLabel)
        
        ownerNameLabel.snp.makeConstraints {
            $0.leading.equalTo(15)
            $0.bottom.equalTo(-18)
        }
    }
    
    private func setupOwnerAvatarImage() {
        containerView.addSubview(ownerAvatarImage)
        
        ownerAvatarImage.snp.makeConstraints {
            $0.trailing.equalTo(-15)
            $0.bottom.equalTo(-18)
            $0.height.width.equalTo(25)
        }
    }
    
}
