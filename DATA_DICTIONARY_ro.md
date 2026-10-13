# Dicționarul de date

Generat de `build_database.py` din definiția tabelelor. Nu se editează de mână.

## `campaigns`

Un rând este o campanie de măsurători. Rânduri: 39.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `campaign` | TEXT |  | identificatorul campaniei. Prima literă arată tipul: E atașare, K sesiune KPI, S rezistență sub trafic, C campanie pe cablu, G acceptanță golden, O prima zi pe antene, B campania în stil Open5GBox, T reglaj, V voce, R sonde RF |
| `date` | TEXT |  | ziua primei măsurători din campanie |
| `start` | TEXT |  | prima măsurătoare din campanie |
| `end` | TEXT |  | ultima măsurătoare din campanie |
| `purpose` | TEXT |  | campaign (măsurătoare de raportat), tuning (încercări de reglaj), smoke (probă a scripturilor), diagnostic (sonde RF) |
| `medium` | TEXT |  | coax, ota sau ambele |
| `antenna_cm` | TEXT | cm | distanța dintre antene |
| `cell_prb` | TEXT | PRB | lățimea celulei, una sau ambele |
| `ue` | TEXT |  | oai_ue, phone sau ambele |
| `tool` | TEXT |  | scriptul de măsură, din golden/usrp-coax-e2e/tools |
| `attach_method` | TEXT |  | câte încercări de atașare și cât se așteaptă pe încercare |
| `tcp_s` | TEXT | s | durata unui test TCP |
| `udp_s` | TEXT | s | durata unui test UDP |
| `udp_offered` | TEXT | Mbit/s | debitul UDP oferit |
| `ping` | TEXT |  | cum s-a măsurat latența |
| `reps` | TEXT |  | repetări |
| `radios` | TEXT |  | starea radiourilor la pornire (de când erau alimentate) |
| `question` | TEXT |  | întrebarea la care răspunde campania |
| `n_measurements` | INTEGER |  | rânduri în measurements |
| `n_attach` | INTEGER |  | rânduri în attach |
| `n_acceptance` | INTEGER |  | rânduri în acceptance |
| `n_sessions` | INTEGER |  | rânduri în sessions |
| `n_voice_calls` | INTEGER |  | rânduri în voice_calls |
| `n_rf_probes` | INTEGER |  | rânduri în rf_probes și rf_band_scan |

## `events`

Un rând este un eveniment fizic pe masa de laborator. Rânduri: 23.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `kind` | TEXT |  | host_boot, host_reboot, host_off, power_cycle, hardware, setup, observation |
| `note` | TEXT |  | ce s-a întâmplat |

## `measurements`

Un rând este o măsurătoare: o legătură stabilită, pe care s-au făcut teste. Rânduri: 725.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `meas_id` | INTEGER |  | cheia măsurătorii |
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `iter` | INTEGER |  | numărul iterației sau al repetării în serie |
| `session` | INTEGER |  | numărul sesiunii în serie. O sesiune nouă începe la fiecare reatașare a UE-ului |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `rf_port` | TEXT |  | placa RF folosită: A, B sau TX A / RX B (emisie pe placa A, recepție pe placa B). Gol dacă nu a fost notată |
| `form` | TEXT |  | forma iterației în campania Open5GBox: long (TCP 30 s, 200 de pinguri), fast (TCP 8 s, UDP 6 s, 50 de pinguri), tuning |
| `gnb_conf` | TEXT |  | fișierul de configurare al gNB-ului, din stack/conf_files |
| `conf_sha` | TEXT |  | primele 12 caractere din sha256 al fișierului de configurare |
| `att_tx` | REAL | dB | atenuarea la emisie a gNB-ului (0 = putere maximă) |
| `max_rxgain` | REAL |  | parametrul max_rxgain al gNB-ului |
| `ue_txgain` | REAL | dB | atenuarea la emisie a UE-ului software |
| `ue_rxgain` | REAL |  | câștigul de recepție al UE-ului software |
| `host_uptime_s` | REAL | s | de cât timp era pornit USRP-2974 |
| `since_attach_s` | REAL | s | de cât timp era atașat UE-ul la începutul iterației |
| `attach_attempts` | INTEGER |  | a câta încercare de atașare a reușit pentru această legătură |
| `attach_s` | REAL | s | durata pornirii lanțului până la stabilirea legăturii, cu tot cu reîncercări |
| `cpu_avg_pct` | REAL | % | încărcarea medie a procesorului în timpul testului TCP DL |
| `cpu_max_core_pct` | REAL | % | încărcarea celui mai încărcat nucleu în timpul testului TCP DL |
| `ue_late_tx` | REAL |  | transmisii întârziate numărate în jurnalul UE-ului în timpul iterației |
| `alive_at_end` | INTEGER |  | 1 dacă legătura mai răspundea la ping la sfârșitul iterației |
| `throughput_valid` | INTEGER |  | 0 pentru iterațiile la care testele de debit nu sunt valabile din cauza scriptului (adresa UE-ului schimbată după reînregistrare). Latența rămâne valabilă |
| `note` | TEXT |  | nota scrisă de script sau de operator la rulare |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `throughput`

