//
//  TemplateLoader.swift
//  Stencil
//
//  Created by Kyle Fuller on 28/12/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

import Foundation

// A class for loading a template from disk
public class TemplateLoader {
    
    private lazy var fileManager = NSFileManager()
    
    // TODO: Should be URLs
    public let paths: [String]

    public init(paths: [String]) {
        self.paths = paths
    }

    public init(bundle:[NSBundle]) {
        self.paths = bundle.map {
            return $0.bundlePath
        }
    }

    public func loadTemplate(templateName:String) -> Template? {
        return loadTemplate([templateName])
    }

    public func loadTemplate(templateNames:[String]) -> Template? {
        for path in paths {
            for templateName in templateNames {
                let templatePath = path.stringByAppendingPathComponent(templateName)

                if fileManager.fileExistsAtPath(templatePath) {
                    if let template = Template(path: templatePath) {
                        return template
                    }
                }
            }
        }

        return nil
    }
}
