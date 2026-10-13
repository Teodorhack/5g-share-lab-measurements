CREATE TABLE "campaigns" (
  "campaign" TEXT PRIMARY KEY,
  "date" TEXT,
  "start" TEXT,
  "end" TEXT,
  "purpose" TEXT,
  "medium" TEXT,
  "antenna_cm" TEXT,
  "cell_prb" TEXT,
  "ue" TEXT,
  "tool" TEXT,
  "attach_method" TEXT,
  "tcp_s" TEXT,
  "udp_s" TEXT,
  "udp_offered" TEXT,
  "ping" TEXT,
  "reps" TEXT,
  "radios" TEXT,
  "question" TEXT,
  "n_measurements" INTEGER,
  "n_attach" INTEGER,
  "n_acceptance" INTEGER,
  "n_sessions" INTEGER,
  "n_voice_calls" INTEGER,
  "n_rf_probes" INTEGER
);

CREATE TABLE "events" (
  "time" TEXT,
  "kind" TEXT,
  "note" TEXT
);

CREATE TABLE "measurements" (
  "meas_id" INTEGER PRIMARY KEY,
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "iter" INTEGER,
  "session" INTEGER,
  "time" TEXT,
  "rf_port" TEXT,
  "form" TEXT,
  "gnb_conf" TEXT,
  "conf_sha" TEXT,
  "att_tx" REAL,
  "max_rxgain" REAL,
  "ue_txgain" REAL,
  "ue_rxgain" REAL,
  "host_uptime_s" REAL,
  "since_attach_s" REAL,
  "attach_attempts" INTEGER,
  "attach_s" REAL,
  "cpu_avg_pct" REAL,
  "cpu_max_core_pct" REAL,
  "ue_late_tx" REAL,
  "alive_at_end" INTEGER,
  "throughput_valid" INTEGER,
  "note" TEXT,
  "source" TEXT
);

CREATE TABLE "throughput" (
  "meas_id" INTEGER NOT NULL REFERENCES measurements(meas_id),
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "time" TEXT,
  "tool" TEXT,
  "test" TEXT,
  "proto" TEXT,
  "dir" TEXT,
  "offered_mbps" REAL,
  "duration_s" REAL,
  "mbps" REAL,
  "loss_pct" REAL,
  "jitter_ms" REAL,
  "retransmits" REAL,
  "complete" INTEGER,
  "cut_short" INTEGER,
  "rep" INTEGER,
  "source" TEXT
);

CREATE TABLE "latency" (
  "meas_id" INTEGER NOT NULL REFERENCES measurements(meas_id),
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "time" TEXT,
  "tool" TEXT,
  "condition" TEXT,
  "size_bytes" INTEGER,
  "sent" INTEGER,
  "received" INTEGER,
  "loss_pct" REAL,
  "avg_ms" REAL,
  "median_ms" REAL,
  "p95_ms" REAL,
  "max_ms" REAL,
  "jitter_ms" REAL,
  "source" TEXT
);

CREATE TABLE "radio" (
  "meas_id" INTEGER NOT NULL REFERENCES measurements(meas_id),
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "time" TEXT,
  "moment" TEXT,
  "snr_ul_db" REAL,
  "rsrp_dbm" REAL,
  "ph_db" REAL,
  "cqi" REAL,
  "dl_mcs" REAL,
  "ul_mcs" REAL,
  "dl_bler" REAL,
  "ul_bler" REAL,
  "source" TEXT
);

CREATE TABLE "attach" (
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "time" TEXT,
  "policy" TEXT,
  "max_attempts" INTEGER,
  "wait_s" REAL,
  "attempts" INTEGER,
  "attached" INTEGER,
  "first_attempt" INTEGER,
  "duration_s" REAL,
  "ue_attach_s" REAL,
  "failure" TEXT,
  "cfo_hz" REAL,
  "n_ra" INTEGER,
  "host_uptime_s" REAL,
  "phone_ip" TEXT,
  "phone_order" INTEGER,
  "source" TEXT
);

CREATE TABLE "acceptance" (
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "run" INTEGER,
  "time" TEXT,
  "target_dl_mbps" REAL,
  "target_ul_mbps" REAL,
  "radio_uptime_s" REAL,
  "attempts" INTEGER,
  "passed" INTEGER,
  "dead_after_s" REAL,
  "dead_in" TEXT,
  "tcp_dl_mbps" REAL,
  "tcp_ul_mbps" REAL,
  "file_dl_mbps" REAL,
  "file_ul_mbps" REAL,
  "file_dl_ok" INTEGER,
  "file_ul_ok" INTEGER,
  "source" TEXT
);