Un rând este un test de debit, într-un singur sens. Rânduri: 2003.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `meas_id` | INTEGER |  | măsurătoarea din care face parte rândul, cheie în tabelul measurements |
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `tool` | TEXT |  | scriptul care a rulat testul |
| `test` | TEXT |  | single (un test izolat), sweep (treaptă dintr-o scară de debite UDP), soak (trafic de lungă durată), echo_ladder (scară de încărcare prin ecou spre telefon) |
| `proto` | TEXT |  | tcp, udp sau icmp |
| `dir` | TEXT |  | DL (spre UE), UL (dinspre UE), DL+UL pentru ecou |
| `offered_mbps` | REAL | Mbit/s | debitul oferit. Gol la TCP fără limită de debit |
| `duration_s` | REAL | s | durata nominală a testului |
| `mbps` | REAL | Mbit/s | debitul măsurat la receptor. Gol dacă testul a eșuat |
| `loss_pct` | REAL | % | pachete pierdute |
| `jitter_ms` | REAL | ms | jitter raportat de iperf3 (RFC 3550) |
| `retransmits` | REAL |  | retransmisii TCP raportate de iperf3 |
| `complete` | INTEGER |  | 1 dacă testul s-a încheiat cu un rezultat |
| `cut_short` | INTEGER |  | 1 dacă testul TCP s-a oprit înainte de termen și debitul este media secundelor măsurate |
| `rep` | INTEGER |  | numărul repetării, acolo unde același test se repetă în aceeași măsurătoare |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `latency`

Un rând este un test de ping. Rânduri: 1141.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `meas_id` | INTEGER |  | măsurătoarea din care face parte rândul, cheie în tabelul measurements |
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `tool` | TEXT |  | scriptul care a rulat testul |
| `condition` | TEXT |  | idle (fără trafic), loaded_dl sau loaded_ul (în timpul unui test UDP), size_N (pachete de N octeți), in_call (în timpul unui apel), echo_load (scara de încărcare spre telefon) |
| `size_bytes` | INTEGER | octeți | mărimea pachetului |
| `sent` | INTEGER |  | pinguri trimise |
| `received` | INTEGER |  | răspunsuri primite |
| `loss_pct` | REAL | % | pinguri pierdute |
| `avg_ms` | REAL | ms | RTT mediu |
| `median_ms` | REAL | ms | RTT median |
| `p95_ms` | REAL | ms | percentila 95 a RTT |
| `max_ms` | REAL | ms | RTT maxim |
| `jitter_ms` | REAL | ms | media diferențelor absolute dintre RTT-uri consecutive |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `radio`

Un rând este indicatori radio citiți de la gNB la un test. Rânduri: 570.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `meas_id` | INTEGER |  | măsurătoarea din care face parte rândul, cheie în tabelul measurements |
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `moment` | TEXT |  | când s-a făcut citirea |
| `snr_ul_db` | REAL | dB | SNR pe UL, măsurat de gNB |
| `rsrp_dbm` | REAL | dBm | RSRP raportat de UE |
| `ph_db` | REAL | dB | rezerva de putere raportată de UE (power headroom) |
| `cqi` | REAL |  | CQI raportat de UE |
| `dl_mcs` | REAL |  | MCS pe DL |
| `ul_mcs` | REAL |  | MCS pe UL |
| `dl_bler` | REAL |  | rata de erori pe bloc pe DL, între 0 și 1 |
| `ul_bler` | REAL |  | rata de erori pe bloc pe UL, între 0 și 1 |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `attach`

