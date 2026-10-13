# 5G-SHARE Lab: measurements of an all-in-one open-source 5G standalone testbed

Results only. This repository holds the measurement data of a laboratory 5G standalone network, collected between
20 September and 5 October 2026. It contains no source code, no network configuration and no raw logs.

## Testbed

- Complete OpenAirInterface network (core, gNB, software UE) in containers on one NI USRP-2974 (embedded computer with an
  integrated X310-class radio). A second radio, NI USRP-2953R, is the radio of the software UE.
- Band n78, carrier 3748.8 MHz, 30 kHz subcarrier spacing, TDD, cells of 24 PRB (8.64 MHz) and 51 PRB (18.36 MHz).
- The two radios are connected by coaxial cables (`coax`) or by antennas (`ota`).
- From 4 October 2026 two commercial smartphones (Samsung Galaxy S25) are also attached, with voice over the data session.

## Files

| File | Content |
|---|---|
| `5g_share_lab.sqlite` | the complete database: 16 tables, 4 views and the data dictionary |
| `csv/` | every table and every summary view as a CSV file |
| `measurements_wide.csv` | one measured link per row, with all its indicators on the same row |
| `measurements_wide.xlsx` | the same table, the main tables and the dictionary, one sheet each |
| `schema.sql` | table definitions with types and keys |
| `DATA_DICTIONARY_ro.md` | every table and column with its unit (descriptions in Romanian, column names in English) |

CSV files use a comma as separator, a point as decimal separator and UTF-8 encoding. Times are local time of Romania
with the UTC offset.

## Tables

| Table | Rows | One row is |
|---|---|---|
| `campaigns` | 39 | a measurement campaign: its question, method and tool |
| `events` | 23 | a physical event on the bench: power cycle, antennas moved, cables changed |
| `measurements` | 725 | a link that was started and on which tests were run |
| `throughput` | 2003 | a rate test in one direction (TCP or UDP) |
| `latency` | 1141 | an echo (ping) test |
| `radio` | 570 | radio-layer indicators read from the gNB next to a test |
| `attach` | 459 | a cold start of the chain, or a restart of the cell for the smartphones |
| `acceptance` | 19 | a run of the acceptance test |
| `sessions` | 42 | a traffic session followed until the link failed |
| `phases` | 133 | a traffic phase of a session or of an acceptance run |
| `voice_calls` | 4 | one phone in a measured voice call |
| `rf_probes` | 62 | a tone or noise reading between two RF ports, cell switched off |
| `rf_band_scan` | 16 | a passive scan of the band, cell switched off |
| `rtt_samples` | 37 893 | one echo reply |
| `tcp_seconds` | 8134 | one second of a TCP test |
| `cpu_samples` | 28 606 | one sample of processor load |

```
campaigns --+-- measurements --+-- throughput
            |                  +-- latency
            |                  +-- radio
            |                  +-- rtt_samples
            |                  +-- tcp_seconds
            +-- attach
            +-- acceptance ---- phases
            +-- sessions ------ phases
            +-- voice_calls

events, rf_probes, rf_band_scan, cpu_samples are linked by time
```

Every measurement table repeats the same context columns, so each CSV can be read alone:

| Column | Values |
|---|---|
| `campaign` | identifier of the campaign, key of `campaigns` |
| `series` | series inside the campaign (run label or configuration variant) |
| `medium` | `coax` or `ota` (antennas) |
| `antenna_cm` | distance between the antennas, for `ota` only |
| `cell_prb` | 24 or 51 |
| `antennas` | gNB antennas, transmit x receive: `1x1`, `1x2`, `2x2` |
| `ue` | `oai_ue` (software UE) or `phone` |

The column `purpose` of `campaigns` separates reportable measurements (`campaign`) from gain searches (`tuning`),
script checks (`smoke`) and RF probes (`diagnostic`). The summary views use `campaign` only.

## Rules used when the database was built

- A test that delivered nothing is a failed test (`complete = 0`, empty `mbps`), not a rate of 0.
- TCP throughput of the October campaign is the rate measured at the receiver. If a test ended early, it is the mean of
  the seconds that exist and `cut_short = 1`.
- In the night of 4 to 5 October the software UE registered again by itself with another address while the script kept
  the old one. These rows have `throughput_valid = 0`: their latency is valid, their rate tests are missing.
- Rows are never deleted. Invalid rows are flagged.
- The column `source` names the raw file a row comes from. The raw files are not part of this repository.

## Example

```python
import sqlite3, pandas as pd
con = sqlite3.connect("5g_share_lab.sqlite")
m = pd.read_sql("select * from v_measurements", con)
```

```sql
SELECT medium, cell_prb, wait_s, COUNT(*) AS starts, SUM(attached) AS attached
FROM attach WHERE policy = 'single' AND ue = 'oai_ue'
GROUP BY medium, cell_prb, wait_s;
```

## Not included

Raw logs of the gNB and of the UE, packet captures, container definitions and cell configurations are not published,
because the logs contain the authentication keys of the test subscribers.

## Funding

Co-funded by the European Union through the Connecting Europe Facility (CEF Digital), project 101241240, 5G-SHARE:
5G Scalable Hubs for Accessible and Resilient Education. Views and opinions expressed are however those of the authors
only and do not necessarily reflect those of the European Union or the European Health and Digital Executive Agency
(HaDEA). Neither the European Union nor the granting authority can be held responsible for them.

## Licence and contact

Data are released under the Creative Commons Attribution 4.0 International licence (CC BY 4.0), see `LICENSE`.

Contact: Teodor Giurgică, Technical University of Cluj-Napoca, Giurgica.Da.Teodor@student.utcluj.ro
