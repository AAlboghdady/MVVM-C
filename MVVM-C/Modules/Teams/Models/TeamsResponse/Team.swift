/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import GRDB

struct Team : Codable {
    
    var id : Int64?
    let name : String?
    let crestUrl : String?
    var competitionId : Int64?
    
	enum CodingKeys: String, CodingKey {
		case id = "id"
        case name = "name"
        case crestUrl = "crestUrl"
        case competitionId = "competitionId"
	}
    
    init(id: Int64?, name: String?, crestUrl: String?, competitionId: Int64?) {
        self.id = id
        self.name = name
        self.crestUrl = crestUrl
        self.competitionId = competitionId
    }
}

// MARK: - Persistence

/// Make Team a Codable Record.
///
/// See <https://github.com/groue/GRDB.swift/blob/master/README.md#records>
extension Team: FetchableRecord, MutablePersistableRecord {
    /// Updates a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}

extension Team {
    // The request for all teams in a competition
    static func filter(competitionId: Int64) -> QueryInterfaceRequest<Team> {
        return filter(Column("competitionId") == competitionId)
    }
}
