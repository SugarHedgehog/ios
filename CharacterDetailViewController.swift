import UIKit

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var episodesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    var character: Character?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let character = character else { return }

        nameLabel.text = character.name
        statusLabel.text = character.status
        speciesLabel.text = character.species
        genderLabel.text = character.gender
        episodesLabel.text = character.episodeIds.map { String(\$0) }.joined(separator: ", ")
        locationLabel.text = character.locationName

        if let imageUrl = character.imageUrl {
            ApiService.shared.fetchImage(from: imageUrl) { image in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
