import Siesta

class RealApiService: Api {
    
    
    let API_KEY = "uwrkajt3jcekgjwtkz3gb2qh"
    
    private var service = Service(
        baseURL: "https://api.sportradar.com/tennis-t2/en/schedules",
        standardTransformers: [.text, .image])
    
    init() {
        // Bare-bones logging of which network calls Siesta makes:
        SiestaLog.Category.enabled = [.network]
        SiestaLog.Category.enabled = SiestaLog.Category.all
        
        // For more info about how Siesta decides whether to make a network call,
        // and which state updates it broadcasts to the app:
        //SiestaLog.Category.enabled = SiestaLog.Category.common
        // For the gory details of what Siesta’s up to:
        //SiestaLog.Category.enabled = SiestaLog.Category.all
        // To dump all requests and responses:
        // (Warning: may cause Xcode console overheating)
        //SiestaLog.Category.enabled = SiestaLog.Category.all
    }
    
    func api(host: String) {
        service = Service(baseURL: host, standardTransformers: [.text, .image])
        
        let jsonDecoder = JSONDecoder()
        service.configureTransformer("/*/results.json") {
            try jsonDecoder.decode(TennisResults.self, from: $0.content)
        }
        
        service.configureTransformer("/*/schedule.json") {
            try jsonDecoder.decode(TennisSchedules.self, from: $0.content)
        }
        
        service.configureTransformer("/live/summaries.json") {
            try jsonDecoder.decode(TennisSummaries.self, from: $0.content)
        }
    }
    func tennisResults(with params: SearchParams,
                       then: ((TennisResults) -> Void)?,
                       fail: ((Error) -> Void)?) {
        service.resource(params.date).child("results.json")
            .withParam("api_key", API_KEY)
            .request(.get).onSuccess { result in
                if let searchResult: TennisResults = result.typedContent(),
                    let callback = then {
                    callback(searchResult)
                }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }
    
    func tennisSchedules(with params: String,
                         then: ((TennisSchedules) -> Void)?,
                         fail: ((Error) -> Void)?) {
        service.resource(params).child("schedule.json")
            .withParam("api_key", API_KEY)
            .request(.get).onSuccess { result in
                if let searchResult: TennisSchedules = result.typedContent(),
                    let callback = then {
                    callback(searchResult)
                }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }
    
    func tennisLiveSummaries(with params: String,
                             then: ((TennisSummaries) -> Void)?,
                             fail: ((Error) -> Void)?) {
        service.resource("/live/summaries.json")
            .withParam("api_key", API_KEY)
            .request(.get).onSuccess { result in
                if let searchResult: TennisSummaries = result.typedContent(),
                    let callback = then {
                    callback(searchResult)
                }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }
}

