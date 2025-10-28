import 'package:flutter/material.dart';

/// Defines the cursor behavior when hovering over a widget.
enum CursorBehavior {
  /// Default cursor (arrow)
  auto,

  /// Pointer cursor (hand)
  pointer,

  /// Help cursor (question mark)
  help,

  /// Wait cursor (loading)
  wait,

  /// Progress cursor (loading with pointer)
  progress,

  /// Text cursor (I-beam)
  text,

  /// Move cursor (4-way arrow)
  move,

  /// Not allowed cursor (forbidden)
  notAllowed,

  /// Grab cursor (open hand)
  grab,

  /// Grabbing cursor (closed hand)
  grabbing,

  /// Zoom in cursor
  zoomIn,

  /// Zoom out cursor
  zoomOut,

  /// None (hide cursor)
  none;

  /// Get the corresponding MouseCursor for this behavior
  MouseCursor get mouseCursor {
    switch (this) {
      case CursorBehavior.auto:
        return SystemMouseCursors.basic;
      case CursorBehavior.pointer:
        return SystemMouseCursors.click;
      case CursorBehavior.help:
        return SystemMouseCursors.help;
      case CursorBehavior.wait:
        return SystemMouseCursors.wait;
      case CursorBehavior.progress:
        return SystemMouseCursors.progress;
      case CursorBehavior.text:
        return SystemMouseCursors.text;
      case CursorBehavior.move:
        return SystemMouseCursors.move;
      case CursorBehavior.notAllowed:
        return SystemMouseCursors.forbidden;
      case CursorBehavior.grab:
        return SystemMouseCursors.grab;
      case CursorBehavior.grabbing:
        return SystemMouseCursors.grabbing;
      case CursorBehavior.zoomIn:
        return SystemMouseCursors.zoomIn;
      case CursorBehavior.zoomOut:
        return SystemMouseCursors.zoomOut;
      case CursorBehavior.none:
        return SystemMouseCursors.none;
    }
  }

  /// Get the display name for this cursor behavior
  String get displayName {
    switch (this) {
      case CursorBehavior.auto:
        return 'auto';
      case CursorBehavior.pointer:
        return 'pointer';
      case CursorBehavior.help:
        return 'help';
      case CursorBehavior.wait:
        return 'wait';
      case CursorBehavior.progress:
        return 'progress';
      case CursorBehavior.text:
        return 'text';
      case CursorBehavior.move:
        return 'move';
      case CursorBehavior.notAllowed:
        return 'notAllowed';
      case CursorBehavior.grab:
        return 'grab';
      case CursorBehavior.grabbing:
        return 'grabbing';
      case CursorBehavior.zoomIn:
        return 'zoomIn';
      case CursorBehavior.zoomOut:
        return 'zoomOut';
      case CursorBehavior.none:
        return 'none';
    }
  }

  /// Get CursorBehavior from string
  static CursorBehavior? fromString(String? value) {
    if (value == null) return null;
    switch (value) {
      case 'auto':
        return CursorBehavior.auto;
      case 'pointer':
        return CursorBehavior.pointer;
      case 'help':
        return CursorBehavior.help;
      case 'wait':
        return CursorBehavior.wait;
      case 'progress':
        return CursorBehavior.progress;
      case 'text':
        return CursorBehavior.text;
      case 'move':
        return CursorBehavior.move;
      case 'notAllowed':
        return CursorBehavior.notAllowed;
      case 'grab':
        return CursorBehavior.grab;
      case 'grabbing':
        return CursorBehavior.grabbing;
      case 'zoomIn':
        return CursorBehavior.zoomIn;
      case 'zoomOut':
        return CursorBehavior.zoomOut;
      case 'none':
        return CursorBehavior.none;
      default:
        return null;
    }
  }
}
