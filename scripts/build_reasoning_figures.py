#!/usr/bin/env python3
"""Build editable diagrams used by T-04--T-06; standard library only.
The shared agent/environment diagram is defined once in diagrams.typ.
"""
from pathlib import Path
from diagram_support import INK, ACCENT, text as txt, box, arrow as edge, save_svg
ROOT=Path(__file__).resolve().parents[1]


def save(group, name, body, h=380):
    save_svg(ROOT / 'images' / group / name, body, h)


s=box(20,35,270,75,'Beliefs')+box(365,35,270,75,'Goal / intention')+box(710,35,270,75,'Available actions')
s+=box(325,180,350,70,'Means–ends reasoning','#fff0df')+box(325,310,350,65,'Plan to attempt')
s+=edge('M155 115 L155 215 L315 215')+edge('M500 115 L500 170')+edge('M845 115 L845 215 L685 215')+edge('M500 255 L500 300')
save('T-04','means-ends.svg',s,405)

s=box(15,110,260,80,'Beliefs')+box(370,110,260,80,'Desires')+box(725,110,260,80,'Intentions')
s+=edge('M280 150 L360 150')+edge('M635 150 L715 150')
s+=txt(145,75,'Revise beliefs',27)+txt(500,75,'Generate options',27)+txt(855,75,'Filter and commit',27)
s+=edge('M855 195 L855 285 L145 285 L145 195')+txt(500,330,'Act, perceive the outcome, and reconsider',28)
save('T-04','bdi-cycle.svg',s,370)

s=box(45,110,280,80,'Observe / update')+box(360,110,280,80,'Deliberate / plan')+box(675,110,280,80,'Execute a step')
s+=edge('M330 150 L350 150')+edge('M645 150 L665 150')
s+=txt(185,75,'t₀',30)+txt(500,75,'t₁',30)+txt(815,75,'t₂',30)
s+='<path d="M70 280 L940 280" stroke="#eb811b" stroke-width="5"/>'+txt(500,330,'The environment may change throughout the whole interval.',27)
save('T-04','reasoning-time.svg',s,370)

for direction in ['forward','backward']:
 s=box(20,45,430,80,'guards(aragorn, frodo)')+box(550,45,430,80,'carries(frodo, ring)')+box(240,255,520,80,'protects(aragorn, ring)','#fff0df')
 if direction=='forward':s+=edge('M235 130 L395 245')+edge('M765 130 L605 245')
 else:s+=edge('M395 250 L235 135')+edge('M605 250 L765 135')
 save('T-05',direction+'-chaining.svg',s,365)

s=box(35,120,240,80,'Hidden')+box(380,120,240,80,'Worn')+box(725,120,240,80,'Detected','#ffe7de')
s+=edge('M280 145 L370 145')+edge('M620 175 L715 175',ACCENT)+edge('M380 185 L285 185')
s+=txt(325,105,'wear',24)+txt(325,230,'remove',24)+txt(680,245,'expose bearer',24)
s+=txt(500,325,'Counterexample: Hidden → Worn → Detected',29)
save('T-06','model-checking.svg',s,365)

