FROM maven:3.6.3 AS maven

WORKDIR /usr/src/app
ADD pom.xml $HOME

# 2. start downloading dependencies

RUN ["/usr/local/bin/mvn-entrypoint.sh", "mvn", "verify", "clean", "--fail-never"]
COPY . /usr/src/app
# Compile and package the application to an executable JAR
RUN mvn package 
RUN ls -la

# For Java 11, 
FROM adoptopenjdk/openjdk11:alpine-jre

ARG JAR_FILE=app-runner.jar
ARG VERSION

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/
RUN echo $VERSION > /opt/app/version.txt

ENTRYPOINT ["java","-jar","app-runner.jar"]
