//
//  AppDatabase.swift
//  MVVM-C
//
//  Created by Abdurrahman Alboghdady on 10/04/2022.
//

import GRDB

/// AppDatabase lets the application access the database.
///
/// It applies the pratices recommended at
/// <https://github.com/groue/GRDB.swift/blob/master/Documentation/GoodPracticesForDesigningRecordTypes.md>
final class AppDatabase {
    /// Creates an `AppDatabase`, and make sure the database schema is ready.
    init(_ dbWriter: DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    /// Provides access to the database.
    ///
    /// Application can use a `DatabasePool`, and tests can use a fast
    /// in-memory `DatabaseQueue`.
    ///
    /// See <https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections>
    private let dbWriter: DatabaseWriter
    
    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See <https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md>
    private var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        #if DEBUG
        // Speed up development by nuking the database when migrations change
        // See https://github.com/groue/GRDB.swift/blob/master/Documentation/Migrations.md#the-erasedatabaseonschemachange-option
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("Football") { db in
            // Create a competition table
            // See https://github.com/groue/GRDB.swift#create-tables
            try db.create(table: "competition") { t in
                t.column("id", .integer).primaryKey()
                t.column("name", .text).notNull()
            }
            // Create a team table
            try db.create(table: "team") { t in
                t.column("id", .integer).primaryKey()
                t.column("name", .text).notNull()
                t.column("competitionId", .integer).notNull()
            }
        }
        
        return migrator
    }
}

// MARK: - Database Access: Writes

extension AppDatabase {
    /// Saves (inserts or updates) a league. When the method returns, the
    /// league is present in the database, and its id is not nil.
    func saveLeague(_ league: inout Competition) throws {
        try dbWriter.write { db in
            try league.save(db)
        }
    }
    
    /// Saves (inserts or updates) a league. When the method returns, the
    /// team is present in the database, and its id is not nil.
    func saveTeam(_ team: inout Team) throws {
        try dbWriter.write { db in
            try team.save(db)
        }
    }
}

// MARK: - Database Access: Reads
extension AppDatabase {
    /// Provides a read-only access to the database
    var databaseReader: DatabaseReader {
        dbWriter
    }
}
