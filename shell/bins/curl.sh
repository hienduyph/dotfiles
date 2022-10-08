#!/usr/bin/env bash

# print out time profiling of a curl request 
#
#```bash
#$ curl -sSL -w "@curl-format.txt" -o /dev/null "http://qparser.tiki.services/nlp/parse\?q\=iphone%2011"
# 
#    time_namelookup:  0.013779
#       time_connect:  0.016925
#    time_appconnect:  0.000000
#   time_pretransfer:  0.016987
#      time_redirect:  0.000000
# time_starttransfer:  0.020264
#                    ----------
#         time_total:  0.020349
#```

TFORMAT='    time_namelookup:  %{time_namelookup}
       time_connect:  %{time_connect}
    time_appconnect:  %{time_appconnect}
   time_pretransfer:  %{time_pretransfer}
      time_redirect:  %{time_redirect}
 time_starttransfer:  %{time_starttransfer}
                    ----------
         time_total:  %{time_total}
'

curl -w "$TFORMAT" "$@"

