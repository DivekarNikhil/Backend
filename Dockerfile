# Use an OpenJDK runtime
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml, then build dependencies
COPY mvnw mvnw
COPY mvnw.cmd mvnw.cmd
COPY pom.xml pom.xml
RUN ./mvnw dependency:go-offline -B

# Copy source code and build
COPY src src
RUN ./mvnw clean package -DskipTests

# Expose the port
EXPOSE 10000

# Run the Spring Boot application
CMD ["java", "-jar", "target/course-management-system.jar"]