CREATE TABLE "sessions" (
  "session" TEXT,
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "time" TEXT,
  "tool" TEXT,
  "traffic" TEXT,
  "tune" INTEGER,
  "pin" TEXT,
  "attached" INTEGER,
  "attach_s" REAL,
  "attempts" INTEGER,
  "ttf_s" REAL,
  "censored" INTEGER,
  "died_in" TEXT,
  "reason" TEXT,
  "ue_late" REAL,
  "source" TEXT
);

CREATE TABLE "phases" (
  "session" TEXT,
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "phase" TEXT,
  "arg" TEXT,
  "completed" INTEGER,
  "mbps" REAL,
  "loss_pct" REAL,
  "sha_ok" INTEGER,
  "valid" INTEGER,
  "source" TEXT
);

CREATE TABLE "voice_calls" (
  "call" TEXT,
  "campaign" TEXT NOT NULL REFERENCES campaigns(campaign),
  "series" TEXT,
  "medium" TEXT,
  "antenna_cm" REAL,
  "cell_prb" INTEGER,
  "antennas" TEXT,
  "ue" TEXT,
  "time" TEXT,
  "phone" TEXT,
  "phone_ip" TEXT,
  "codec" TEXT,
  "duration_s" REAL,
  "ul_packets" INTEGER,
  "ul_lost" INTEGER,
  "ul_loss_pct" REAL,
  "ul_jitter_ms" REAL,
  "ul_jitter_max_ms" REAL,
  "ul_delay_var_p50_ms" REAL,
  "ul_delay_var_p95_ms" REAL,
  "ul_delay_var_max_ms" REAL,
  "ul_longest_loss_burst" INTEGER,
  "dl_packets" INTEGER,
  "dl_lost" INTEGER,
  "dl_loss_pct" REAL,
  "dl_jitter_ms" REAL,
  "dl_jitter_max_ms" REAL,
  "rtcp_rtt_median_ms" REAL,
  "rtcp_rtt_max_ms" REAL,
  "ping_sent" INTEGER,
  "ping_loss_pct" REAL,
  "ping_p50_ms" REAL,
  "ping_p95_ms" REAL,
  "ping_max_ms" REAL,
  "cell_ra_started" INTEGER,
  "cell_ul_failures" INTEGER,
  "cell_rrc_release" INTEGER,
  "source" TEXT
);

CREATE TABLE "rf_probes" (
  "time" TEXT,
  "probe" TEXT,
  "label" TEXT,
  "stage" TEXT,
  "tx_radio" TEXT,
  "tx_port" TEXT,
  "tx_gain" REAL,
  "rx_radio" TEXT,
  "rx_port" TEXT,
  "rx_gain" REAL,
  "state" TEXT,
  "inband_dbfs" REAL,
  "carrier_dbfs" REAL,
  "tone_dbfs" REAL,
  "total_dbfs" REAL,
  "source" TEXT
);

CREATE TABLE "rf_band_scan" (
  "time" TEXT,
  "label" TEXT,
  "radio" TEXT,
  "port" TEXT,
  "freq_mhz" REAL,
  "rx_gain" REAL,
  "seconds" REAL,
  "p10_dbfs" REAL,
  "p50_dbfs" REAL,
  "p90_dbfs" REAL,
  "p99_dbfs" REAL,
  "max_dbfs" REAL,
  "share_10db_above_p10" REAL,
  "period_ms" REAL,
  "period_strength" REAL,
  "spectrum_1mhz_dbfs" TEXT,
  "source" TEXT
);

CREATE TABLE "rtt_samples" (
  "meas_id" INTEGER NOT NULL REFERENCES measurements(meas_id),
  "condition" TEXT,
  "seq" INTEGER,
  "rtt_ms" REAL
);

CREATE TABLE "tcp_seconds" (
  "meas_id" INTEGER NOT NULL REFERENCES measurements(meas_id),
  "dir" TEXT,
  "rep" INTEGER,
  "second" INTEGER,
  "mbps" REAL
);

CREATE TABLE "cpu_samples" (
  "capture" TEXT,
  "time" TEXT,
  "who" TEXT,
  "pct" REAL,
  "period_s" REAL
);

CREATE TABLE data_dictionary (object TEXT, kind TEXT, column TEXT, type TEXT, unit TEXT, description TEXT);

