#!/usr/bin/env bash
# SessionStart hook: nudges Claude to run the live daily job search once per day.
# Emits additionalContext depending on whether today's report already exists.
set -euo pipefail

d="$(date +%F)"
repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
f="$repo/informes/$d.md"

if [ -f "$f" ]; then
  ctx="La búsqueda de empleo diaria de hoy ($d) ya está hecha ($f). No repetirla salvo que Saúl lo pida."
else
  ctx="PRIMERA SESIÓN DE HOY ($d) — BÚSQUEDA DE EMPLEO DIARIA PENDIENTE. Salvo que Saúl pida otra cosa primero, hazla en vivo: (1) Lee daily_search_profile.md y job_search_tracker.csv. (2) Con WebFetch sobre las páginas de LISTADO (no de oferta individual) de InfoJobs y Tecnoempleo, por zona en orden -- Pamplona/Navarra, Zaragoza, Bilbao/Bizkaia, Asturias, Cantabria -- y remoto; ordena por fecha y quédate solo con lo publicado o actualizado en las últimas ~48h. (3) Para cada candidata que pase los filtros duros y no esté ya en el tracker ni en un informes/*.md previo, intenta WebFetch la oferta individual para verificar que sigue ACTIVA y leer requisitos/salario/modalidad; si la página individual bloquea el acceso, márcala 'sin verificar' pero consérvala si el listado la daba reciente. (4) Presenta SOLO las ofertas reales a las que Saúl puede optar, con análisis de encaje (skills, experiencia, zona, deal-breakers) y marca los 'tiro largo'. (5) Guarda el resultado en informes/$d.md. (6) Ofrece actualizar el tracker."
fi

CTX="$ctx" python -c 'import json,os; print(json.dumps({"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":os.environ["CTX"]}}))'