Un rând este o pornire la rece a lanțului (UE software) sau o repornire a celulei (telefoane). Rânduri: 459.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `policy` | TEXT |  | single (o singură încercare), retry (run.sh reîncearcă singur), mixed (20 septembrie, regula s-a schimbat între serii), cell_restart (telefoane: celula oprită și repornită) |
| `max_attempts` | INTEGER |  | câte încercări erau permise |
| `wait_s` | REAL | s | cât se așteaptă până când o încercare este declarată eșuată |
| `attempts` | INTEGER |  | câte încercări s-au făcut |
| `attached` | INTEGER |  | 1 dacă legătura s-a stabilit |
| `first_attempt` | INTEGER |  | 1 dacă s-a atașat din prima încercare |
| `duration_s` | REAL | s | durata pornirii: tot lanțul, de la comanda de pornire până la stabilirea legăturii sau până la declararea eșecului (UE software), respectiv de la pornirea emisiei celulei până la sesiunea de date (telefoane) |
| `ue_attach_s` | REAL | s | doar pentru UE-ul software, din 4 octombrie: de la pornirea containerului UE până la atașare |
| `failure` | TEXT |  | cauza eșecului: cr_fail (eșec la Msg4, rezolvarea conflictului de acces), assert (eroare assert în UHD), synch_failed (sincronizare eșuată), sib1_nack (SIB1 nedecodat), other (altă cauză), unknown (necunoscută) |
| `cfo_hz` | REAL | Hz | decalajul de frecvență măsurat de UE |
| `n_ra` | INTEGER |  | proceduri de acces aleator numărate la gNB |
| `host_uptime_s` | REAL | s | de cât timp era pornit USRP-2974 |
| `phone_ip` | TEXT |  | adresa primită de telefon |
| `phone_order` | INTEGER |  | al câtelea telefon s-a atașat după repornirea celulei |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `acceptance`

Un rând este o rulare a testului de acceptanță al configurației de referință (TCP cu debit limitat, 600 s pe sens, apoi două fișiere verificate cu sha256). Rânduri: 19.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `run` | INTEGER |  | numărul rulării în campanie |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `target_dl_mbps` | REAL | Mbit/s | debitul TCP cerut pe DL (limita impusă) |
| `target_ul_mbps` | REAL | Mbit/s | debitul TCP cerut pe UL (limita impusă) |
| `radio_uptime_s` | REAL | s | de cât timp erau alimentate radiourile |
| `attempts` | INTEGER |  | încercări de atașare |
| `passed` | INTEGER |  | 1 dacă rularea a trecut toate fazele |
| `dead_after_s` | REAL | s | după câte secunde a căzut legătura, dacă a căzut |
| `dead_in` | TEXT |  | faza în care a căzut legătura |
| `tcp_dl_mbps` | REAL | Mbit/s | debitul TCP obținut pe DL, cu limita impusă |
| `tcp_ul_mbps` | REAL | Mbit/s | debitul TCP obținut pe UL, cu limita impusă |
| `file_dl_mbps` | REAL | Mbit/s | debitul la transferul fișierului de 20 MB spre UE |
| `file_ul_mbps` | REAL | Mbit/s | debitul la transferul fișierului de 5 MB dinspre UE |
| `file_dl_ok` | INTEGER |  | 1 dacă fișierul primit de UE are sha256 identic cu originalul |
| `file_ul_ok` | INTEGER |  | 1 dacă fișierul trimis de UE are sha256 identic cu originalul |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `sessions`

Un rând este o sesiune de trafic din testele de rezistență sub trafic. Rânduri: 42.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `session` | TEXT |  | identificatorul sesiunii (folderul rulării) |
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `tool` | TEXT |  | scriptul: stability, soak, soak2 |
| `traffic` | TEXT |  | tipul de trafic |
| `tune` | INTEGER |  | 1 dacă reglajele calculatorului erau aplicate (stările de repaus ale procesorului dezactivate) |
| `pin` | TEXT |  | nucleele de procesor rezervate pentru core |
| `attached` | INTEGER |  | 1 dacă legătura s-a stabilit |
| `attach_s` | REAL | s | durata pornirii |
| `attempts` | INTEGER |  | încercări de atașare |
| `ttf_s` | REAL | s | timpul până la căderea legăturii |
| `censored` | INTEGER |  | 1 dacă sesiunea s-a încheiat fără cădere (date cenzurate la dreapta) |
| `died_in` | TEXT |  | faza în care a căzut legătura |
| `reason` | TEXT |  | cauza încheierii |
| `ue_late` | REAL |  | transmisii întârziate numărate la UE |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `phases`

