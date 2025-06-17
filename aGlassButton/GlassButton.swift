//
//  GlassButton.swift
//  aGlassButton
//
//  Created by The M4P on 20/1/2024.
//

import Foundation
import SwiftUI
import Combine

typealias VoidAction = (()->())
typealias BoolAction = ((Bool)->())

// MARK: - Glass Look

struct GlassLook: ViewModifier {
    var cornerSize: CGFloat = 32
    func body(content: Content) -> some View {
        content
            .background(.thinMaterial)
            .cornerRadius(cornerSize)
            .overlay(
                RoundedRectangle(cornerSize: CGSize(width: cornerSize, height: cornerSize))
                    .stroke(.white, style: StrokeStyle(lineWidth: 2))
                    .opacity(0.2)
            )
    }
}

// MARK: - Touch Button

struct TouchButton: ViewModifier {
    @State private var touched: Bool = false
    var touchDownAction: VoidAction? = nil
    var touchDownContinuousAction: VoidAction? = nil
    var touchUpAction: VoidAction? = nil

    func body(content: Content) -> some View {
        content
            .onTouchOverlay(perform: { state, _, _ in
                withAnimation(.easeInOut(duration: 0.1)) {
                    if state == .firstStarted {
                        touched = true
                        touchDownAction?()
                    }
                    if state == .lastEnded {
                        touched = false
                        touchUpAction?()
                    }
                }
            })
            .background(
                Group {
                    if touched {
                        TimeEventGeneratorView {
                            if touched {
                                touchDownContinuousAction?()
                            }
                        }
                    }
                }
            )
            .scaleEffect(x: touched ? 0.95 : 1.0, y: touched ? 0.95 : 1.0)
            .shadow(color:.black.opacity(0.5), radius: 5, y: 5)
            .opacity(touched ? 0.5 : 1.0)
    }
}

// MARK: - Two Sided Buttons

struct SideTouchButtons: ViewModifier {
    @State private var touched1: Bool = false
    @State private var touched2: Bool = false
    var isVertical: Bool = false
    var touchDownAction1: VoidAction? = nil
    var touchDownContinuousAction1: VoidAction? = nil
    var touchUpAction1: VoidAction? = nil
    var touchDownAction2: VoidAction? = nil
    var touchDownContinuousAction2: VoidAction? = nil
    var touchUpAction2: VoidAction? = nil

    func body(content: Content) -> some View {
        content
            .background(
                Group {
                    if touched1 || touched2 {
                        TimeEventGeneratorView {
                            if touched1 {
                                touchDownContinuousAction1?()
                            }
                            if touched2 {
                                touchDownContinuousAction2?()
                            }
                        }
                    }
                }
            )
            .rotation3DEffect(
                .degrees(touched1 ? -6 : touched2 ? 6 : 0), axis: (x: isVertical ? -1.0 : 0.0, y: isVertical ? 0.0 : 1.0, z: 0.0)
            )
            .scaleEffect(x: (touched1 || touched2) ? 0.96 : 1.0, y: (touched1 || touched2) ? 0.96 : 1.0)
            .shadow(color:.black.opacity(0.5), radius: 5, y: 5)
            .animation(.easeInOut(duration: 0.1), value: touched1)
            .animation(.easeInOut(duration: 0.1), value: touched2)
            .overlay {
                if isVertical {
                    VStack(spacing: 0) {
                        Rectangle()
                            .fill(.clear)
                            .onTouchOverlay(perform: { state, _, _ in
                                if state == .firstStarted {
                                    touched1 = true
                                    touchDownAction1?()
                                }
                                if state == .lastEnded {
                                    touched1 = false
                                    touchUpAction1?()
                                }
                            })
                        Rectangle()
                            .fill(.clear)
                            .onTouchOverlay(perform: { state, _, _ in
                                if state == .firstStarted {
                                    touched2 = true
                                    touchDownAction2?()
                                }
                                if state == .lastEnded {
                                    touched2 = false
                                    touchUpAction2?()
                                }
                            })
                    }
                } else {
                    HStack(spacing: 0) {
                        Rectangle()
                            .fill(.clear)
                            .onTouchOverlay(perform: { state, _, _ in
                                if state == .firstStarted {
                                    touched1 = true
                                    touchDownAction1?()
                                }
                                if state == .lastEnded {
                                    touched1 = false
                                    touchUpAction1?()
                                }
                            })
                        Rectangle()
                            .fill(.clear)
                            .onTouchOverlay(perform: { state, _, _ in
                                if state == .firstStarted {
                                    touched2 = true
                                    touchDownAction2?()
                                }
                                if state == .lastEnded {
                                    touched2 = false
                                    touchUpAction2?()
                                }
                            })
                    }
                }
            }
    }
}

extension View {
    func onTouchOverlay(perform: ((TouchGroupState, [TouchContainer], CGPoint) -> ())?) -> some View {
        self.modifier(TouchesLocaterOverlay(onUpdate: perform))
    }
    
    func glass(_ corner: CGFloat = 32) -> some View {
        modifier(GlassLook(cornerSize: corner))
    }
    
    func touchButton(downAction: VoidAction? = nil, downContAction: VoidAction? = nil, upAction: VoidAction? = nil) -> some View {
        modifier(TouchButton(touchDownAction: downAction, touchDownContinuousAction: downContAction , touchUpAction: upAction))
    }
    
