//
//  SqliteDB.swift
//  AKTest6
//
//  Created by IOS Training 2 on 21/08/22.
//


import Foundation
import SQLite3

class DBManager {
    private let dbpath: String = Constant.dbpathConstant
    private var db: OpaquePointer?
    static let sharedInstance = DBManager()
    var userinfo: Userinfo = Userinfo()
    private init() {
        db = openDatabase()
        createUserinfoTable()
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
    
    //MARK: - User Login
    
    func createUserinfoTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Userinfo(name TEXT, emailId TEXT, mobileNumber Text, password TEXT, address TEXT, state TEXT, pincode TEXT)"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Userinfo table created.")
            } else {
                print("Userinfo table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(userModel: Userinfo) {
        
        let insertStatementString = "INSERT INTO Userinfo (name, emailId, mobileNumber, password, address, state, pincode) VALUES ('\(userModel.Name)','\(userModel.EmailId)','\(userModel.MobileNumber)','\(userModel.Password)','\(userModel.Address)','\(userModel.State)','\(userModel.Pincode)');"
        
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
    
    func read() -> [Userinfo] {
        let queryStatementString = "SELECT * FROM Userinfo;"
        var queryStatement: OpaquePointer? = nil
        var Userinfos: [Userinfo] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                var userinfo = Userinfo()
                
                
                if let nameFromDB = sqlite3_column_text(queryStatement,0) {
                    userinfo.Name = String(cString: nameFromDB)
                }
                if let emailFromDB = sqlite3_column_text(queryStatement, 1) {
                    userinfo.EmailId = String(cString: emailFromDB)
                }
                if let mobnoFromDB = sqlite3_column_text(queryStatement, 2) {
                    userinfo.MobileNumber = String(cString: mobnoFromDB)
                }
                if let passwordFromDB = sqlite3_column_text(queryStatement, 3) {
                    userinfo.Password = String(cString: passwordFromDB)
                }
                
                if let addressFromDB = sqlite3_column_text(queryStatement, 4) {
                    userinfo.Address = String(cString: addressFromDB)
                }
                if let stateFromDB = sqlite3_column_text(queryStatement, 5) {
                    userinfo.State = String(cString: stateFromDB)
                }
                if let pincodeFromDB = sqlite3_column_text(queryStatement, 6) {
                    userinfo.Pincode = String(cString: pincodeFromDB)
                }
                
                Userinfos.append(userinfo)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return Userinfos
    }
    
    func getUserDeatilsWithEmailId(emailId: String) -> Userinfo? {
        let queryStatementString = "SELECT * FROM Userinfo WHERE emailId = '\(emailId)';"
        var queryStatement: OpaquePointer? = nil
        var userinfo = Userinfo()
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                if let nameFromDB = sqlite3_column_text(queryStatement,0) {
                    userinfo.Name = String(cString: nameFromDB)
                }
                if let emailFromDB = sqlite3_column_text(queryStatement, 1) {
                    userinfo.EmailId = String(cString: emailFromDB)
                }
                if let mobnoFromDB = sqlite3_column_text(queryStatement, 2) {
                    userinfo.MobileNumber = String(cString: mobnoFromDB)
                }
                if let passwordFromDB = sqlite3_column_text(queryStatement, 3) {
                    userinfo.Password = String(cString: passwordFromDB)
                }
                
                if let addressFromDB = sqlite3_column_text(queryStatement, 4) {
                    userinfo.Address = String(cString: addressFromDB)
                }
                if let stateFromDB = sqlite3_column_text(queryStatement, 5) {
                    userinfo.State = String(cString: stateFromDB)
                }
                if let pincodeFromDB = sqlite3_column_text(queryStatement, 6) {
                    userinfo.Pincode = String(cString: pincodeFromDB)
                }
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return  userinfo
        
    }
    func deleteData(userModel: Userinfo) {
        let deleteStatementString = "DELETE FROM Userinfo WHERE Name = \(userModel.Name)"
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
    

    func readAuthors(email:String) ->  String {
        let query = "SELECT name FROM Userinfo WHERE emailId = ?;"
//        let query = "SELECT name FROM Userinfo WHERE emailId = '\(email);"
        var queryPointer: OpaquePointer? = nil
        var name = String()
        
        if sqlite3_prepare_v2(db, query, -1, &queryPointer, nil) == SQLITE_OK {
            sqlite3_bind_text(queryPointer, 1, (email as NSString).utf8String, -1, nil)
            while sqlite3_step(queryPointer) == SQLITE_ROW { //at last we will get SQLITE_DONE status code
                name = String(cString: sqlite3_column_text(queryPointer, 0)!)
                //userimage = String(cString: sqlite3_column_text(queryPointer, 1)!)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryPointer)
        return name
    }
}


