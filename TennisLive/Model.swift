let TESTING_UI = "UI_TESTING"

struct SearchParams {
    let date: String
}


//RESULTS

struct TennisResults: Codable, Equatable {
    let results: [SportEvent]
}

struct SportEvent: Codable, Equatable {
    let sport_event: Info
    let sport_event_status: Score
}

struct Info: Codable, Equatable {
    let scheduled: String
    let tournament: Tournament
    let competitors: [Competitors]
}

struct Tournament: Codable, Equatable {
    let name: String
}

struct Competitors: Codable, Equatable {
    let name: String?
    let nationality: String?
    let bracket_number: Int?
    let qualifier: String?
}

struct Score: Codable, Equatable {
    let home_score: Int?
    let away_score: Int?
}


//SCHEDULES

struct TennisSchedules: Codable, Equatable {
    let sport_events: [SportEvent2]
}

struct SportEvent2: Codable, Equatable {
    let scheduled: String
    let tournament: Tournament2
    //    let competitors: [Competitors2]
}
struct Tournament2: Codable, Equatable {
    let name: String
}


//LIVE SUMMARIES

struct TennisSummaries: Codable, Equatable {
    let summaries: [SportEvent3]
}

struct SportEvent3: Codable, Equatable {
    let sport_event: Info3
}

struct Info3: Codable, Equatable {
    let scheduled: String
    let tournament: Tournament3
    let competitors: [Competitors3]
}
struct Tournament3: Codable, Equatable {
    let name: String
}

struct Competitors3: Codable, Equatable {
    let name: String?
    let nationality: String?
    let bracket_number: Int?
    let qualifier: String?
}

