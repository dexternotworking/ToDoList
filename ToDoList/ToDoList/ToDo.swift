//
//  ToDo.swift
//  ToDoList
//
//  Created by MacAir11 on 04/25/19.
//  Copyright © 2019 CCC iOS Boot Camp. All rights reserved.
//

import Foundation;

struct ToDo: Codable {   //pp. 731, 767
    var title: String;
    var isComplete: Bool; //p. 732
    var dueDate: Date;
    var notes: String?;
    
    static func loadToDos() -> [ToDo]?  {   //p. 734
        guard let codedToDos: Data = try? Data(contentsOf: archiveURL) else {   //p. 768
            return nil;
        }
        
        let propertyListDecoder: PropertyListDecoder = PropertyListDecoder();
        return try? propertyListDecoder.decode([ToDo].self, from: codedToDos);
    }
    
    static func saveToDos(_ todos: [ToDo]) {   //pp. 768-769
        let propertyListEncoder: PropertyListEncoder = PropertyListEncoder();
        guard let codedToDos: Data = try? propertyListEncoder.encode(todos) else {
            fatalError("could not encode ToDos");
        }
        
        if (try? codedToDos.write(to: archiveURL, options: .noFileProtection)) == nil {
            fatalError("could not save encoded ToDos");
        }
    }
    
    static func loadSampleToDos() -> [ToDo] {   //p. 735
        return [
            ToDo(title: "ToDo One",   isComplete: false, dueDate: Date(), notes: "Notes 1"),
            ToDo(title: "ToDo Two",   isComplete: false, dueDate: Date(), notes: "Notes 2"),
            ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        ];
    }
    
    static let dueDateFormatter: DateFormatter = {   //p. 750
        let formatter: DateFormatter = DateFormatter();
        formatter.dateStyle = .short;
        formatter.timeStyle = .short;
        return formatter;
    }();
    
    //p. 768
    static let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
    static let archiveURL: URL = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist");
}
