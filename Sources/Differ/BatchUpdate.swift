import Foundation

public struct BatchUpdate {
    public struct MoveStep: Equatable {
        public let from: IndexPath
        public let to: IndexPath
    }

    public let deletions: [IndexPath]
    public let insertions: [IndexPath]
    public let moves: [MoveStep]
    
    public init(
        diff: ExtendedDiff,
        indexPathTransform: (IndexPath) -> IndexPath = { $0 }
        ) {
        deletions = diff.compactMap { element -> IndexPath? in
            switch element {
            case let .delete(at):
                return indexPathTransform([0, at])
            default: return nil
            }
        }
        insertions = diff.compactMap { element -> IndexPath? in
            switch element {
            case let .insert(at):
                return indexPathTransform([0, at])
            default: return nil
            }
        }
        moves = diff.compactMap { element -> MoveStep? in
            switch element {
            case let .move(from, to):
                return MoveStep(from: indexPathTransform([0, from]), to: indexPathTransform([0, to]))
            default: return nil
            }
        }
    }
}