CREATE INDEX idx_throughput_meas_id ON "throughput" ("meas_id");

CREATE INDEX idx_latency_meas_id ON "latency" ("meas_id");

CREATE INDEX idx_radio_meas_id ON "radio" ("meas_id");

CREATE INDEX idx_rtt_samples_meas_id ON "rtt_samples" ("meas_id");

CREATE INDEX idx_tcp_seconds_meas_id ON "tcp_seconds" ("meas_id");

CREATE INDEX idx_measurements_campaign ON "measurements" ("campaign");

CREATE INDEX idx_attach_campaign ON "attach" ("campaign");

CREATE VIEW v_measurements AS
SELECT m.meas_id, substr(m.time, 1, 10) AS date, m.time, m.campaign, c.purpose, m.series, m.medium, m.antenna_cm, m.cell_prb, m.antennas, m.ue,
       m.rf_port, m.form, m.iter, m.session, m.gnb_conf, m.att_tx, m.max_rxgain, m.ue_txgain, m.ue_rxgain,
       m.host_uptime_s, m.since_attach_s, m.attach_attempts, m.attach_s,
       li.sent AS ping_sent, li.loss_pct AS ping_loss_pct, li.avg_ms AS rtt_avg_ms, li.median_ms AS rtt_median_ms, li.p95_ms AS rtt_p95_ms,
       li.max_ms AS rtt_max_ms, li.jitter_ms AS rtt_jitter_ms,
       td.mbps AS tcp_dl_mbps, tu.mbps AS tcp_ul_mbps,
       ud.offered AS udp_dl_offered_mbps, ud.mbps AS udp_dl_mbps, ud.loss AS udp_dl_loss_pct, ud.jitter AS udp_dl_jitter_ms,
       uu.offered AS udp_ul_offered_mbps, uu.mbps AS udp_ul_mbps, uu.loss AS udp_ul_loss_pct, uu.jitter AS udp_ul_jitter_ms,
       ll.avg_ms AS rtt_loaded_avg_ms, ll.p95_ms AS rtt_loaded_p95_ms, ll.loss_pct AS rtt_loaded_loss_pct,
       r.snr_ul_db, r.rsrp_dbm, r.dl_mcs, r.ul_mcs, r.dl_bler, r.ul_bler,
       m.cpu_avg_pct, m.cpu_max_core_pct, m.ue_late_tx, m.alive_at_end, m.throughput_valid, m.note, m.source
FROM measurements m
JOIN campaigns c ON c.campaign = m.campaign
LEFT JOIN (SELECT meas_id, SUM(sent) AS sent, ROUND(AVG(loss_pct), 2) AS loss_pct, ROUND(AVG(avg_ms), 2) AS avg_ms, ROUND(AVG(median_ms), 2) AS median_ms,
                  ROUND(AVG(p95_ms), 2) AS p95_ms, ROUND(MAX(max_ms), 2) AS max_ms, ROUND(AVG(jitter_ms), 2) AS jitter_ms
           FROM latency WHERE condition IN ('idle', 'in_call') GROUP BY meas_id) li ON li.meas_id = m.meas_id
LEFT JOIN (SELECT meas_id, ROUND(AVG(avg_ms), 2) AS avg_ms, ROUND(AVG(p95_ms), 2) AS p95_ms, ROUND(AVG(loss_pct), 2) AS loss_pct
           FROM latency WHERE condition LIKE 'loaded%' GROUP BY meas_id) ll ON ll.meas_id = m.meas_id
LEFT JOIN (SELECT meas_id, ROUND(AVG(mbps), 3) AS mbps FROM throughput
           WHERE proto = 'tcp' AND dir = 'DL' AND test = 'single' AND offered_mbps IS NULL AND complete = 1 GROUP BY meas_id) td ON td.meas_id = m.meas_id
LEFT JOIN (SELECT meas_id, ROUND(AVG(mbps), 3) AS mbps FROM throughput
           WHERE proto = 'tcp' AND dir = 'UL' AND test = 'single' AND offered_mbps IS NULL AND complete = 1 GROUP BY meas_id) tu ON tu.meas_id = m.meas_id
LEFT JOIN (SELECT meas_id, MAX(offered_mbps) AS offered, ROUND(AVG(mbps), 3) AS mbps, ROUND(AVG(loss_pct), 2) AS loss, ROUND(AVG(jitter_ms), 3) AS jitter
           FROM throughput WHERE proto = 'udp' AND dir = 'DL' AND test = 'single' AND complete = 1 GROUP BY meas_id) ud ON ud.meas_id = m.meas_id
