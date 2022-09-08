//
//  LikeSql.swift
//  AKTest6
//
//  Created by IOS Training 2 on 23/08/22.
//

import Foundation
import SQLite3

class LikeDBManager {
    private let dbpath: String = LikeConstant.dbpathConstant
    private var db: OpaquePointer?
    static let sharedInstance = LikeDBManager()
    var userlist: Likeinfo = Likeinfo()
    private init() {
        db = openDatabase()
        createLikeinfoTable()
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
    func createLikeinfoTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Likeinfo(id TEXT, userId TEXT, feedId TEXT)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
          
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Likeinfo table created.")
            } else {
                print("Likeinfo table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(userModel: Likeinfo) {
        
        let insertStatementString = "INSERT INTO Likeinfo (id, userId,feedId) VALUES ('\(userModel.id)','\(userModel.userId)','\(userModel.feedId)');"
        
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
    
    func read() -> [Likeinfo] {
        let queryStatementString = "SELECT * FROM Likeinfo;"
        var queryStatement: OpaquePointer? = nil
        var Userinfos: [Likeinfo] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var userinfo = Likeinfo()
                
                
                if let nameFromDB = sqlite3_column_text(queryStatement,0) {
                    userinfo.id = String(cString: nameFromDB)
                }
                if let userIdFromDB = sqlite3_column_text(queryStatement, 1) {
                    userinfo.userId = String(cString: userIdFromDB)
                }
                if let imageFromDB = sqlite3_column_text(queryStatement, 2) {
                    userinfo.feedId = String(cString: imageFromDB)
                }
                
                Userinfos.append(userinfo)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return Userinfos
    }
    
    func getUserDeatilsWithEmailId(userId: String) -> Likeinfo? {
        let queryStatementString = "SELECT * FROM Likeinfo WHERE userId = '\(userId)';"
        var queryStatement: OpaquePointer? = nil
        var datas: Likeinfo?
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                datas = Likeinfo()
                
                if let nameFromDB = sqlite3_column_text(queryStatement,0) {
                    datas?.id = String(cString: nameFromDB)
                }
                if let userIdFromDB = sqlite3_column_text(queryStatement, 1) {
                    datas?.userId = String(cString: userIdFromDB)
                }
                if let imageFromDB = sqlite3_column_text(queryStatement, 2) {
                 datas?.feedId = String(cString: imageFromDB)
                }
                
                break
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return  datas
        
    }
    func deleteData(userModel: Statusinfo) {
        let deleteStatementString = "DELETE FROM Statusinfo WHERE Name = \(userModel.userId)"
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



