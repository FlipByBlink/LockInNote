enum 🔖Tab: Hashable {
    case note(📝NoteFamily)
#if os(iOS)
    case option
#endif
    case info
}
