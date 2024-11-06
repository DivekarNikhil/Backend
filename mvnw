#!/bin/sh

# ----------------------------------------------------------------------------
# Apache Maven Wrapper script for cross-platform usage (Windows, Linux, macOS).
# ----------------------------------------------------------------------------

# Function to download and install Maven if not already installed
download_maven() {
  MAVEN_VERSION=3.8.1
  MAVEN_URL="https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin"
  MAVEN_DIR=".mvn/apache-maven-$MAVEN_VERSION"

  # Check if Maven directory exists
  if [ ! -d "$MAVEN_DIR" ]; then
    echo "Maven not found. Downloading Maven $MAVEN_VERSION..."
    if [ "$(uname)" == "Darwin" ]; then
      # macOS
      curl -L $MAVEN_URL.tar.gz | tar xz -C .mvn
    else
      # Linux or Windows (handled differently based on script)
      curl -L $MAVEN_URL.tar.gz | tar xz -C .mvn
    fi
  fi

  export MAVEN_HOME=$MAVEN_DIR
}

# Check if JAVA_HOME is set
if [ -z "$JAVA_HOME" ]; then
  echo "Error: JAVA_HOME is not set!"
  exit 1
fi

# Detect the platform and set appropriate Maven download procedure
case "$(uname)" in
  CYGWIN*|MINGW*|MSYS*)
    # Windows environment (Using Windows batch logic)
    MAVEN_VERSION=3.8.1
    MAVEN_URL="https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.zip"
    MAVEN_DIR=".mvn/apache-maven-$MAVEN_VERSION"

    if [ ! -d "$MAVEN_DIR" ]; then
      echo "Maven not found. Downloading Maven $MAVEN_VERSION for Windows..."
      powershell -Command Invoke-WebRequest -Uri $MAVEN_URL -OutFile apache-maven.zip
      powershell -Command Expand-Archive -Path apache-maven.zip -DestinationPath .mvn
      rm apache-maven.zip
    fi
    export MAVEN_HOME="$MAVEN_DIR"
    MAVEN_CMD="$MAVEN_HOME\\bin\\mvn"
    ;;
  Darwin*)
    # macOS (Using curl to fetch the tar.gz)
    download_maven
    MAVEN_CMD="$MAVEN_HOME/bin/mvn"
    ;;
  Linux*)
    # Linux (Using curl to fetch the tar.gz)
    download_maven
    MAVEN_CMD="$MAVEN_HOME/bin/mvn"
    ;;
  *)
    echo "Unsupported OS: $(uname)"
    exit 1
    ;;
esac

# Execute Maven command with provided arguments
$MAVEN_CMD "$@"
