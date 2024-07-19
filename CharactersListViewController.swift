import UIKit

class CharactersListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    private var characters: [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        ApiService.shared.fetchCharacters { [weak self] characters in
            guard let characters = characters, let self = self else { return }
            DispatchQueue.main.async {
                self.characters = characters
                self.tableView.reloadData()
            }
        }
    }

    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        let character = characters[indexPath.row]

        cell.textLabel?.text = character.name
        cell.detailTextLabel?.text = "\(character.status) | \(character.species) | \(character.gender)"
        if let imageUrl = character.imageUrl {
            ApiService.shared.fetchImage(from: imageUrl) { image in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    cell.imageView?.image = image
                }
            }
        }

        return cell
    }

    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "CharacterDetailViewController") as? CharacterDetailViewController else { return }
        detailVC.character = characters[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
