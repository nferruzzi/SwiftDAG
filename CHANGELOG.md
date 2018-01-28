# SwiftDAG - Change Log

The format is based on [Keep a Changelog](http://keepachangelog.com/en/0.3.0/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased
### Added
### Changed
### Fixed

## 0.0.1 - 2018-28-01
### Added
- Node class: base for all data structures
- Edge: provide an interface to easily 1-1 connections
- EdgeArray: provide an interface to create 1-M connections
- EdgeDictionary: provide an interface to mange key-value connections, where key is Hashable and Value a Node based class
- Optional: sourcery stencil template to generate getter and setter for direct graph manipulation
- Custom Edge operator: ^ unwrap connection child
- Custom Edge operator: A <= B , connect node A (parent) to node B (child)
### Changed
### Fixed

