"""Shared SVG primitives for course diagrams (Python standard library only)."""
from html import escape
from pathlib import Path

INK = '#23373b'
ACCENT = '#eb811b'
FILL = '#edf3f4'


def text(x, y, content, size=28, anchor='middle', fill=INK):
    return (f'<text x="{x}" y="{y}" font-size="{size}" text-anchor="{anchor}" '
            f'fill="{fill}">{escape(content)}</text>')


def box(x, y, width, height, title, fill=FILL):
    return (f'<rect x="{x}" y="{y}" width="{width}" height="{height}" rx="12" '
            f'fill="{fill}" stroke="{INK}" stroke-width="2"/>'
            + text(x + width / 2, y + height / 2 + 9, title))


def arrow(path, color=INK):
    marker = 'arrow-accent' if color == ACCENT else 'arrow'
    return (f'<path d="{path}" fill="none" stroke="{color}" stroke-width="3" '
            f'marker-end="url(#{marker})"/>')


def save_svg(path, body, height=380):
    markers = ''.join(
        f'<marker id="{name}" markerWidth="8" markerHeight="8" refX="7" refY="4" '
        f'orient="auto"><path d="M0 0 L8 4 L0 8 Z" fill="{color}"/></marker>'
        for name, color in [('arrow', INK), ('arrow-accent', ACCENT)]
    )
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 {height}">'
        f'<defs>{markers}</defs><g font-family="Fira Sans, sans-serif">{body}</g></svg>',
        encoding='utf-8',
    )
