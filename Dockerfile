FROM alpine/git as clone
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
RUN git clone https://github.com/yildiz-online/webapp-backend.git

FROM moussavdb/build-java as build
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
COPY --from=clone /app/webapp-backend /app
RUN mvn install -s ../build-resources/settings.xml

FROM moussavdb/runtime-java
MAINTAINER Grégory Van den Borre <vandenborre.gregory@hotmail.fr>
WORKDIR /app
EXPOSE 10201
COPY --from=build /app/target/webapp-backend.jar /app
CMD ["java -jar webapp-backend.jar"]