    func sideTouchButton(vertical: Bool = false, downAction1: VoidAction? = nil, downContAction1: VoidAction? = nil, upAction1: VoidAction? = nil, downAction2: VoidAction? = nil, downContAction2: VoidAction? = nil, upAction2: VoidAction? = nil) -> some View {
        modifier(SideTouchButtons(isVertical: vertical, touchDownAction1: downAction1, touchDownContinuousAction1: downContAction1 , touchUpAction1: upAction1, touchDownAction2: downAction2, touchDownContinuousAction2: downContAction2 , touchUpAction2: upAction2))
    }
    
    func glassButton(downAction: VoidAction? = nil, downContAction: VoidAction? = nil, upAction: VoidAction? = nil) -> some View {
        self
            .glass()
            .modifier(TouchButton(touchDownAction: downAction, touchDownContinuousAction: downContAction , touchUpAction: upAction))
    }

    func glassSideButton(vertical: Bool = false, downAction1: VoidAction? = nil, downContAction1: VoidAction? = nil, upAction1: VoidAction? = nil, downAction2: VoidAction? = nil, downContAction2: VoidAction? = nil, upAction2: VoidAction? = nil) -> some View {
        self
            .glass()
            .modifier(SideTouchButtons(isVertical: vertical, touchDownAction1: downAction1, touchDownContinuousAction1: downContAction1 , touchUpAction1: upAction1, touchDownAction2: downAction2, touchDownContinuousAction2: downContAction2 , touchUpAction2: upAction2))
    }
}

// MARK: - Touch Handling

enum TouchState: String {
    case started
    case moved
    case ended
}

enum TouchGroupState: String {
    case firstStarted
    case someUpdated
    case lastEnded
    case cleared
}

class TouchContainer {
    let idx: Int
    let touch: UITouch
    var location: CGPoint
    var state: TouchState

    init(idx: Int, touch: UITouch, location: CGPoint = .zero, state: TouchState = .started) {
        self.idx = idx
        self.touch = touch
        self.location = location
        self.state = state
    }
}

extension TouchContainer: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(idx) \(state)"
    }
}

// Remap touches from uiview to be used in swiftui
struct TouchesLocatingView: UIViewRepresentable {
    let onUpdate: ((TouchGroupState, [TouchContainer], CGPoint) -> ())?

    func makeUIView(context: Context) -> TouchesLocatingUIView {
        // Create the underlying UIView, passing in our configuration
        let view = TouchesLocatingUIView()
        view.onUpdate = onUpdate
        return view
    }

    func updateUIView(_ uiView: TouchesLocatingUIView, context: Context) {
        uiView.onUpdate = onUpdate
    }

    // The internal UIView responsible for catching taps
    class TouchesLocatingUIView: UIView {
        var onUpdate: ((TouchGroupState, [TouchContainer], CGPoint) -> ())?
        private var touches: [TouchContainer] = []

        // Our main initializer, making sure interaction is enabled.
        override init(frame: CGRect) {
            super.init(frame: frame)
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
        }

        // Just in case you're using storyboards!
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                let globalLocation = self.convert(location, to: .none)
                updateTouch(touch, location: globalLocation, state: .started)
            }
            report()
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                let globalLocation = self.convert(location, to: .none)
                updateTouch(touch, location: globalLocation, state: .moved)
            }
            report()
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                let globalLocation = self.convert(location, to: .none)
                updateTouch(touch, location: globalLocation, state: .ended)
            }
            report(cleanAfter: true)
        }

        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                let globalLocation = self.convert(location, to: .none)
                updateTouch(touch, location: globalLocation, state: .ended)
            }
            report(cleanAfter: true)
        }

        private func updateTouch(_ touchToUpdate: UITouch, location: CGPoint, state: TouchState) {
            if let touch = touches.first(where: {$0.touch == touchToUpdate}) {
                touch.location = location
                touch.state = state
            } else {
                let maxIdx = self.touches.max(by: { $0.idx < $1.idx })?.idx
                let tc = TouchContainer(idx: (maxIdx ?? 0) + 1, touch: touchToUpdate, location: location, state: state)
                self.touches.append(tc)
            }
        }

        func report(cleanAfter: Bool = false) {
            let states = touches.map(\.state)
            var groupState = TouchGroupState.someUpdated
            if states.count == 1, let soleState = states.first, soleState != .moved {
                groupState = soleState == .started ? .firstStarted : .lastEnded
            }
            let globalCenterLocation = self.convert(center, to: .none)
            onUpdate?(groupState, touches, globalCenterLocation)
            if cleanAfter {
                touches.removeAll{ $0.state == .ended }
            }
            if touches.count == 0 {
                onUpdate?(.cleared, touches, globalCenterLocation)
            }
        }
    }
}

struct TouchesLocaterOverlay: ViewModifier {
    let onUpdate: ((TouchGroupState, [TouchContainer], CGPoint) -> ())?
    func body(content: Content) -> some View {
        content
            .overlay(
                TouchesLocatingView(onUpdate: onUpdate)
            )
    }
}

// A timer to manage touch down continuously
struct TimeEventGeneratorView: View {
    var callback: VoidAction?
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    
    init(duration: Double = 0.1, callback: VoidAction?) {
        self.callback = callback
        self.timer = Timer.publish(every: duration, on: .main, in: .common).autoconnect()
    }

    var body: some View {
        Color.clear
            .onReceive(self.timer) { _ in
                self.callback?()
            }
    }
}
