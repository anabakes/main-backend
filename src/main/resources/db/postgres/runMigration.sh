#!/bin/bash
set -e

echo "📦 Running AnaBakes Liquibase migration with liquibase.properties..."

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
JAR_PATH="${SCRIPT_DIR}/lib/liquibase/liquibase.jar"
PICOLI_JAR_PATH="${SCRIPT_DIR}/lib/liquibase/picocli-4.6.1.jar"

# Optional: explicitly point to properties file if not in same dir
DEFAULTS_FILE="--defaultsFile=${SCRIPT_DIR}/liquibase.properties"

java -cp "${PICOLI_JAR_PATH}:${JAR_PATH}" liquibase.integration.commandline.LiquibaseCommandLine \
  ${DEFAULTS_FILE} \
  update

echo "✅ Liquibase migration completed."