Un rând este o fază de trafic dintr-o sesiune sau dintr-o rulare de acceptanță. Rânduri: 133.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `session` | TEXT |  | sesiunea sau rularea din care face parte faza |
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `phase` | TEXT |  | tipul fazei: tcpr_dl și tcpr_ul (TCP cu debit limitat), udp_dl, udp_ul, file_dl, file_ul, bidir și altele |
| `arg` | TEXT |  | parametrul fazei: debit în Mbit/s sau mărimea fișierului în MB |
| `completed` | INTEGER |  | 1 dacă faza s-a încheiat |
| `mbps` | REAL | Mbit/s | debitul obținut |
| `loss_pct` | REAL | % | pierderi, la fazele UDP |
| `sha_ok` | INTEGER |  | 1 dacă fișierul transferat are sha256 identic cu originalul |
| `valid` | INTEGER |  | 0 pentru fazele cu fișiere trimise prin iperf3 -F, care nu sunt valabile |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `voice_calls`

Un rând este un telefon într-un apel VoIP măsurat (Linphone, server Asterisk, codec G.711). Rânduri: 4.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `call` | TEXT |  | numele apelului |
| `campaign` | TEXT |  | campania din care face parte rândul, cheie în tabelul campaigns |
| `series` | TEXT |  | seria din interiorul campaniei: eticheta rulării sau varianta de configurație |
| `medium` | TEXT |  | mediul dintre radiouri: coax (cablu coaxial) sau ota (antene) |
| `antenna_cm` | REAL | cm | distanța dintre antenele celor două radiouri, doar pentru ota. Gol dacă nu a fost notată |
| `cell_prb` | INTEGER | PRB | lățimea celulei: 24 PRB (8,64 MHz) sau 51 PRB (18,36 MHz), 30 kHz între subpurtătoare |
| `antennas` | TEXT |  | antene la gNB, emisie x recepție: 1x1, 1x2, 2x2 |
| `ue` | TEXT |  | terminalul: oai_ue (UE-ul software OAI pe USRP-2953R) sau phone (Samsung S25) |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `phone` | TEXT |  | contul telefonului: 1101 sau 1102 |
| `phone_ip` | TEXT |  | adresa telefonului în rețea |
| `codec` | TEXT |  | codecul audio |
| `duration_s` | REAL | s | durata măsurată |
| `ul_packets` | INTEGER |  | pachete RTP primite de la telefon, numărate în captura de pe USRP-2974 |
| `ul_lost` | INTEGER |  | pachete RTP pierdute pe UL, din numerele de secvență |
| `ul_loss_pct` | REAL | % | pierderi RTP pe UL |
| `ul_jitter_ms` | REAL | ms | jitter RTP mediu pe UL (RFC 3550) |
| `ul_jitter_max_ms` | REAL | ms | jitter RTP maxim pe UL |
| `ul_delay_var_p50_ms` | REAL | ms | variația întârzierii pe UL, mediană |
| `ul_delay_var_p95_ms` | REAL | ms | variația întârzierii pe UL, percentila 95 |
| `ul_delay_var_max_ms` | REAL | ms | variația întârzierii pe UL, maxim |
| `ul_longest_loss_burst` | INTEGER | pachete | cea mai lungă rafală de pachete pierdute pe UL |
| `dl_packets` | INTEGER |  | pachete RTP trimise de server spre telefon |
| `dl_lost` | INTEGER |  | pachete RTP pierdute pe DL, raportate de telefon prin RTCP |
| `dl_loss_pct` | REAL | % | pierderi RTP pe DL, raportate de telefon |
| `dl_jitter_ms` | REAL | ms | jitter RTP median pe DL, raportat de telefon |
| `dl_jitter_max_ms` | REAL | ms | jitter RTP maxim pe DL, raportat de telefon |
| `rtcp_rtt_median_ms` | REAL | ms | timpul dus-întors raportat prin RTCP, mediană |
| `rtcp_rtt_max_ms` | REAL | ms | timpul dus-întors raportat prin RTCP, maxim |
| `ping_sent` | INTEGER |  | pinguri trimise spre telefon în timpul apelului |
| `ping_loss_pct` | REAL | % | pinguri pierdute în timpul apelului |
| `ping_p50_ms` | REAL | ms | RTT median în timpul apelului |
| `ping_p95_ms` | REAL | ms | percentila 95 a RTT în timpul apelului |
| `ping_max_ms` | REAL | ms | RTT maxim în timpul apelului |
| `cell_ra_started` | INTEGER |  | proceduri de acces aleator la gNB pe durata apelului (ambele telefoane) |
| `cell_ul_failures` | INTEGER |  | avertizări de pierdere a legăturii pe UL la gNB pe durata apelului (ambele telefoane) |
| `cell_rrc_release` | INTEGER |  | eliberări RRC pe durata apelului (ambele telefoane) |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `rf_probes`

