// Generated using Sourcery 0.10.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Children {
}

extension Color {
}

extension Label {
    var color: Color? {
        set {
            if color !== _color {
                fatalError("Label._color has been modified directly")
            }
            if newValue === _color {
                return
            }
            if let temp = _color {
                removeLink(from: temp)
            }
            if let temp = newValue {
                do {
                    try addLink(to: temp)
                } catch DAGError.AcyclicInvariant {
                    fatalError("Label._color closed loop detected")
                } catch {
                    fatalError("not possible")
                }
            }
            _color = newValue
        }

        get {
            return _color
        }
    }

    var text: Text? {
        set {
            if text !== _text {
                fatalError("Label._text has been modified directly")
            }
            if newValue === _text {
                return
            }
            if let temp = _text {
                removeLink(from: temp)
            }
            if let temp = newValue {
                do {
                    try addLink(to: temp)
                } catch DAGError.AcyclicInvariant {
                    fatalError("Label._text closed loop detected")
                } catch {
                    fatalError("not possible")
                }
            }
            _text = newValue
        }

        get {
            return _text
        }
    }

}

extension Parent {
    var children: Children? {
        set {
            if children !== _children {
                fatalError("Parent._children has been modified directly")
            }
            if newValue === _children {
                return
            }
            if let temp = _children {
                removeLink(from: temp)
            }
            if let temp = newValue {
                do {
                    try addLink(to: temp)
                } catch DAGError.AcyclicInvariant {
                    fatalError("Parent._children closed loop detected")
                } catch {
                    fatalError("not possible")
                }
            }
            _children = newValue
        }

        get {
            return _children
        }
    }

}

extension Text {
}

extension View {
    var children: View? {
        set {
            if children !== _children {
                fatalError("View._children has been modified directly")
            }
            if newValue === _children {
                return
            }
            if let temp = _children {
                removeLink(from: temp)
            }
            if let temp = newValue {
                do {
                    try addLink(to: temp)
                } catch DAGError.AcyclicInvariant {
                    fatalError("View._children closed loop detected")
                } catch {
                    fatalError("not possible")
                }
            }
            _children = newValue
        }

        get {
            return _children
        }
    }

}

