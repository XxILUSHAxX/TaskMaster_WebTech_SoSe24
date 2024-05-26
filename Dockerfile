#
#Build stage
#

FROM gradle:jdk21-jammy AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN --network="host" gradle build --no-daemon --warning-mode all

LABEL org.name="ProfWider"

#
#Package stage
#
FROM eclipse-temurin:21-jdk-jammy
COPY --from=build /home/gradle/src/build/libs/TaskMaster_Backend_WebTech_SoSe24-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
