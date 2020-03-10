import Foundation

protocol Api {
    func api(host: String)
    
    func tennisResults(with params: SearchParams,
                       then: ((TennisResults) -> Void)?,
                       fail: ((Error) -> Void)?) // catch is a reserved word so we can't use that.
    
    func tennisSchedules(with params: String,
                         then: ((TennisSchedules) -> Void)?,
                         fail: ((Error) -> Void)?) // catch is a reserved word so we can't use that.
    
    func tennisLiveSummaries(with params: String,
                             then: ((TennisSummaries) -> Void)?,
                             fail: ((Error) -> Void)?) // catch is a reserved word so we can't use that.
    
}

class ApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }
    
    func tennisResults(with params: SearchParams,
                       then: ((TennisResults) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = then{
            callback(TennisResults(results: [SportEvent(sport_event: Info(scheduled: "2019-09-20", tournament: Tournament(name:"ITF USA F28, Men Singles"), competitors: [Competitors(name: "Axel Geller",
                                                                                                                                                                                      nationality: "Argentina",
                                                                                                                                                                                      bracket_number: 5,
                                                                                                                                                                                      qualifier: "home"),
                                                                                                                                                                          Competitors(name: "Ronald Hohmann",
                                                                                                                                                                                      nationality: "USA",
                                                                                                                                                                                      bracket_number: 7,
                                                                                                                                                                                      qualifier: "away")
            ]), sport_event_status: Score(home_score: 1, away_score: 2))]))
        }
    }
    
    func tennisSchedules(with params: String,
                         then: ((TennisSchedules) -> Void)?,
                         fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(TennisSchedules(sport_events: [SportEvent2(scheduled: "2019-09-20",
                                                                tournament: Tournament2(name: "ITF USA F28, Men Singles"))
            ])
            )
        }
    }
    
    func tennisLiveSummaries(with params: String,
                             then: ((TennisSummaries) -> Void)?,
                             fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(TennisSummaries(summaries: [SportEvent3(sport_event: Info3(scheduled: "2019-09-20",
                                                                                tournament: Tournament3(name: "ITF USA F28, Men Singles"),
                                                                                competitors: [Competitors3(name: "Axel Geller", nationality: "Argentina",bracket_number: 5,qualifier: "home"), Competitors3(name: "Ronald Hohmann", nationality: "USA", bracket_number: 7, qualifier: "away")
            ])
                )]
            ))
        }
    }
}

