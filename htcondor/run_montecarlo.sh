#! /bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# script that initiates the random walk.
# takes one argument which is the index into the sp500.csv to
# identify which stock to simulate.
#
# June 20, 1018
index=$(($1 + 2))
stockfile=companies.csv
stock=$(awk "NR == ${index} {print; exit}" ${stockfile} | cut -d, -f1)
export HOME=`pwd`

chmod +x ./randomwalk.py
./randomwalk.py -c ${stock} --from-csv WIKI_PRICES_2018-01-01.csv > ${stock}.csv
CLOUDSDK_PYTHON=/usr/bin/python gsutil -m cp ${stock}.csv gs://monte2bucket/output/${stock}.csv
