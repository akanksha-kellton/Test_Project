//
//  feedConstant.swift
//  AKTest6
//
//  Created by IOS Training 2 on 23/08/22.
//

import Foundation
import SQLite3

class FeedDBManager {
    private let dbpath: String = FeedConstant.dbpathConstant
    private var db: OpaquePointer?
    static let sharedInstance = FeedDBManager()
    var users: Feedinfo = Feedinfo()
    private init() {
        db = openDatabase()
        createFeedinfoTable()
    }
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbpath)
        print(fileURL, "This is the fileURL")
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(dbpath)")
            return db
        } else {
            print("error opening database")
            return nil
        }
    }
    func createFeedinfoTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Feedinfo(id INTEGER PRIMARY KEY AUTOINCREMENT, userId TEXT, feedImage Text, feed TEXT)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Feedinfo table created.")
            } else {
                print("Feedinfo table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    // MARK: - for insertion  in feed table
    func insert(userModel: Feedinfo) {
        
        let insertStatementString = "INSERT INTO Feedinfo (id, userId,feedImage, feed) VALUES (NULL,'\(userModel.userId)','\(userModel.feedImage)','\(userModel.feed)');"
        
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Feedinfo] {
        let queryStatementString = "SELECT * FROM Feedinfo;"
        var queryStatement: OpaquePointer? = nil
        var Userinfos: [Feedinfo] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var userinfo = Feedinfo()
                
                
                userinfo.id = Int(sqlite3_column_int(queryStatement,0))
                if let userIdFromDB = sqlite3_column_text(queryStatement, 1) {
                    userinfo.userId = String(cString: userIdFromDB)
                }
                if let imageFromDB = sqlite3_column_text(queryStatement, 2) {
                    userinfo.feedImage = String(cString: imageFromDB)
                }
                if let feedFromDB = sqlite3_column_text(queryStatement, 3) {
                    userinfo.feed = String(cString: feedFromDB)
                }
                
                Userinfos.append(userinfo)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return Userinfos.reversed()
    }
    
    func getUserDeatilsWithEmailId(userId: String) -> Feedinfo? {
        let queryStatementString = "SELECT * FROM Feedinfo WHERE userId = '\(userId)';"
        var queryStatement: OpaquePointer? = nil
        var datas: Feedinfo?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                datas = Feedinfo()
                
                datas?.id = Int(sqlite3_column_int(queryStatement,0))
                
                if let userIdFromDB = sqlite3_column_text(queryStatement, 1) {
                    datas?.userId = String(cString: userIdFromDB)
                }
                if let imageFromDB = sqlite3_column_text(queryStatement, 2) {
                    datas?.feedImage = String(cString: imageFromDB)
                }
                if let feedFromDB = sqlite3_column_text(queryStatement, 3) {
                    datas?.feed = String(cString: feedFromDB)
                }
                break
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return  datas
    }
    func deleteData(id: Int) {
        let deleteStatementString = "DELETE FROM Feedinfo WHERE id = \(id)"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Count not delete row.")
            }
        } else {
            print("DELETE statement counld not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}


