# Búsqueda de empleo diaria — cómo funciona

**Enfoque actual (10/09/2026): en sesión, al empezar el día.**

La rutina en la nube (`trig_01KUQ7691YXkjYJjiCYY1nnC`) quedó **DESACTIVADA**: el entorno
de la nube egress-bloquea los portales, así que solo daba ofertas caducadas del índice de
búsqueda. Sin valor.

En cambio: un **hook SessionStart** (`.claude/hooks/daily-search-check.sh`) comprueba si
existe `informes/AAAA-MM-DD.md` de hoy. Si no existe, inyecta a Claude la instrucción de
hacer la búsqueda **en vivo** antes de nada:

1. Leer `daily_search_profile.md` + `job_search_tracker.csv`.
2. `WebFetch` sobre páginas de **LISTADO** (no de oferta individual) de InfoJobs y
   Tecnoempleo, por zona: Pamplona/Navarra → Zaragoza → Bilbao/Bizkaia → Asturias →
   Cantabria, + remoto. Ordenar por fecha; quedarse con lo de las últimas ~48 h.
   - `WebFetch` a los listados **funciona** desde la máquina local (probado 10/09).
   - Las páginas de oferta individual a veces devuelven HTTP 456 (bot): entonces marcar
     "sin verificar" pero conservar si el listado la daba reciente.
3. Filtrar con los filtros duros + dedup contra tracker e `informes/*.md` previos.
4. Presentar SOLO las ofertas reales a las que Saúl puede optar, con análisis de encaje.
5. Guardar `informes/AAAA-MM-DD.md`. Ofrecer actualizar el tracker.

**Requisito:** el PC encendido y Claude Code abierto (que es cuando hablamos). Si el hook
no salta tras editar settings, abrir `/hooks` una vez o reiniciar.

**Reactivar la nube** solo si algún día se levanta el bloqueo de egress (ver git history
para el prompt "radar").
