/*let TESTING_UI = "UI_TESTING"

struct SearchParams {
    let date: String
}
*/

// Similarly, this is a subset of everything that comes back.
struct SearchResult: Codable, Equatable {
    let data: [Gif]
}

// You know the drill: another subset.
//     https://developers.giphy.com/docs/#gif-object
struct Gif: Codable, Equatable {
    let id: String
    let source_tld: String
    let images: Images
}

// https://developers.giphy.com/docs/#images-object
struct Images: Codable, Equatable {
    let fixed_width: FixedWidth
}

struct FixedWidth: Codable, Equatable {
    let url: String
}
