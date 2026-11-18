#!/usr/bin/env python3
"""Build editable SVG diagrams for T-03. Python standard library only.
Use --m2 PDF --odell PDF to rebuild the reused vector crops (requires PyMuPDF).
"""
from pathlib import Path
import argparse
from html import escape
ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'images' / 'T-03'
OUT.mkdir(parents=True, exist_ok=True)
INK = '#23373b'
ORANGE = '#eb811b'
def text(x, y, content, size=28, anchor='middle', fill=INK):
    return f'<text x="{x}" y="{y}" font-size="{size}" text-anchor="{anchor}" fill="{fill}">{escape(content)}</text>'
def box(x, y, w, h, title, fill='#edf3f4'):
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="15" fill="{fill}" stroke="{INK}" stroke-width="2"/>' + text(x+w/2,y+h/2+10,title)
def arrow(path, color=INK):
    return f'<path d="{path}" fill="none" stroke="{color}" stroke-width="3" marker-end="url(#arrow)"/>'
def save(name, content, height=380):
    s=f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 {height}">
<defs><marker id="arrow" markerWidth="9" markerHeight="9" refX="8" refY="4.5" orient="auto"><path d="M0 0 L9 4.5 L0 9 Z" fill="{INK}"/></marker></defs>
<g font-family="Fira Sans, sans-serif">{content}</g></svg>'''
    (OUT/name).write_text(s)

s = '<ellipse cx="500" cy="205" rx="280" ry="170" fill="#f8fafb" stroke="#eb811b" stroke-width="7"/>'
s += text(500,80,'Boundary / membrane',30)
s += box(360,145,280,65,'Metabolic network')
s += box(360,255,280,65,'Component renewal')
s += arrow('M500 212 L500 250')+arrow('M355 285 C275 285 275 170 355 170')
s += arrow('M100 170 L350 170')+text(105,140,'Matter + energy',24,'start')
s += arrow('M650 285 L900 285')+text(890,326,'Waste + heat',24,'end')
s += text(500,405,'Processes maintain the boundary; the boundary enables the processes.',23)
save('cell-autopoiesis.svg',s,430)

s=box(25,95,270,95,'Sense')+box(365,95,270,95,'Compare')+box(705,95,270,95,'Act')
s+=text(160,152,'',26)+arrow('M300 142 L355 142')+arrow('M640 142 L695 142')
s+=text(160,230,'Measure temperature',25)+text(500,230,'Compare with a range',25)+text(840,230,'Adjust heat loss',25)
s+=arrow('M840 95 L840 30 L160 30 L160 88')+text(500,20,'Changed body temperature feeds back',22)
save('homeostasis.svg',s,275)

s='<rect x="270" y="35" width="465" height="320" rx="25" fill="#f8fafb" stroke="#eb811b" stroke-width="4" stroke-dasharray="10 6"/>'
s+=text(500,80,'Agent boundary',30)
s+=box(330,115,345,60,'State')+box(330,200,345,60,'Policy / goals')
s+=arrow('M500 180 L500 195')+arrow('M680 230 L865 230')+text(865,275,'Action',24)
s+=arrow('M90 145 L320 145')+text(140,120,'Information',24)
s+=text(500,315,'Control remains inside',27)
save('agent-boundary.svg',s,390)

s=box(20,110,260,90,'Observe')+box(370,110,260,90,'Decide')+box(720,110,260,90,'Act')
s+=arrow('M285 155 L360 155')+arrow('M635 155 L710 155')
s+=arrow('M850 205 L850 290 L150 290 L150 205')
s+=text(500,330,'Observe the outcome and continue, revise, or stop',26)
s+=text(150,75,'Context + feedback',24)+text(500,75,'Goal + current state',24)+text(850,75,'Tools + permissions',24)
save('agentic-loop.svg',s,365)

s=box(25,45,270,80,'Find evidence')+box(365,45,270,80,'Check evidence')+box(705,45,270,80,'Synthesize')
s+=arrow('M300 85 L355 85')+arrow('M640 85 L695 85')
s+=box(250,235,500,70,'Shared task and environment','#fff0df')
s+=arrow('M160 130 L160 270 L240 270')+arrow('M500 130 L500 225')+arrow('M840 130 L840 270 L760 270')
s+=text(500,350,'Each agent controls its own work; messages coordinate the team.',24)
save('agent-team.svg',s,380)

s=box(90,50,300,85,'Agent A')+box(610,50,300,85,'Agent B')
s+=arrow('M400 75 L600 75')+arrow('M600 110 L400 110')+text(500,40,'Messages',24)
s+=box(235,245,530,80,'Physical or digital environment','#fff0df')
s+=arrow('M235 140 L235 235')+arrow('M765 140 L765 235')
s+=text(150,202,'Actions',23)+text(850,202,'Actions',23)
save('agent-actions.svg',s,360)

# Three trip patterns from the SAE J3016 (2021) illustration reused in M3.
# Rebuilt as vector graphics, rather than enlarging its raster text.
s=''
for y,label in [(70,'Manual trip'),(180,'Mixed trip'),(290,'Automated trip')]:
    s+=text(25,y+8,label,27,'start')
    s+=f'<line x1="280" y1="{y}" x2="955" y2="{y}" stroke="#d9e1e2" stroke-width="7"/>'
    for x in [280,955]:s+=f'<circle cx="{x}" cy="{y}" r="8" fill="{INK}"/>'
    if label=='Manual trip':
        s+=f'<line x1="280" y1="{y}" x2="955" y2="{y}" stroke="#167a5a" stroke-width="7"/>'+text(620,y-20,'Level 0',27)
    elif label=='Mixed trip':
        for a,b,c in [(280,445,'#6d369e'),(445,785,'#167a5a'),(785,955,'#6d369e')]:s+=f'<line x1="{a}" y1="{y}" x2="{b}" y2="{y}" stroke="{c}" stroke-width="7"/>'
        s+=text(360,y-20,'Level 4',26)+text(615,y-20,'Level 0',26)+text(870,y-20,'Level 4',26)
    else:s+=f'<line x1="280" y1="{y}" x2="955" y2="{y}" stroke="#6d369e" stroke-width="7"/>'+text(620,y-20,'Level 4 within its domain',27)
s+=text(620,345,'The active feature and its conditions determine the level.',24)
save('driving-trip.svg',s,380)

def vector_crop(pdf, page, rect, name):
    import fitz
    source=fitz.open(pdf);clip=fitz.Rect(rect);out=fitz.open()
    dest=out.new_page(width=clip.width,height=clip.height)
    dest.show_pdf_page(dest.rect,source,page,clip=clip)
    (OUT/name).write_text(dest.get_svg_image())

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--m2',type=Path)
    parser.add_argument('--odell',type=Path)
    args=parser.parse_args()
    if args.m2:
        vector_crop(args.m2,20,(10,121,215,224),'biological-resources-a.svg')
        vector_crop(args.m2,20,(221,121,352,224),'biological-resources-b.svg')
    if args.odell:vector_crop(args.odell,0,(92,511,501,688),'programming-paradigms.svg')
