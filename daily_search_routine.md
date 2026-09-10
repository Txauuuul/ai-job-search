# Rutina "Búsqueda de empleo diaria — Saúl" (modo RADAR)

- **trigger_id:** `trig_01KUQ7691YXkjYJjiCYY1nnC`
- **Panel:** https://claude.ai/code/routines/trig_01KUQ7691YXkjYJjiCYY1nnC
- **Horario:** cron `0 7 * * 1-5` = L-V 09:00 Europe/Madrid (CEST). Tras DST de finales de octubre pasar a `0 8 * * 1-5`.
- **Entrega:** `informes/AAAA-MM-DD.md` (commit+push a master) **y** email a saultauste22@gmail.com (conector Gmail).

## Por qué "modo radar"

El entorno en la nube (`env_01NET3rd8du3jXZw4o2dYuan`, anthropic_cloud) tiene el **egress
bloqueado** para InfoJobs, Tecnoempleo, LinkedIn, Indeed, Lanbide, etc. WebFetch a esos
dominios falla (EGRESS_BLOCKED). Solo **WebSearch** funciona. Por eso la rutina no analiza
ofertas: junta **enlaces candidatos** de los resultados de búsqueda y los manda para que
Saúl los abra y evalúe. El análisis fino (fit, CV, carta) se sigue haciendo en sesión.

## Deduplicación

- `job_search_tracker.csv` (empresa + URL).
- Todos los `informes/*.md` anteriores (enlaces ya reportados) — para no repetir.

## Mantenimiento

- Cambiar criterios: editar `daily_search_profile.md` + push.
- Cambiar prompt/horario: `RemoteTrigger update` sobre el trigger_id.
- Si algún día se levanta el bloqueo de egress: volver al prompt "analítico" (git history).

## Prompt activo

Ver el `events[0].data.message.content` del trigger (RemoteTrigger get). Resumen: WebSearch
en batería (zona x rol), filtra a URLs de oferta individual (`/of-i`, `/rf-`, `/jobs/view/`),
dedup contra tracker + informes previos, escribe informe agrupado por zona con aviso de
"sin verificar", commit + push + email.