LEFT JOIN (SELECT meas_id, MAX(offered_mbps) AS offered, ROUND(AVG(mbps), 3) AS mbps, ROUND(AVG(loss_pct), 2) AS loss, ROUND(AVG(jitter_ms), 3) AS jitter
           FROM throughput WHERE proto = 'udp' AND dir = 'UL' AND test = 'single' AND complete = 1 GROUP BY meas_id) uu ON uu.meas_id = m.meas_id
LEFT JOIN (SELECT meas_id, ROUND(AVG(snr_ul_db), 1) AS snr_ul_db, ROUND(AVG(rsrp_dbm), 1) AS rsrp_dbm, ROUND(AVG(dl_mcs), 1) AS dl_mcs,
                  ROUND(AVG(ul_mcs), 1) AS ul_mcs, ROUND(AVG(dl_bler), 4) AS dl_bler, ROUND(AVG(ul_bler), 4) AS ul_bler
           FROM radio GROUP BY meas_id) r ON r.meas_id = m.meas_id
ORDER BY m.time, m.meas_id;

CREATE VIEW v_summary_series AS
SELECT campaign, series, medium, antenna_cm, cell_prb, antennas, ue, rf_port, MIN(time) AS first, MAX(time) AS last, COUNT(*) AS measurements,
       COUNT(tcp_dl_mbps) AS n_tcp_dl, ROUND(AVG(tcp_dl_mbps), 2) AS tcp_dl_mbps, COUNT(tcp_ul_mbps) AS n_tcp_ul, ROUND(AVG(tcp_ul_mbps), 2) AS tcp_ul_mbps,
       ROUND(AVG(udp_dl_mbps), 2) AS udp_dl_mbps, ROUND(AVG(udp_dl_loss_pct), 2) AS udp_dl_loss_pct,
       ROUND(AVG(udp_ul_mbps), 2) AS udp_ul_mbps, ROUND(AVG(udp_ul_loss_pct), 2) AS udp_ul_loss_pct,
       ROUND(AVG(rtt_avg_ms), 1) AS rtt_avg_ms, ROUND(AVG(rtt_median_ms), 1) AS rtt_median_ms, ROUND(AVG(rtt_p95_ms), 1) AS rtt_p95_ms,
       ROUND(AVG(snr_ul_db), 1) AS snr_ul_db, ROUND(AVG(rsrp_dbm), 1) AS rsrp_dbm, ROUND(AVG(dl_mcs), 1) AS dl_mcs, ROUND(AVG(ul_mcs), 1) AS ul_mcs,
       ROUND(AVG(dl_bler), 3) AS dl_bler, ROUND(AVG(ul_bler), 3) AS ul_bler, SUM(CASE WHEN alive_at_end = 0 THEN 1 ELSE 0 END) AS link_dead_at_end
FROM v_measurements WHERE purpose = 'campaign'
GROUP BY campaign, series, medium, antenna_cm, cell_prb, antennas, ue, rf_port ORDER BY first;

CREATE VIEW v_summary_attach AS
SELECT campaign, series, medium, antenna_cm, cell_prb, antennas, ue, policy, wait_s, COUNT(*) AS starts, SUM(attached) AS attached,
       SUM(first_attempt) AS first_attempt, ROUND(100.0 * SUM(first_attempt) / COUNT(*), 1) AS first_attempt_pct,
       ROUND(100.0 * SUM(attached) / COUNT(*), 1) AS attached_pct, ROUND(AVG(CASE WHEN attached = 1 THEN duration_s END), 1) AS mean_duration_s
FROM attach GROUP BY campaign, series, medium, antenna_cm, cell_prb, antennas, ue, policy, wait_s ORDER BY MIN(time);

CREATE VIEW v_summary_acceptance AS
SELECT campaign, medium, antenna_cm, cell_prb, target_dl_mbps, target_ul_mbps, COUNT(*) AS runs, SUM(passed) AS passed,
       SUM(CASE WHEN attempts = 1 THEN 1 ELSE 0 END) AS attached_first_attempt, MIN(time) AS first_run, MAX(time) AS last_run
FROM acceptance GROUP BY campaign, medium, antenna_cm, cell_prb, target_dl_mbps, target_ul_mbps ORDER BY first_run;