Un rând este o citire de ton sau de zgomot între două porturi RF, cu celula oprită. Rânduri: 62.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `probe` | TEXT |  | unealta: ant_probe, self_probe, port_map |
| `label` | TEXT |  | eticheta rulării |
| `stage` | TEXT |  | ce s-a măsurat: zgomot fără emițător, cale între radiouri, cuplaj pe același radio |
| `tx_radio` | TEXT |  | radioul care emite. Gol dacă nu emite niciunul |
| `tx_port` | TEXT |  | portul de emisie |
| `tx_gain` | REAL | dB | câștigul de emisie |
| `rx_radio` | TEXT |  | radioul care ascultă |
| `rx_port` | TEXT |  | portul de recepție |
| `rx_gain` | REAL | dB | câștigul de recepție |
| `state` | TEXT |  | starea emițătorului: oprit, pornit fără date (zeros), ton |
| `inband_dbfs` | REAL | dBFS | puterea în banda celulei |
| `carrier_dbfs` | REAL | dBFS | puterea la purtătoare |
| `tone_dbfs` | REAL | dBFS | puterea tonului de probă |
| `total_dbfs` | REAL | dBFS | puterea totală |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `rf_band_scan`

Un rând este o ascultare pasivă a benzii pe o frecvență, cu celula oprită. Rânduri: 16.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `label` | TEXT |  | eticheta rulării |
| `radio` | TEXT |  | radioul care ascultă |
| `port` | TEXT |  | portul de recepție |
| `freq_mhz` | REAL | MHz | frecvența centrală |
| `rx_gain` | REAL | dB | câștigul de recepție |
| `seconds` | REAL | s | durata ascultării |
| `p10_dbfs` | REAL | dBFS | percentila 10 a puterii |
| `p50_dbfs` | REAL | dBFS | mediana puterii |
| `p90_dbfs` | REAL | dBFS | percentila 90 a puterii |
| `p99_dbfs` | REAL | dBFS | percentila 99 a puterii |
| `max_dbfs` | REAL | dBFS | puterea maximă |
| `share_10db_above_p10` | REAL |  | fracțiunea de timp cu puterea la peste 10 dB deasupra percentilei 10 |
| `period_ms` | REAL | ms | perioada dominantă găsită în semnal |
| `period_strength` | REAL |  | cât de pronunțată este perioada, între 0 și 1 |
| `spectrum_1mhz_dbfs` | TEXT | dBFS | puterea pe 12 benzi de câte 1 MHz, de la stânga la dreapta |
| `source` | TEXT |  | fișierul brut din care vine rândul, relativ la rădăcina depozitului |

## `rtt_samples`

Un rând este un răspuns la ping. Rânduri: 37893.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `meas_id` | INTEGER |  | măsurătoarea din care face parte rândul, cheie în tabelul measurements |
| `condition` | TEXT |  | ca în tabelul latency |
| `seq` | INTEGER |  | numărul de ordine al pingului |
| `rtt_ms` | REAL | ms | timpul dus-întors |

## `tcp_seconds`

Un rând este un interval de 1 s dintr-un test TCP. Rânduri: 8134.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `meas_id` | INTEGER |  | măsurătoarea din care face parte rândul, cheie în tabelul measurements |
| `dir` | TEXT |  | DL sau UL |
| `rep` | INTEGER |  | repetarea testului în măsurătoare |
| `second` | INTEGER | s | secunda de la începutul testului |
| `mbps` | REAL | Mbit/s | debitul în acea secundă |

## `cpu_samples`

Un rând este un eșantion de încărcare a procesorului pe USRP-2974. Rânduri: 28606.

| Coloană | Tip | Unitate | Descriere |
|---|---|---|---|
| `capture` | TEXT |  | campania sau folderul brut din care vine captura |
| `time` | TEXT |  | ora de început, ISO 8601, ora României |
| `who` | TEXT |  | cpu0 până la cpu3 (nucleu), gnb sau ue (container) |
| `pct` | REAL | % | încărcarea. La containere 100 % înseamnă un nucleu întreg |
| `period_s` | REAL | s | perioada de eșantionare |

## Vederi

| Vedere | Ce conține |
|---|---|
| `v_measurements` | tabelul lat: o măsurătoare pe rând, cu toți indicatorii ei. Din el se scrie masuratori_5g.csv |
| `v_summary_series` | rezumat pe serie: medii și număr de măsurători, doar campaniile de raportat |
| `v_summary_attach` | rata de atașare pe campanie și serie |
| `v_summary_acceptance` | testul de acceptanță golden pe campanie |
