#!/bin/sh -e
#    Licensed to the Apache Software Foundation (ASF) under one or more
#    contributor license agreements.  See the NOTICE file distributed with
#    this work for additional information regarding copyright ownership.
#    The ASF licenses this file to You under the Apache License, Version 2.0
#    (the "License"); you may not use this file except in compliance with
#    the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

# 1 - value to search for
# 2 - value to replace
# 3 - file to perform replacement inline
prop_replace () {
  target_file=${3:-${nifi_props_file}}
  echo 'replacing target file ' ${target_file}
  sed -i -e "s|^$1=.*$|$1=$2|"  ${target_file}
}

uncomment() {
	target_file=${2}
	echo "Uncommenting ${target_file}"
	sed -i -e "s|^\#$1|$1|" ${target_file}
}

# Read non-default locations. NIFI_HOME is defined by an ENV command in the backing Dockerfile

if [ ! -z "${NIFIINIT_BOOTSTRAP_FILE_LOCATION}" ]; then
	export nifi_bootstrap_file="${NIFIINIT_BOOTSTRAP_FILE_LOCATION}"
else
	export nifi_bootstrap_file=${NIFI_HOME}/conf/bootstrap.conf
fi

if [ ! -z "${NIFIINIT_PROPS_FILE_LOCATION}" ]; then
        export nifi_props_file="${NIFIINIT_PROPS_FILE_LOCATION}"
else
        export nifi_props_file=${NIFI_HOME}/conf/nifi.properties
fi

if [ ! -z "${NIFIINIT_TOOLKIT_PROPS_FILE_LOCATION}" ]; then
        export nifi_toolkit_props_file="${NIFIINIT_TOOLKIT_PROPS_FILE_LOCATION}"
else
        export nifi_toolkit_props_file=${HOME}/.nifi-cli.nifi.properties
fi

if [ ! -z "${NIFIINIT_HOSTNAME}" ]; then
        export hostname="${NIFIINIT_HOSTNAME}"
else
        export hostname=$(hostname)
fi
